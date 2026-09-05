# Arquitectura

<p align="center">
<a href="architecture.md">English</a> · <strong>Español</strong> · <a href="architecture.pt-BR.md">Português (BR)</a>
</p>

Cómo está organizado el código y por qué. Para saber qué es la app, mira el
[README](../README.es.md); para configurar y enviar un cambio, mira
[contributing.es.md](contributing.es.md).

## Estructura

```text
lib/
├── main.dart                  Arranque: dotenv, anuncios, preferencias, ProviderScope
├── l10n/                      Archivos ARB y la salida de gen-l10n
└── src/
    ├── flutter_guide_app.dart Widget raíz: tema, locale, router
    ├── core/                  Todo aquello de lo que depende más de una feature
    │   ├── constants/         Códigos de idioma, enlaces externos
    │   ├── di/                Providers de dependencias entre features
    │   ├── enums/             Tipos de componente, de interfaz y de tema
    │   ├── extensions/        Extensiones sobre tipos de Dart y Flutter
    │   ├── helpers/           Parseo y manejo de deep links
    │   ├── models/            Modelos compartidos entre features
    │   ├── navigation/        Notifier del índice de la barra inferior
    │   ├── router/            Configuración de go_router, nombres y rutas
    │   ├── services/          Envoltorios sobre SDKs de plataforma
    │   ├── shell/             Scaffold raíz: app bar y barra inferior
    │   └── theme/             ThemeData y el notifier de tema
    ├── features/              Un directorio por feature, tres capas cada una
    │   ├── catalog/           El catálogo de componentes y las muestras
    │   ├── code_theme_selector/
    │   ├── home/
    │   └── settings/
    └── shared/                Widgets y utilidades usados por varias features
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

[`go_router`](../lib/src/core/router/app_router.dart), con las rutas y los
nombres separados de la configuración en
[`route_paths.dart`](../lib/src/core/router/route_paths.dart) y
[`route_names.dart`](../lib/src/core/router/route_names.dart), para que un
enlace se arme desde una constante y no desde un literal.

`onException` envía una ubicación irresoluble de vuelta a la raíz en lugar de
mostrar una pantalla de error: toda ruta aquí es alcanzable por deep link, y una
desconocida es un enlace viejo, no un fallo sobre el que el usuario pueda
actuar.

Dos rasgos del arreglo actual conviene conocer antes de tocarlo.
`AppRouter.router` es un singleton estático, leído directamente por el widget
raíz y por el cableado de deep links en vez de resolverse por un provider, así
que una prueba no puede sustituirlo: `pump_router_app.dart` conduce el router de
producción y reinicia su ubicación en el `tearDown`. Y la ruta de muestra lee
sus argumentos de `state.extra` con un cast no nulo, así que una entrada que no
los lleve, como un deep link o una pila restaurada, falla ahí.

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

## Persistencia

Solo preferencias del usuario: el tema, el idioma y el tema de código. No hay
base de datos.

[`SharedPreferencesService`](../lib/src/core/services/shared_preferences_service.dart)
envuelve el plugin, y las claves viven en un solo lugar, en
[`shared_preferences_keys.dart`](../lib/src/core/shared_preferences_keys.dart).
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

## Anuncios

`google_mobile_ads`, inicializado en `main.dart` y leído del `.env` mediante
`flutter_dotenv`. Los ids no están en el repositorio; las claves tienen que
existir para que la app se ejecute, y por eso `contributing.es.md` trae un
bloque `.env` con valores vacíos.

La inicialización deliberadamente no se espera: un SDK de anuncios lento en
responder no debe retener el primer frame.

## Pruebas

`test/` refleja `lib/src/`, archivo por archivo. Los dobles son mocks de
`mocktail`, y una dependencia se sustituye mediante un override de
`ProviderContainer`, no alcanzando dentro del árbol de widgets. `test/helpers/`
trae el instrumental: `pumpApp` para un widget bajo un `MaterialApp`
localizado, `pumpScopedApp` para uno que abre contenido en overlay, y
`pump_router_app.dart` para cualquier cosa enrutada.

El gate de cobertura es 90%, medido sobre `lib/` menos las fuentes generadas y
las muestras del catálogo.
