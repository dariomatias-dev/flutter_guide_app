<br>
<div align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart">
  <img src="https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white" alt="Android">
</div>
<br>

<div align="center">
  <a href="https://github.com/dariomatias-dev/flutter_guide_app/actions/workflows/ci.yaml">
    <img src="https://github.com/dariomatias-dev/flutter_guide_app/actions/workflows/ci.yaml/badge.svg" alt="CI">
  </a>
  <a href="https://codecov.io/gh/dariomatias-dev/flutter_guide_app">
    <img src="https://codecov.io/gh/dariomatias-dev/flutter_guide_app/branch/main/graph/badge.svg" alt="Cobertura">
  </a>
  <img src="https://img.shields.io/badge/lints-very__good__analysis-blueviolet?style=flat" alt="very_good_analysis">
  <a href="LICENSE">
    <img src="https://img.shields.io/badge/license-MIT-green.svg" alt="Licencia MIT">
  </a>
</div>
<br>

<p align="center">
  <a href="README.md">English</a> · <strong>Español</strong> · <a href="README.pt-BR.md">Português (BR)</a>
</p>

<h1 align="center">FlutterGuide</h1>

<p align="center">
  Una aplicación Android para explorar widgets, funciones y paquetes de Flutter/Dart, cada uno con código ejecutable y una vista previa en vivo.
  <br>
  <a href="#acerca-del-proyecto"><strong>Explora la documentación »</strong></a>
  <br>
  <br>
  <a href="https://github.com/dariomatias-dev/flutter_guide_app/issues">Reportar un Error</a>
  ·
  <a href="https://github.com/dariomatias-dev/flutter_guide_app/issues">Solicitar una Función</a>
</p>

## Tabla de Contenidos

- [Acerca del Proyecto](#acerca-del-proyecto)
- [Vista Previa](#vista-previa)
- [Características](#características)
- [El Catálogo](#el-catálogo)
- [Tecnologías](#tecnologías)
- [Arquitectura](#arquitectura)
- [Primeros Pasos](#primeros-pasos)
- [Scripts](#scripts)
- [Pruebas](#pruebas)
- [Despliegue](#despliegue)
- [Documentación](#documentación)
- [Contribuir](#contribuir)
- [Seguridad](#seguridad)
- [Licencia](#licencia)
- [Autor](#autor)

## Acerca del Proyecto

**FlutterGuide** es un catálogo móvil de piezas de Flutter y Dart para desarrolladores que aprenden con ejemplos. Cada elemento (widget, función o paquete) incluye su código fuente y una vista previa interactiva en vivo, renderizada dentro de la propia app, para ver el comportamiento antes de copiarlo a otro proyecto.

La app está publicada en [Google Play](https://play.google.com/store/apps/details?id=com.dariomatias.flutter_guide), y el sitio web está en [flutterguide.app](https://flutterguide.app).

## Vista Previa

<div align="center">
  <img src="screenshots/en/01_home.png" width="200" alt="Inicio">
  <img src="screenshots/en/05_component_detail.png" width="200" alt="Vista previa del componente">
  <img src="screenshots/en/06_component_code.png" width="200" alt="Código del componente">
  <br>
  <sub>La pantalla de inicio, la vista previa de un componente y su código fuente.</sub>
</div>

## Características

- **Vistas previas en vivo con código fuente**: cada widget, función y paquete muestra su código ejecutable junto a una vista previa interactiva y un enlace a la documentación oficial.
- **Elementos y ejemplos de UI**: pantallas de ejemplo completas (inicio de sesión, chat, cliente de correo y otras) y elementos de interfaz reutilizables para estudiar o copiar.
- **Deep linking**: abre un componente o ejemplo específico desde un enlace compartido.
- **Selector de tema de código**: elige el tema de resaltado de sintaxis de los ejemplos de código, con variantes clara y oscura.
- **Favoritos**: guarda cualquier widget, función o paquete para después.
- **Búsqueda**: filtra cada catálogo por nombre mientras escribes.
- **Idiomas**: inglés, portugués (Brasil) y español.
- **Tema claro y oscuro**, con la elección guardada.
- **Accesibilidad**: etiquetas semánticas en los elementos interactivos para lectores de pantalla.

## El Catálogo

Los widgets son Material y Cupertino, las funciones son funciones esenciales de Dart y los paquetes son bibliotecas de terceros, entre ellos `dio`, `http`, `cached_network_image`, `flutter_svg`, `video_player`, `flutter_animate`, `photo_view` y `shimmer`. Los elementos son piezas de interfaz reutilizables y los ejemplos de UI son pantallas completas.

| Categoría      | Cantidad |
| -------------- | -------- |
| Widgets        | 142      |
| Paquetes       | 46       |
| Funciones      | 13       |
| Elementos      | 9        |
| Ejemplos de UI | 5        |
| **Total**      | **215**  |

## Tecnologías

- **Framework**: [Flutter](https://flutter.dev/) y [Dart](https://dart.dev/)
- **Estado e inyección de dependencias**: [Riverpod](https://riverpod.dev/)
- **Enrutamiento y deep links**: [go_router](https://pub.dev/packages/go_router) y [app_links](https://pub.dev/packages/app_links)
- **Persistencia**: [shared_preferences](https://pub.dev/packages/shared_preferences)
- **Localización**: [intl](https://pub.dev/packages/intl) y las herramientas de `l10n` nativas de Flutter
- **Ejemplos de código**: [flutter_syntax_highlighter](https://pub.dev/packages/flutter_syntax_highlighter)
- **Monetización**: [google_mobile_ads](https://pub.dev/packages/google_mobile_ads)
- **Calidad**: [mocktail](https://pub.dev/packages/mocktail), [very_good_analysis](https://pub.dev/packages/very_good_analysis) y [FVM](https://fvm.app/) para fijar el SDK

## Arquitectura

La app está organizada por feature (`lib/src/features/`: `catalog`, `home`, `settings` y `code_theme_selector`), cada una dividida en `data`, `domain` y `presentation`, con Riverpod para el estado y go_router para el enrutamiento. El código transversal vive en `lib/src/core`, y el sistema de diseño en `packages/app_ui`, un paquete aparte cuyo `pubspec.yaml` no depende de la app, por lo que el compilador rechaza cualquier import hacia ella.

Las reglas de capas, los subsistemas y las decisiones detrás de ellos están en [docs/architecture.es.md](docs/architecture.es.md).

## Primeros Pasos

Requisitos: [FVM](https://fvm.app/), que fija la versión del Flutter SDK del proyecto, Git, y un dispositivo o emulador Android. Todos los comandos siguientes usan `fvm flutter` en lugar de un `flutter` a secas.

El archivo `.env` está en `.gitignore`; deja los valores vacíos para ejecutar sin anuncios.

```sh
git clone https://github.com/dariomatias-dev/flutter_guide_app.git
cd flutter_guide_app
fvm install
fvm flutter pub get
cat > .env <<'EOF'
DEVICE_ID=
BANNER_AD_ID=
BANNER_AD_SAMPLE_ID=
INTERSTICIAL_AD_SAMPLE_ID=
REWARDED_AD_SAMPLE_ID=
APP_OPEN_AD_SAMPLE_ID=
EOF
fvm flutter run
```

## Scripts

Los scripts de ayuda viven en `scripts/`, en orden de uso: primero desarrollo, luego calidad.

| Comando                                           | Descripción                                                                                                                                                                                                                                                                      |
| ------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `scripts/screenshot.sh [device-id]`               | Recorre las pantallas principales de la app en un dispositivo conectado, en los tres idiomas, guardando las capturas en `screenshots/<locale>/`. Ejecuta `fvm flutter devices` para listar los ids de dispositivos.                                                              |
| `scripts/verify.sh [--all] [--skip-tests]`        | Ejecuta lo que ejecuta la CI: regenera código y localizaciones (falla si la salida commiteada estaba desactualizada), luego paridad de ARB, format, analyze, pruebas y cobertura. `--all` verifica todo; `--skip-tests` es para revisiones a mitad de un cambio, nunca la final. |
| `scripts/check_l10n.sh [arb-dir]`                 | Falla cuando los archivos ARB difieren en sus claves o una clave de la plantilla no tiene descripción. `gen-l10n` recurre a la plantilla en silencio, así que nada más lo detecta.                                                                                               |
| `scripts/check_coverage.sh <lcov-file> <minimum>` | Falla cuando la cobertura de líneas queda bajo el mínimo, excluyendo las fuentes generadas y las muestras del catálogo, que son material didáctico y no lógica de la app.                                                                                                        |

## Pruebas

Las pruebas unitarias y de widgets viven en `test/`, reflejando `lib/src/`, y usan `mocktail` con overrides de `ProviderContainer`. `packages/app_ui` se prueba por su cuenta, y una prueba de integración recorre la app en un dispositivo para capturar las pantallas.

```sh
fvm flutter test                                                       # la app
(cd packages/app_ui && fvm flutter test)                               # el sistema de diseño
fvm flutter test integration_test/screenshot_test.dart -d <device-id>  # capturas, en un dispositivo conectado
./scripts/verify.sh                                                    # el mismo gate que ejecuta la CI
```

El gate falla ante código o localizaciones generados desactualizados, archivos ARB desalineados, formato, advertencias del analizador, pruebas fallidas y cobertura bajo el umbral. Consulta [docs/contributing.es.md](docs/contributing.es.md) para los umbrales y para saber qué job de la CI bloquea un merge.

## Despliegue

FlutterGuide funciona en Android y está publicada en Google Play. Cada pull request y cada push a `main` ejecuta el pipeline de CI, y cada job bloquea el merge (el gate de calidad de la app y de `packages/app_ui`, el análisis de vulnerabilidades de dependencias, la compilación del APK de release y la ejecución de la prueba de integración en un emulador), salvo la subida de cobertura, que solo reporta.

Las publicaciones las corta release-please: lee los Conventional Commits que llegaron a `main`, mantiene abierto un pull request con la próxima versión y la entrada de `CHANGELOG.md`, y al hacer merge etiqueta el commit y adjunta el APK firmado y el app bundle a la release de GitHub. Subir el bundle a Google Play es manual. Los detalles están en [docs/contributing.es.md](docs/contributing.es.md).

## Documentación

| Documento                                        | Qué cubre                                                                                        |
| ------------------------------------------------ | ------------------------------------------------------------------------------------------------ |
| [Arquitectura](docs/architecture.es.md)          | Estructura, reglas de capas y la decisión detrás de cada subsistema                              |
| [Contribuir](docs/contributing.es.md)            | Configuración, el gate local, qué verifica la CI, publicaciones y la convención de commits       |
| [Política de seguridad](docs/security.es.md)     | Cómo reportar una vulnerabilidad en privado, y qué está dentro del alcance                       |
| [Código de Conducta](docs/code_of_conduct.es.md) | El comportamiento esperado en los espacios del proyecto                                          |
| [Acuerdo de trabajo](CLAUDE.md)                  | El proceso que sigue todo cambio, venga de una persona o de un agente (en inglés)                |
| [Sistema de diseño](packages/app_ui/README.md)   | Qué contiene `packages/app_ui` y el límite que lo mantiene sin acoplamiento a la app (en inglés) |

## Contribuir

Las contribuciones son bienvenidas. Antes de abrir un pull request, ejecuta el gate local, que corre las mismas verificaciones que la CI:

```sh
./scripts/verify.sh
```

Consulta [docs/contributing.es.md](docs/contributing.es.md) para la configuración, la convención de commits y las reglas de ramas. La participación se rige por el [Código de Conducta](docs/code_of_conduct.es.md).

## Seguridad

¿Encontraste una vulnerabilidad? No abras una issue pública: sigue la [política de seguridad](docs/security.es.md).

## Licencia

Distribuido bajo la **Licencia MIT**. Consulta el archivo [LICENSE](LICENSE) para más información.

## Autor

Desarrollado por **Dário Matias Sales**:

- **Portafolio**: [dariomatias-dev](https://dariomatias-dev.com)
- **GitHub**: [dariomatias-dev](https://github.com/dariomatias-dev)
- **Email**: [dariomatias.dev@gmail.com](mailto:dariomatias.dev@gmail.com)
- **Instagram**: [@dariomatias_dev](https://instagram.com/dariomatias_dev)
- **LinkedIn**: [linkedin.com/in/dariomatias-dev](https://linkedin.com/in/dariomatias-dev)
