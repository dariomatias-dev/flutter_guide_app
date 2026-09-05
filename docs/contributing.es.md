# Contribuir

<p align="center">
<a href="contributing.md">English</a> · <strong>Español</strong> · <a href="contributing.pt-BR.md">Português (BR)</a>
</p>

Gracias por considerar contribuir. Este documento cubre la configuración, las
verificaciones que un cambio debe pasar y las convenciones con las que se
revisa un pull request.

## Configuración

El proyecto fija la versión del SDK de Flutter con [FVM](https://fvm.app/), así
que todos los comandos de abajo usan `fvm flutter` en lugar de un `flutter`
instalado globalmente. Un `flutter` pelado toma lo que haya en la máquina, que
no es lo que usa la CI.

```bash
git clone https://github.com/dariomatias-dev/flutter_guide_app.git
cd flutter_guide_app
fvm install
fvm flutter pub get
git config core.hooksPath .githooks
```

La última línea activa el hook `commit-msg`, que exige la convención de commits
descrita más abajo.

La app lee sus ids de anuncios de un archivo `.env` en la raíz del repositorio,
que no se versiona. Las claves solo tienen que existir para que la app compile
y se ejecute:

```bash
cat <<'EOF' > .env
DEVICE_ID=
BANNER_AD_ID=
BANNER_AD_SAMPLE_ID=
INTERSTICIAL_AD_SAMPLE_ID=
REWARDED_AD_SAMPLE_ID=
APP_OPEN_AD_SAMPLE_ID=
EOF
```

## Antes de abrir un pull request

- [ ] `./scripts/verify.sh` pasa
- [ ] La lógica nueva tiene pruebas, incluidos los caminos de fallo; una corrección de bug tiene una prueba que falla sin la corrección
- [ ] `test/` sigue reflejando `lib/src/`
- [ ] Las cadenas nuevas visibles para el usuario están en los tres archivos ARB, con `description` en `lib/l10n/app_en.arb`
- [ ] `fvm flutter gen-l10n` ejecutado y su salida commiteada, si cambió algún ARB
- [ ] `dart run build_runner build` ejecutado y su salida commiteada, si cambió alguna ruta en `core/navigation/navigators/`
- [ ] Documentación actualizada en los tres idiomas, si cambió
- [ ] Los commits siguen la convención de abajo

Las reglas estructurales con las que se revisa un cambio están en
[`CLAUDE.md`](../CLAUDE.md): dónde va cada tipo de código, qué hacen distinto
las muestras del catálogo y qué cuenta como efecto colateral. No se repiten
aquí, precisamente para que no se desincronicen.

## El gate local

```bash
./scripts/verify.sh
```

Ejecuta exactamente lo que ejecuta la CI, en el mismo orden:

| Paso | Qué detecta |
| --- | --- |
| `build_runner` y `gen-l10n`, y el diff de su salida | Rutas o localizaciones commiteadas que ya no coinciden con su fuente. La CI regenera desde un checkout limpio y falla ante cualquier diferencia |
| [`check_l10n.sh`](../scripts/check_l10n.sh) | Una clave ausente en un idioma, o una clave de la plantilla sin `description`. `gen-l10n` recurre al inglés en silencio |
| `dart format --set-exit-if-changed` | El formato, la única verificación con una sola respuesta correcta |
| `flutter analyze` | Los lints de `very_good_analysis` |
| `flutter test --coverage` | La suite de pruebas |
| [`check_coverage.sh`](../scripts/check_coverage.sh) | Cobertura de líneas por debajo del 90%, excluyendo fuentes generadas y las muestras del catálogo |

El gate se omite cuando no cambió nada bajo `lib`, `test`, `integration_test`,
`test_driver` ni en los manifiestos. Usa `--all` para ejecutarlo igual, y
`--skip-tests` para una verificación rápida a mitad de camino, nunca como la
final.

Una ejecución aprobada guarda el hash del árbol en `.dart_tool/verify_stamp`,
para que las herramientas sepan si el árbol sigue coincidiendo con una
ejecución que pasó.

## Qué verifica la CI

| Job | Qué hace | Merge |
| --- | --- | --- |
| `Vulnerabilities` | Ejecuta `osv-scanner` contra `pubspec.lock`, que es lo que realmente se entrega, y no los rangos de caret de `pubspec.yaml`. Independiente de los demás jobs: una advertencia recién publicada no es razón para silenciar las pruebas | Bloquea |
| `flutter_guide` | El gate de arriba, paso por paso | Bloquea |
| `Build APK` | Se ejecuta después de que `flutter_guide` pase y construye un APK de release, publicado como artefacto durante 14 días. Sin keystore en el checkout, recurre a las claves de debug | Bloquea |
| Subida a Codecov | Reporta el delta de cobertura en el pull request, con anotaciones en línea | Solo reporta |

La versión del SDK viene de `.fvmrc`, leída con `jq` al inicio de cada job, en
lugar de repetirse en el workflow. Es una divergencia deliberada del patrón
habitual `env: FLUTTER_VERSION`: dos copias de una versión se desincronizan, y
entonces el pipeline sigue compilando con una versión que nadie usa.

### Informes de cobertura

[`check_coverage.sh`](../scripts/check_coverage.sh) es lo que reprueba la
build; Codecov es lo que hace legible el número. `codecov.yml` guarda el
objetivo y repite las exclusiones del script: fuentes generadas, `lib/l10n/` y
las muestras del catálogo en `lib/src/features/catalog/data/samples/`. Esas
muestras son código didáctico que la app le muestra al usuario, y sus 6967
líneas arrastran la cifra del 95% al 24% sin decir nada sobre la app en sí.

Las subidas se autentican con el secret `CODECOV_TOKEN`. Un pull request desde
un fork no puede leerlo, así que el paso usa `fail_ci_if_error: false`: una
subida fallida es un informe ausente, nunca una build reprobada.

### Publicaciones

Las releases las corta [release-please](https://github.com/googleapis/release-please).
Lee los Conventional Commits que entraron en `main` y mantiene abierto un pull
request con la próxima versión y la entrada de `CHANGELOG.md` derivada de
ellos: `fix:` sube el patch, `feat:` el minor, y `!` antes de los dos puntos el
major. Mergear ese pull request escribe la versión en `pubspec.yaml`, etiqueta
el commit y publica la release en GitHub.

`release.yml` luego ejecuta el mismo gate que la CI, construye el APK y el app
bundle, y adjunta ambos. Lo llama directamente `release_please.yml`, porque
GitHub no inicia un workflow a partir de una etiqueta enviada con el token por
defecto, y aun así responde a una etiqueta `v*.*.*` enviada a mano.

La build de release se firma con la upload key, armada a partir de secrets del
repositorio y borrada del runner después. El job falla en lugar de recurrir a
las claves de debug, porque un artefacto firmado en debug no se puede subir a
la Play Store ni instalar sobre la build de la tienda. La publicación en la
Play Store sigue siendo manual: descarga el `.aab` de la release y súbelo allí.

| Secret | Para qué sirve |
| --- | --- |
| `ANDROID_KEYSTORE_BASE64` | La upload keystore en base64: `base64 -w0 upload-keystore.jks` |
| `ANDROID_KEYSTORE_PASSWORD` | Su contraseña de store |
| `ANDROID_KEY_ALIAS` | El alias de la clave dentro de la keystore |
| `ANDROID_KEY_PASSWORD` | La contraseña de la clave |
| `BANNER_AD_ID`, `BANNER_AD_SAMPLE_ID`, `INTERSTICIAL_AD_SAMPLE_ID`, `REWARDED_AD_SAMPLE_ID`, `APP_OPEN_AD_SAMPLE_ID` | Los ids de anuncios escritos en el `.env` de la build de release |
| `CODECOV_TOKEN` | La subida de cobertura en la CI |

### Ejecutar los workflows localmente

[`act`](https://github.com/nektos/act) ejecuta los workflows en Docker, lo que
conviene hacer antes de enviar cualquier cambio en `.github/workflows/`.
`.actrc` ya fija la imagen del runner, así que no hacen falta flags:

```bash
act -l                            # lista todos los jobs, con id y etapa
act pull_request                  # todo lo que la CI ejecutaría en un pull request
act pull_request -j app           # un job, por su id
act pull_request -j app --dryrun  # imprime los pasos sin ejecutarlos
```

`-j` recibe el id del job (`vulnerabilities`, `app`, `build_apk`), no el nombre
mostrado; `act -l` imprime ambos. La primera ejecución descarga una imagen de
varios gigabytes, y `act` aproxima los runners de GitHub en vez de
reproducirlos, así que una ejecución verde aquí es una señal, no una garantía:
`secrets.CODECOV_TOKEN` está vacío localmente, y el escáner OSV necesita red
para consultar la base de advertencias.

## Trabajar con un agente de IA

El repositorio lleva su propia configuración de agente, para que un asistente
siga el mismo proceso que un contribuidor en lugar de improvisar uno por
prompt:

- [`CLAUDE.md`](../CLAUDE.md) es el acuerdo de trabajo: el ciclo de cada
  cambio, dónde va cada tipo de código, qué hacen distinto las muestras del
  catálogo y qué es innegociable.
- `.claude/hooks/format-dart.sh` formatea el archivo Dart justo después de
  escribirlo.
- `.claude/hooks/verify-gate.sh` se niega a terminar un turno que deja código
  que el gate no aprobó.

Cambiar el acuerdo es un cambio normal, revisado como cualquier otro.

## Actualización de dependencias

[Renovate](https://docs.renovatebot.com) abre los pull requests de
actualización semanalmente, con el prefijo `build(deps):` para que pasen el
hook de mensaje y alimenten a release-please. `renovate.json` guarda las
reglas, y la issue del dependency dashboard lista todo lo que está reteniendo.

Renovate en lugar de Dependabot porque solo Renovate puede desactivar o agrupar
actualizaciones por nombre de paquete. Hoy existen dos reglas: `intl` lo dicta
el `flutter_localizations` que viene con el SDK fijado, así que se mueve con el
SDK; y `go_router` se mueve junto con su generador de rutas, ya que un desfase
entre ambos rompe la generación de código, no el análisis. Nunca ejecutes los
dos bots.

Un pull request de actualización se tría como cualquier otro cambio: el gate
tiene que pasar, y un bump que cambia comportamiento exige revisar ese
comportamiento, no solo un pipeline verde.

## Convención de commits

Este proyecto sigue [Conventional Commits](https://www.conventionalcommits.org):

```
<type>(<scope>): <subject>

<cuerpo opcional, explicando el porqué>
```

El hook `commit-msg` exige todas las reglas de abajo.

- **type**: `feat`, `fix`, `refactor`, `docs`, `style`, `test`, `chore`, `perf`, `build`, `ci`, `revert`
- **scope**: opcional, en minúsculas, entre paréntesis, por ejemplo `catalog`, `theme`
- **breaking change**: `!` antes de los dos puntos, por ejemplo `refactor(nav)!: drop the untyped router`
- **subject**: en imperativo, empezando en minúscula, sin punto final
- **línea de subject**: como máximo 72 caracteres, incluidos type y scope
- **línea en blanco** entre el subject y el cuerpo
- **cuerpo**: ajustado a 80 columnas, salvo URLs, trailers de git como
  `Co-Authored-By:` o `Refs #123`, y bloques de código cercados

El cuerpo es opcional y existe para el *porqué*. El diff ya muestra qué cambió.

## Ramas

- `main` está protegida: sin pushes directos, merge solo vía pull request.
- Nombres de rama: `<type>/<descripción-corta>`, por ejemplo
  `feat/table-sample`, `fix/dropdown-alignment`.

## Pull requests

- Un cambio lógico por pull request; mantenlo pequeño y revisable.
- Merge solo por squash o rebase, sin merge commits, para que el historial siga
  siendo lineal y cada entrada sea un Conventional Commit válido.
- En este repositorio (un solo mantenedor), el self-merge tras pasar la CI está
  permitido; la protección de rama sigue exigiendo el flujo de pull request y
  las verificaciones en verde.

## Código de Conducta

La participación en este proyecto se rige por el
[Código de Conducta](code_of_conduct.es.md). Los reportes de seguridad siguen
la [política de seguridad](security.es.md), nunca una issue pública.
