# Política de Seguridad

<p align="center">
<a href="security.md">English</a> · <strong>Español</strong> · <a href="security.pt-BR.md">Português (BR)</a>
</p>

## Versiones soportadas

FlutterGuide se mantiene en una sola línea de desarrollo. La versión soportada
es la rama `main` actual y la última publicación en Google Play. Las
correcciones llegan ahí y no se retroportan a versiones anteriores.

## Cómo reportar una vulnerabilidad

Por favor, **no** abras una issue pública para un reporte de seguridad. Una
issue es visible desde que se crea, lo que divulga el problema antes de que
exista una corrección.

Usa el reporte privado de vulnerabilidades de GitHub, en la pestaña
**Security** del repositorio, en **Report a vulnerability**. Si no está
disponible para ti, escribe a
[dariomatias.dev@gmail.com](mailto:dariomatias.dev@gmail.com).

Incluye:

- Una descripción del problema y qué gana un atacante con él.
- Pasos para reproducirlo, preferiblemente mínimos.
- La versión o commit que probaste y la versión de Android en que corrió.

Este es un proyecto de escala aficionada, con un solo mantenedor. No hay equipo
de seguridad ni compromiso de tiempo de respuesta, pero cada reporte se lee y
se responde, y quien reporta recibe crédito cuando sale la corrección, salvo
que prefiera lo contrario.

## Alcance

La app no tiene servidor, ni cuentas, y no envía datos del usuario fuera del
dispositivo. Lo que guarda son preferencias: el tema, el idioma y el tema de
código, en `SharedPreferences`. Eso define el alcance:

**Dentro del alcance**

- El manejo de deep links. La app registra un esquema de URL y resuelve los
  enlaces entrantes en navegación, que es su principal entrada no confiable.
- La configuración de anuncios leída del `.env` en tiempo de compilación.
- Cualquier cosa en el pipeline de build o release que pueda entregar un
  artefacto modificado: permisos de los workflows, el flujo de firma, la
  integridad de las dependencias.

**Fuera del alcance**

- Problemas de servidor, autenticación y toma de cuentas: ninguno de los tres
  existe aquí.
- Vulnerabilidades en los paquetes que las muestras del catálogo solo
  demuestran. Pertenecen a sus propios mantenedores; repórtalas allí.
- El comportamiento del propio SDK de Google Mobile Ads, que es de Google.

Los reportes sobre el [sitio web](https://flutterguide.app) pertenecen a ese
proyecto, no a este repositorio.
