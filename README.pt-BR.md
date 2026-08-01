<br>
<div align="center">
<img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter">
<img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart">
<img src="https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white" alt="Android">
</div>
<br>
<div align="center">
<a href="https://github.com/dariomatias-dev/flutter_guide_app/actions/workflows/ci.yaml"><img src="https://github.com/dariomatias-dev/flutter_guide_app/actions/workflows/ci.yaml/badge.svg" alt="CI"></a>
<img src="https://img.shields.io/badge/lints-very__good__analysis-blueviolet?style=flat" alt="very_good_analysis">
<a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-green.svg" alt="Licença MIT"></a>
</div>
<br>

<p align="center">
<a href="README.md">English</a> · <strong>Português (BR)</strong> · <a href="README.es.md">Español</a>
</p>

<h1 align="center">FlutterGuide: Aplicativo Mobile</h1>

<p align="center">
Um aplicativo Android para explorar widgets, funções e pacotes do Flutter/Dart, cada um com código executável e uma prévia ao vivo.
<br>
<a href="#sobre-o-projeto"><strong>Explore a documentação »</strong></a>
<br>
<br>
<a href="https://flutterguide.app">Ver Site</a>
·
<a href="https://github.com/dariomatias-dev/flutter_guide_app/issues">Reportar Bug</a>
·
<a href="https://github.com/dariomatias-dev/flutter_guide_app/issues">Solicitar Funcionalidade</a>
</p>

## Sumário

- [Sobre O Projeto](#sobre-o-projeto)
- [Funcionalidades](#funcionalidades)
- [Construído Com](#construído-com)
- [Arquitetura](#arquitetura)
- [Testes](#testes)
- [Capturas de Tela](#capturas-de-tela)
- [Baixar o App](#baixar-o-app)
- [Começando](#começando)
- [Scripts](#scripts)
- [Contribuindo](#contribuindo)
- [Changelog](#changelog)
- [Licença](#licença)
- [Autor](#autor)

## Sobre O Projeto

**FlutterGuide** é um catálogo mobile de peças do Flutter e do Dart, criado para ajudar tanto desenvolvedores iniciantes quanto experientes a aprender por meio de exemplos.

Cada item (widget, função ou pacote) vem com seu código-fonte e uma prévia interativa renderizada dentro do próprio app, para você ver o comportamento antes de copiar para o seu projeto. O catálogo também inclui telas de UI prontas e elementos de interface reutilizáveis para padrões comuns de app.

O catálogo cobre atualmente:

| Categoria      | Quantidade |
| -------------- | ---------- |
| Widgets        | 131        |
| Pacotes        | 42         |
| Funções        | 13         |
| Elementos      | 10         |
| Exemplos de UI | 6          |
| **Total**      | **202**    |

## Funcionalidades

- **Catálogo de Widgets, Funções e Pacotes**: Navegue por widgets Material e Cupertino, funções essenciais do Dart e pacotes populares, cada um com código, prévia interativa e link para a documentação oficial.
- **Elementos e Exemplos de UI**: Telas de exemplo completas (login, chat, cliente de email e mais) e elementos de interface reutilizáveis para estudar ou copiar.
- **Favoritos**: Salve qualquer widget, função ou pacote para acesso rápido depois.
- **Busca**: Filtre cada catálogo pelo nome enquanto digita.
- **Deep Linking**: Abra um componente ou exemplo específico direto de um link compartilhado.
- **Múltiplos Idiomas**: Interface completa em inglês, português (Brasil) e espanhol.
- **Seletor de Tema de Código**: Escolha o tema de destaque de sintaxe usado nos exemplos de código, com variantes claro e escuro.
- **Tema Claro e Escuro**: Temas em todo o app, com preferência salva.
- **Acessibilidade**: Labels semânticos em elementos interativos para leitores de tela.

## Construído Com

- **[Flutter](https://flutter.dev/)**: Kit de ferramentas de UI do Google para construir aplicações nativas a partir de uma única base de código.
- **[Dart](https://dart.dev/)**: A linguagem de programação por trás do Flutter.
- **[Riverpod](https://riverpod.dev/)**: Gerenciamento de estado e injeção de dependência.
- **[go_router](https://pub.dev/packages/go_router)**: Roteamento declarativo e tratamento de deep links.
- **[flutter_syntax_highlighter](https://pub.dev/packages/flutter_syntax_highlighter)**: Destaque de sintaxe para os exemplos de código.
- **[shared_preferences](https://pub.dev/packages/shared_preferences)**: Persistência de tema, idioma e tema de código selecionados.
- **[google_mobile_ads](https://pub.dev/packages/google_mobile_ads)**: Monetização via anúncios.
- **[app_links](https://pub.dev/packages/app_links)**: Tratamento de deep links.
- **[intl](https://pub.dev/packages/intl)** e o suporte nativo de `l10n` do Flutter: localização em inglês, português (BR) e espanhol.
- **[mocktail](https://pub.dev/packages/mocktail)**: Mocks na suíte de testes.

O catálogo dentro do app também demonstra dezenas de outros pacotes, como
`dio`, `http`, `cached_network_image`, `flutter_svg`, `video_player`,
`flutter_animate`, `photo_view` e `shimmer`; abra a aba de Pacotes no app
para ver a lista completa e executável.

## Arquitetura

O app é organizado por feature (`lib/src/features/`), cada uma com suas
próprias camadas `data`, `domain` e `presentation`:

- **catalog**: o catálogo de widgets/funções/pacotes/elementos/UIs, busca e favoritos.
- **home**: a tela inicial e os grupos de componentes.
- **settings**: seleção de idioma e informações do app.
- **code_theme_selector**: o seletor de tema de destaque de sintaxe dos exemplos de código.

O estado é gerenciado com Riverpod (classes `ViewModel`/`Notifier`
expostas via providers), o roteamento com `go_router`, e a persistência
por uma camada de serviço baseada em `SharedPreferences`. Widgets
compartilhados e independentes de feature ficam em `lib/src/shared`;
responsabilidades transversais (DI, roteamento, tema) ficam em
`lib/src/core`.

## Testes

O projeto tem 37 arquivos de teste cobrindo repositórios, view models,
notifiers, tratamento de deep link e widgets compartilhados, usando
`mocktail` para mocks e overrides de `ProviderContainer` para estado do
Riverpod. O código segue o conjunto rigoroso de lints
`very_good_analysis`, verificado no CI junto com `dart format` e
`flutter test`.

```sh
fvm flutter analyze
fvm flutter test
```

## Capturas de Tela

<div align="center">
<img src="screenshots/01_home.png" width="200" alt="Início"/>
<img src="screenshots/02_catalog_elements.png" width="200" alt="Catálogo de elementos"/>
<img src="screenshots/03_catalog_uis.png" width="200" alt="Catálogo de UIs"/>
<img src="screenshots/04_elements_tab.png" width="200" alt="Aba de elementos"/>
<img src="screenshots/05_component_detail.png" width="200" alt="Prévia do componente"/>
<img src="screenshots/06_component_code.png" width="200" alt="Código do componente"/>
<img src="screenshots/07_packages_tab.png" width="200" alt="Aba de pacotes"/>
<img src="screenshots/08_settings.png" width="200" alt="Configurações"/>
<img src="screenshots/09_code_theme_selector.png" width="200" alt="Seletor de tema de código"/>
</div>

## Baixar o App

Obtenha o **FlutterGuide** diretamente na **Google Play Store**:

<a href="https://play.google.com/store/apps/details?id=com.dariomatias.flutter_guide" target="_blank">
<img src="https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png" alt="Disponível no Google Play" width="200">
</a>

## Começando

O projeto fixa a versão do Flutter SDK via [FVM](https://fvm.app/), por isso todos os comandos abaixo usam `fvm flutter` em vez de um `flutter` instalado direto.

```sh
git clone https://github.com/dariomatias-dev/flutter_guide_app.git
cd flutter_guide_app
fvm install
fvm flutter pub get
```

Crie um arquivo `.env` na raiz do projeto (ele é git-ignored) com as chaves abaixo; deixe os valores vazios para rodar localmente sem anúncios:

```
DEVICE_ID=
BANNER_AD_ID=
BANNER_AD_SAMPLE_ID=
INTERSTICIAL_AD_SAMPLE_ID=
REWARDED_AD_SAMPLE_ID=
APP_OPEN_AD_SAMPLE_ID=
```

Depois rode o app em um dispositivo ou emulador conectado:

```sh
fvm flutter run
```

## Scripts

Scripts utilitários ficam em `scripts/`.

| Script       | Comando                             | Descrição                                                                                                                                                    |
| ------------ | ------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `screenshot` | `scripts/screenshot.sh [device-id]` | Percorre as principais telas do app em um dispositivo ou emulador conectado e salva uma captura de cada uma em `screenshots/`, usadas no README, na Play Store e no site oficial. Rode `fvm flutter devices` para listar os ids de dispositivos disponíveis. |

## Contribuindo

Contribuições tornam a comunidade open-source um lugar incrível para aprender e criar. Qualquer contribuição que você fizer será muito bem-vinda.

Antes de abrir um pull request, veja o [CONTRIBUTING.md](CONTRIBUTING.md) (em inglês) para a configuração local, a convenção de mensagens de commit (Conventional Commits) e as regras de branch deste projeto.

## Changelog

Todas as mudanças notáveis são documentadas em [CHANGELOG.md](CHANGELOG.md) (em inglês), seguindo o formato [Keep a Changelog](https://keepachangelog.com).

## Licença

Distribuído sob a **Licença MIT**. Veja o arquivo [LICENSE](LICENSE) para mais informações.

## Autor

Desenvolvido por **Dário Matias Sales**:

- **Portfólio**: [dariomatias-dev](https://dariomatias-dev.com)
- **GitHub**: [dariomatias-dev](https://github.com/dariomatias-dev)
- **Email**: [dariomatias.dev@gmail.com](mailto:dariomatias.dev@gmail.com)
- **Instagram**: [@dariomatias_dev](https://instagram.com/dariomatias_dev)
- **LinkedIn**: [linkedin.com/in/dariomatias-dev](https://linkedin.com/in/dariomatias-dev)
