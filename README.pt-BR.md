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
    <img src="https://img.shields.io/badge/license-MIT-green.svg" alt="Licença MIT">
  </a>
</div>
<br>

<p align="center">
  <a href="README.md">English</a> · <a href="README.es.md">Español</a> · <strong>Português (BR)</strong>
</p>

<h1 align="center">FlutterGuide</h1>

<p align="center">
  Um aplicativo Android para explorar widgets, funções e pacotes do Flutter/Dart, cada um com código executável e uma prévia ao vivo.
  <br>
  <a href="#sobre-o-projeto"><strong>Explore a documentação »</strong></a>
  <br>
  <br>
  <a href="https://github.com/dariomatias-dev/flutter_guide_app/issues">Reportar Bug</a>
  ·
  <a href="https://github.com/dariomatias-dev/flutter_guide_app/issues">Solicitar Funcionalidade</a>
</p>

## Sumário

- [Sobre o Projeto](#sobre-o-projeto)
- [Prévia](#prévia)
- [Funcionalidades](#funcionalidades)
- [O Catálogo](#o-catálogo)
- [Tecnologias](#tecnologias)
- [Arquitetura](#arquitetura)
- [Começando](#começando)
- [Scripts](#scripts)
- [Testes](#testes)
- [Publicação](#publicação)
- [Documentação](#documentação)
- [Contribuindo](#contribuindo)
- [Segurança](#segurança)
- [Licença](#licença)
- [Autor](#autor)

## Sobre o Projeto

**FlutterGuide** é um catálogo mobile de peças do Flutter e do Dart para desenvolvedores que aprendem por exemplos. Cada item (widget, função ou pacote) vem com seu código-fonte e uma prévia interativa ao vivo renderizada dentro do próprio app, para ver o comportamento antes de copiá-lo para outro projeto.

O app está publicado no [Google Play](https://play.google.com/store/apps/details?id=com.dariomatias.flutter_guide), e o site está em [flutterguide.app](https://flutterguide.app).

## Prévia

<div align="center">
  <img src="screenshots/en/01_home.png" width="200" alt="Início">
  <img src="screenshots/en/05_component_detail.png" width="200" alt="Prévia do componente">
  <img src="screenshots/en/06_component_code.png" width="200" alt="Código do componente">
  <br>
  <sub>A tela inicial, a prévia de um componente e seu código-fonte.</sub>
</div>

## Funcionalidades

- **Prévias ao vivo com código-fonte**: cada widget, função e pacote mostra seu código executável ao lado de uma prévia interativa e um link para a documentação oficial.
- **Elementos e exemplos de UI**: telas de exemplo completas (login, chat, cliente de email e outras) e elementos de interface reutilizáveis para estudar ou copiar.
- **Deep linking**: abra um componente ou exemplo específico a partir de um link compartilhado.
- **Seletor de tema de código**: escolha o tema de destaque de sintaxe dos exemplos de código, com variantes claro e escuro.
- **Favoritos**: salve qualquer widget, função ou pacote para depois.
- **Busca**: filtre cada catálogo pelo nome enquanto digita.
- **Idiomas**: inglês, português (Brasil) e espanhol.
- **Tema claro e escuro**, com a escolha salva.
- **Acessibilidade**: labels semânticos nos elementos interativos para leitores de tela.

## O Catálogo

Os widgets são Material e Cupertino, as funções são funções essenciais do Dart e os pacotes são bibliotecas de terceiros, entre eles `dio`, `http`, `cached_network_image`, `flutter_svg`, `video_player`, `flutter_animate`, `photo_view` e `shimmer`. Os elementos são peças de interface reutilizáveis e os exemplos de UI são telas completas.

| Categoria      | Quantidade |
| -------------- | ---------- |
| Widgets        | 142        |
| Pacotes        | 46         |
| Funções        | 13         |
| Elementos      | 9          |
| Exemplos de UI | 5          |
| **Total**      | **215**    |

## Tecnologias

- **Framework**: [Flutter](https://flutter.dev/) e [Dart](https://dart.dev/)
- **Estado e injeção de dependência**: [Riverpod](https://riverpod.dev/)
- **Roteamento e deep links**: [go_router](https://pub.dev/packages/go_router) e [app_links](https://pub.dev/packages/app_links)
- **Persistência**: [shared_preferences](https://pub.dev/packages/shared_preferences)
- **Localização**: [intl](https://pub.dev/packages/intl) e o suporte nativo de `l10n` do Flutter
- **Exemplos de código**: [flutter_syntax_highlighter](https://pub.dev/packages/flutter_syntax_highlighter)
- **Monetização**: [google_mobile_ads](https://pub.dev/packages/google_mobile_ads)
- **Qualidade**: [mocktail](https://pub.dev/packages/mocktail), [very_good_analysis](https://pub.dev/packages/very_good_analysis) e [FVM](https://fvm.app/) para fixar o SDK

## Arquitetura

O app é organizado por feature (`lib/src/features/`: `catalog`, `home`, `settings` e `code_theme_selector`), cada uma dividida em `data`, `domain` e `presentation`, com Riverpod para o estado e go_router para o roteamento. O código transversal fica em `lib/src/core`, e o design system em `packages/app_ui`, um pacote separado cujo `pubspec.yaml` não depende do app, então o compilador rejeita qualquer import de volta para ele.

As regras de camada, os subsistemas e as decisões por trás deles estão em [docs/architecture.pt-BR.md](docs/architecture.pt-BR.md).

## Começando

Requisitos: [FVM](https://fvm.app/), que fixa a versão do Flutter SDK do projeto, Git, e um dispositivo ou emulador Android. Todos os comandos abaixo usam `fvm flutter` em vez de um `flutter` avulso.

O arquivo `.env` é git-ignored; deixe os valores vazios para rodar sem anúncios.

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

Os scripts de apoio ficam em `scripts/`, na ordem de uso: primeiro desenvolvimento, depois qualidade.

| Comando                                           | Descrição                                                                                                                                                                                                                                                                  |
| ------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `scripts/screenshot.sh [device-id]`               | Percorre as principais telas do app em um dispositivo conectado, nos três idiomas, salvando as capturas em `screenshots/<locale>/`. Rode `fvm flutter devices` para listar os ids de dispositivos.                                                                         |
| `scripts/verify.sh [--all] [--skip-tests]`        | Roda o que a CI roda: regenera código e localizações (falhando se a saída commitada estava desatualizada), depois paridade dos ARB, format, analyze, testes e cobertura. `--all` verifica tudo; `--skip-tests` serve para checagens no meio de uma mudança, nunca a final. |
| `scripts/check_l10n.sh [arb-dir]`                 | Falha quando os arquivos ARB divergem nas chaves ou quando uma chave do template não tem descrição. O `gen-l10n` cai no template em silêncio, então nada mais detecta isso.                                                                                                |
| `scripts/check_coverage.sh <lcov-file> <minimum>` | Falha quando a cobertura de linhas fica abaixo do mínimo, excluindo fontes geradas e os samples do catálogo, que são material didático, não lógica do app.                                                                                                                 |

## Testes

Os testes unitários e de widget ficam em `test/`, espelhando `lib/src/`, e usam `mocktail` com overrides de `ProviderContainer`. O `packages/app_ui` se testa sozinho, e um teste de integração percorre o app em um dispositivo para capturar as telas.

```sh
fvm flutter test                                                       # o app
(cd packages/app_ui && fvm flutter test)                               # o design system
fvm flutter test integration_test/screenshot_test.dart -d <device-id>  # capturas, em um dispositivo conectado
./scripts/verify.sh                                                    # o mesmo gate que a CI roda
```

O gate falha diante de código ou localizações gerados desatualizados, arquivos ARB divergentes, formatação, avisos do analisador, testes falhando e cobertura abaixo do limiar. Veja [docs/contributing.pt-BR.md](docs/contributing.pt-BR.md) para os limiares e para saber qual job da CI bloqueia um merge.

## Publicação

O FlutterGuide roda em Android e está publicado no Google Play. Todo pull request e todo push para `main` executa o pipeline de CI, e cada job bloqueia o merge (o gate de qualidade do app e do `packages/app_ui`, a varredura de vulnerabilidades das dependências, o build do APK de release e a execução do teste de integração em um emulador), exceto o envio de cobertura, que apenas reporta.

As releases são geradas pelo release-please: ele lê os Conventional Commits que chegaram em `main`, mantém aberto um pull request com a próxima versão e a entrada do `CHANGELOG.md`, e no merge marca o commit e anexa o APK assinado e o app bundle à release do GitHub. Enviar o bundle ao Google Play é manual. Os detalhes estão em [docs/contributing.pt-BR.md](docs/contributing.pt-BR.md).

## Documentação

| Documento                                          | O que cobre                                                                                 |
| -------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| [Arquitetura](docs/architecture.pt-BR.md)          | Estrutura, regras de camada e a decisão por trás de cada subsistema                         |
| [Contribuindo](docs/contributing.pt-BR.md)         | Configuração, o gate local, o que a CI verifica, releases e a convenção de commits          |
| [Política de segurança](docs/security.pt-BR.md)    | Como relatar uma vulnerabilidade em privado, e o que está no escopo                         |
| [Código de Conduta](docs/code_of_conduct.pt-BR.md) | O comportamento esperado nos espaços do projeto                                             |
| [Acordo de trabalho](CLAUDE.md)                    | O processo que toda mudança segue, venha de uma pessoa ou de um agente (em inglês)          |
| [Design system](packages/app_ui/README.md)         | O que o `packages/app_ui` contém e o limite que o mantém sem acoplamento ao app (em inglês) |

## Contribuindo

Contribuições são bem-vindas. Antes de abrir um pull request, rode o gate local, que executa as mesmas verificações da CI:

```sh
./scripts/verify.sh
```

Veja [docs/contributing.pt-BR.md](docs/contributing.pt-BR.md) para a configuração, a convenção de commits e as regras de branch. A participação é regida pelo [Código de Conduta](docs/code_of_conduct.pt-BR.md).

## Segurança

Encontrou uma vulnerabilidade? Não abra uma issue pública: siga a [política de segurança](docs/security.pt-BR.md).

## Licença

Distribuído sob a **Licença MIT**. Veja o arquivo [LICENSE](LICENSE) para mais informações.

## Autor

Desenvolvido por **Dário Matias Sales**:

- **Portfólio**: [dariomatias-dev](https://dariomatias-dev.com)
- **GitHub**: [dariomatias-dev](https://github.com/dariomatias-dev)
- **Email**: [dariomatias.dev@gmail.com](mailto:dariomatias.dev@gmail.com)
- **Instagram**: [@dariomatias_dev](https://instagram.com/dariomatias_dev)
- **LinkedIn**: [linkedin.com/in/dariomatias-dev](https://linkedin.com/in/dariomatias-dev)
