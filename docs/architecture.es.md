# Arquitectura

<p align="center">
<a href="architecture.md">English</a> · <strong>Español</strong> · <a href="architecture.pt-BR.md">Português (BR)</a>
</p>

Cómo está organizado el código y por qué. Para saber qué es la app, mira el
[README](../README.es.md); para configurar y enviar un cambio, mira
[contributing.es.md](contributing.es.md).

## Estructura

```text
packages/app_ui/     Tokens de diseño y widgets sin acoplamiento a la app, pubspec propio
lib/
├── main.dart                  Arranque: dotenv, anuncios, preferencias, ProviderScope
├── l10n/                      Archivos ARB y la salida de gen-l10n
└── src/
    ├── flutter_guide_app.dart Widget raíz: tema, locale, router
    ├── core/                  Todo aquello de lo que depende más de una feature
    │   ├── config/            El contrato de entorno y su lector de dotenv
    │   ├── constants/         Códigos de idioma, enlaces externos
    │   ├── di/                Providers de dependencias entre features
    │   ├── enums/             Tipos de componente, de interfaz y de tema
    │   ├── errors/            La frontera de fallos y el reporter de errores
    │   ├── extensions/        Extensiones sobre tipos de Dart y Flutter
    │   ├── helpers/           Parseo y manejo de deep links
    │   ├── models/            Modelos compartidos entre features
    │   ├── navigation/        Notifier del índice de la barra inferior, clases de ruta tipadas
    │   ├── router/            El provider de GoRouter, armado a partir de esas rutas
    │   ├── services/          Envoltorios sobre SDKs de plataforma
    │   ├── shell/             Scaffold raíz: app bar y barra inferior
    │   ├── theme/             ThemeData y el notifier de tema
    │   └── widgets/           Pantallas que se muestran cuando la app falla
    ├── features/              Un directorio por feature, tres capas cada una
    │   ├── catalog/           El catálogo de componentes y las muestras
    │   ├── code_theme_selector/
    │   ├── home/
    │   └── settings/
    └── shared/                Widgets y utilidades que leen estado de la app
```

Cada feature tiene las mismas tres capas, y solo las que tengan contenido:

```text
features/<feature>/
├── data/          Implementaciones de repositorio, data sources, models
├── domain/        Contratos de repositorio y entidades
└── presentation/  Pantallas, widgets, view models, providers
```

## Capas

La dirección de la dependencia es una sola: `presentation` depende de `domain`,
`data` implementa `domain`, y `domain` no depende de ninguno. Una pantalla nunca
alcanza un data source directamente; lee un view model, que tiene un contrato de
repositorio, implementado en `data`, que llega al mundo exterior a través de un
service en [`core/services/`](../lib/src/core/services).

`core/` es para lo que necesita más de una feature. Un archivo usado por
exactamente una feature pertenece a esa feature, aunque parezca genérico.
`shared/` guarda widgets y helpers sin feature propia, como
[`card_widget`](../lib/src/shared/widgets/card_widget) y
[`open_url`](../lib/src/shared/utils/open_url).

`Widget` nunca cruza a `domain` ni a `data`. Por eso la resolución de las
muestras vive en la capa de presentación, en
[`sample_registry.dart`](../lib/src/features/catalog/presentation/samples/sample_registry.dart),
aunque las listas de muestras que lee sean datos.

## Arranque y fallos

[`main.dart`](../lib/main.dart) instala los manejadores de error antes de
cualquier cosa que pueda fallar, y luego ejecuta la secuencia de arranque
dentro de una guarda.

- [`installErrorHandlers`](../lib/src/core/errors/error_handlers.dart) conecta
  los dos canales por los que Flutter reporta: `FlutterError.onError` para
  build, layout y paint, y `PlatformDispatcher.instance.onError` para los
  errores asíncronos que se escapan de un future. Conectar solo el primero deja
  mudo al segundo.
- `ErrorWidget.builder` se reemplaza por
  [`AppFailureScreen`](../lib/src/core/widgets/app_failure_screen.dart), para
  que un widget que lanza en una build de release muestre algo inteligible en
  vez de un recuadro gris, y nunca un stack trace.
- La secuencia de arranque, el entorno, las preferencias y el SDK de anuncios,
  corre dentro de un `try`. Sin guarda, cualquiera de los tres aborta antes de
  `runApp` y deja una pantalla negra sin nada que hacer. El catch reporta el
  fallo y muestra la misma pantalla con un reintento que vuelve a ejecutar toda
  la secuencia.
- Los fallos viajan por
  [`ErrorReporter`](../lib/src/core/errors/error_reporter.dart), un contrato
  con una implementación sobre `Logger` detrás de `errorReporterProvider`, así
  que el destino de un reporte puede cambiar sin tocar ningún call site.

## Gestión de estado

Riverpod, con providers escritos a mano en lugar de generados. Una pantalla
observa un view model; un view model es un `Notifier` o `AsyncNotifier` que lee
su repositorio a través de un provider y expone el estado.

Los providers se agrupan por lo que conectan, no por su tipo:

- [`core/di/`](../lib/src/core/di) tiene los que cruzan features:
  preferencias, tema, índice de la barra inferior y si los anuncios están
  activos.
- `features/<feature>/presentation/providers/` tiene los propios de cada
  feature.

[`sharedPreferencesProvider`](../lib/src/core/di/shared_preferences_provider.dart)
se declara sin valor y se sobrescribe en `main.dart` con la instancia que el
arranque ya esperó. Eso mantiene síncrono el resto del grafo: nada aguas abajo
tiene que ser un `FutureProvider` solo porque el almacenamiento se abrió de
forma asíncrona, y una prueba sobrescribe el mismo provider con un mock.

[`adsEnabledProvider`](../lib/src/core/di/ads_enabled_provider.dart) existe para
que la captura de pantallas pueda ponerlo en `false`. Una imagen de marketing no
debe llevar un banner de anuncio, y un override sale más barato que un flag de
build.

## Navegación

[`go_router`](../lib/src/core/router/app_router.dart), configurado a partir de
rutas tipadas generadas por `go_router_builder`. Cada ruta es una subclase de
`GoRouteData` en
[`core/navigation/navigators/`](../lib/src/core/navigation/navigators), un
archivo por feature, con una directiva `part 'x.g.dart';`; `dart run
build_runner build` escribe el archivo compañero, que se commitea como la
salida de l10n y se verifica de la misma forma en `verify.sh` y en la CI.

`appRouterProvider` es un `Provider<GoRouter>` simple (no auto-descartado),
leído una vez por el widget raíz y por el cableado de deep links. Ser un
provider en lugar de un campo estático es lo que permite a una prueba
sustituirlo, o armar uno desde un `ProviderContainer` nuevo por prueba, como
hace [`pump_router_app.dart`](../test/helpers/pump_router_app.dart).

`onException` envía una ubicación irresoluble de vuelta a la raíz en lugar de
mostrar una pantalla de error: toda ruta aquí es alcanzable por deep link, y una
desconocida es un enlace viejo, no un fallo sobre el que el usuario pueda
actuar.

La ruta de muestra lleva sus argumentos por el `extra` de go_router,
declarado como un campo `$extra` nulable en `ComponentSampleRoute`. `extra`
solo lo llena un `push` dentro de la app, nunca un deep link ni una pila de
navegación restaurada, los dos casos que lo dejan en `null`; el `redirect` de
la ruta manda ese caso de vuelta a la raíz, en lugar de que el código generado
fuerce un cast de un `extra` nulo, que es lo que un campo no nulable seguiría
haciendo.

## Deep links

[`DeepLinkService`](../lib/src/core/services/deep_link_service.dart) escucha
`app_links` y reenvía cada URI a
[`DeepLinkHandler`](../lib/src/core/helpers/deep_link_handler.dart), que la
resuelve en un
[`DeepLinkTarget`](../lib/src/core/helpers/deep_link_target.dart) y navega.

`DeepLinkTarget` es una sealed class de datos puros, sin efectos secundarios. El
parseo es la parte con casos borde, así que está separado de la navegación y la
localización y se prueba por su cuenta; al handler le queda la parte que
necesita un `BuildContext`.

El plugin en sí queda detrás de
[`DeepLinkSource`](../lib/src/core/services/deep_link_source.dart), resuelto
mediante `deepLinkSourceProvider`. Por dos razones: la capa de widgets no tiene
por qué saber qué plugin entrega un enlace, y `AppLinks` es un singleton de
proceso que deja de retransmitir cuando su último oyente se da de baja, lo que
lo vuelve imposible de manejar desde más de una prueba. El widget raíz
cancela la suscripción en `dispose`, ya que el handler retiene el router y el
container de providers del árbol que lo creó.

## Persistencia

Solo preferencias del usuario: el tema, el idioma y el tema de código. No hay
base de datos.

[`SharedPreferencesService`](../lib/src/core/services/shared_preferences_service.dart)
envuelve el plugin, y las claves viven en un solo lugar, en
[`shared_preferences_keys.dart`](../lib/src/core/constants/shared_preferences_keys.dart).
Un repositorio habla con el service, nunca con `SharedPreferences` directamente,
que es lo que permite a una prueba cambiar el almacenamiento sin tocar el
plugin.

El repositorio de idioma mapea un `pt_BR` almacenado a `pt` al leer. Las
versiones anteriores a la eliminación del ARB con región escribían ese valor,
que ya no coincide con ninguna entrada de `Language.all`, así que sin el mapeo
una actualización reiniciaría en silencio el idioma del usuario al inglés.

## Tema

[`theme.dart`](../lib/src/core/theme/theme.dart) guarda el `ThemeData` claro y
oscuro, y [`ThemeNotifier`](../lib/src/core/theme/theme_notifier.dart) guarda el
modo elegido y lo persiste. El tema de código es una feature aparte, porque es
otra elección con otro conjunto de opciones: selecciona la paleta que usa
`flutter_syntax_highlighter` al renderizar una muestra.

## Sistema de diseño (`packages/app_ui`)

Un paquete de Flutter aparte, agregado como dependencia `path` en
`pubspec.yaml`, que guarda lo que no tiene ningún acoplamiento con esta app:
los tokens de diseño (`AppSpacing`, `AppRadius`, `AppDurations`, la paleta de
colores) y los widgets construidos solo a partir de ellos y de Flutter mismo,
exportados mediante
[`app_ui.dart`](../packages/app_ui/lib/app_ui.dart) e importados como
`package:app_ui/app_ui.dart`.

El límite se impone por lo que un archivo puede importar, no por un lint:
nada bajo `packages/app_ui/lib/` puede importar `flutter_guide/`, leer un
provider de Riverpod ni leer `AppLocalizations`. Un widget que necesite
cualquiera de esas cosas es código de la app, no del sistema de diseño, y se
queda en `lib/src/shared/`, sin importar cuán genérico parezca.
`ChangeThemeButtonWidget` es el ejemplo concreto: lee `themeNotifierProvider`
y `AppLocalizations` directamente, así que se queda en la app en vez de
forzarlo dentro de `app_ui` con un parámetro incómodo por cada valor que
antes leía por sí mismo. `StandardAppBarWidget` lo incorpora, y se queda a su
lado por la misma razón.

`packages/app_ui` tiene su propio `pubspec.yaml`, `analysis_options.yaml` y
`test/`, con un gate independiente en un umbral de cobertura del 98% en
[`scripts/verify.sh`](../scripts/verify.sh), que lo ejecuta cuando un cambio
toca `packages/app_ui/*`, y en la CI como job propio, reportando bajo la flag
`app_ui` de Codecov.

## Localización

Tres idiomas: inglés, español y portugués. Los archivos ARB son solo de idioma,
sin región, para que un dispositivo pt-PT reciba portugués en vez de caer al
inglés.

`app_en.arb` es la plantilla y lleva una `description` en cada clave, que es el
único contexto que recibe un traductor.
[`check_l10n.sh`](../scripts/check_l10n.sh) exige tanto las descripciones como
la paridad de claves, porque `gen-l10n` recurre a la plantilla en silencio
cuando falta una clave en un idioma.

La salida generada se commitea, y la CI la regenera para probar que el commit
coincide con su fuente.

## Las muestras del catálogo

[`features/catalog/data/samples/`](../lib/src/features/catalog/data/samples)
tiene 226 archivos, y son el producto: el código que la app le muestra al
usuario como material didáctico. Son datos, no código de la app, y siguen reglas
distintas a propósito.

- **Los literales quedan a la vista.** Una muestra que lee un token de espaciado
  enseña un token cuyo valor el lector no puede ver.
- **Quedan fuera del gate de cobertura.** Sus 6967 líneas cubribles arrastran la
  cifra del 95% al 24% sin decir nada sobre la app. La exclusión vive en
  [`check_coverage.sh`](../scripts/check_coverage.sh) y se repite en
  `codecov.yml`.
- **Registro, no cableado.** Una muestra es un `ComponentModel` en
  `sample_definitions/`, nombrado por una constante en `sample_names/`, y
  resuelto por `SampleRegistry`. Añadir una significa añadir una entrada de
  lista.

`sample_registry_test.dart` resuelve todo componente registrado, así que una
muestra ausente de una lista de definición falla ahí, y no en tiempo de
ejecución.

## Configuración

Los ids de unidades de anuncio y de dispositivos de prueba vienen de un asset
`.env`, leído mediante [`AppEnv`](../lib/src/core/config/app_env.dart) en vez
de llamar a `flutter_dotenv` donde hace falta el valor.

Una clave ausente es un valor ausente, nunca una excepción. Un clon nuevo y la
CI no traen `.env` y la app igual tiene que correr ahí, así que
`BannerAdWidget` no renderiza nada cuando falta el id, que es lo mismo que
produce un scope con los anuncios apagados.

## Anuncios

`google_mobile_ads`, inicializado en `main.dart` y leído del `.env` mediante
`flutter_dotenv`. Los ids no están en el repositorio; las claves tienen que
existir para que la app se ejecute, y por eso `contributing.es.md` trae un
bloque `.env` con valores vacíos.

La inicialización deliberadamente no se espera: un SDK de anuncios lento en
responder no debe retener el primer frame.

`BannerAdWidget` es el único widget que importa un SDK de plataforma directo,
en vez de alcanzarlo por un contrato en `core/services/` como hacen los enlaces
y las preferencias. `google_mobile_ads` renderiza mediante una platform view que
la capa de widgets tiene que sostener, así que el envoltorio sería un
pass-through alrededor de un `Widget`. En su lugar está cercado:
`adsEnabledProvider` lo apaga, y con los anuncios apagados nada en el árbol toca
el SDK, que es lo que permite a cada prueba de widget y a la corrida de capturas
renderizar sin él.

## Pruebas

`test/` refleja `lib/src/`, archivo por archivo. Los dobles son mocks de
`mocktail`, y una dependencia se sustituye mediante un override de
`ProviderContainer`, no alcanzando dentro del árbol de widgets. `test/helpers/`
trae el instrumental: `pumpApp` para un widget bajo un `MaterialApp`
localizado, `pumpScopedApp` para uno que abre contenido en overlay, y
`pump_router_app.dart` para cualquier cosa enrutada.

El gate de cobertura es 95%, medido sobre `lib/` menos las fuentes generadas y
las muestras del catálogo.

[`integration_test/screenshot_test.dart`](../integration_test/screenshot_test.dart)
se ejecuta en un emulador Android real en la CI, en su propio job. Existe
para capturar capturas de pantalla de marketing, no como sustituto de las
pruebas de widget, pero ejecutarlo en la CI también prueba que la app arranca
y cada pantalla que visita se renderiza en un dispositivo real: `dotenv`,
`SharedPreferences` y todo el grafo de Riverpod corren de verdad ahí, nada de
eso simulado.
