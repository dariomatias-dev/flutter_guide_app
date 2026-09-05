# Security Policy

<p align="center">
<strong>English</strong> · <a href="security.es.md">Español</a> · <a href="security.pt-BR.md">Português (BR)</a>
</p>

## Supported versions

FlutterGuide is maintained as a single line of development. The supported
version is the current `main` branch and the latest release on Google Play.
Fixes land there and are not backported to older releases.

## Reporting a vulnerability

Please do **not** open a public issue for a security report. An issue is
visible from the moment it is filed, which discloses the problem before a fix
exists.

Use GitHub's private vulnerability reporting instead, from the repository's
**Security** tab, under **Report a vulnerability**. If that is unavailable to
you, email [dariomatias.dev@gmail.com](mailto:dariomatias.dev@gmail.com).

Include:

- A description of the issue and what an attacker gains from it.
- Steps to reproduce it, ideally minimal.
- The version or commit you tested, and the Android version it ran on.

This is a hobby-scale project with a single maintainer. There is no security
team and no response-time commitment, but every report is read and
acknowledged, and a reporter is credited when a fix ships unless they prefer
otherwise.

## Scope

The app has no server, no accounts and no user data leaving the device. What
it stores is preferences: the selected theme, language and code theme, in
`SharedPreferences`. That shapes what is in scope:

**In scope**

- Deep link handling. The app registers a URL scheme and resolves incoming
  links into navigation, which is its main untrusted input.
- The ad configuration read from `.env` at build time.
- Anything in the build or release pipeline that could ship a modified
  artifact: workflow permissions, the signing flow, dependency integrity.

**Out of scope**

- Server-side issues, authentication and account takeover: none of the three
  exist here.
- Vulnerabilities in the packages the catalog samples merely demonstrate.
  Those belong to their own maintainers; report them upstream.
- The behaviour of the Google Mobile Ads SDK itself, which is Google's.

Reports about the [website](https://flutterguide.app) belong to that project,
not this repository.
