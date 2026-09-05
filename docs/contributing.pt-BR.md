# Contribuindo

<p align="center">
<a href="contributing.md">English</a> · <a href="contributing.es.md">Español</a> · <strong>Português (BR)</strong>
</p>

Obrigado por considerar contribuir. Este documento cobre a configuração, as
verificações que uma mudança precisa passar e as convenções pelas quais um pull
request é revisado.

## Configuração

O projeto fixa a versão do SDK do Flutter com o [FVM](https://fvm.app/), então
todo comando abaixo usa `fvm flutter` em vez de um `flutter` instalado
globalmente. O `flutter` puro usa a versão que estiver instalada na máquina,
que não é a que a CI usa.

```bash
git clone https://github.com/dariomatias-dev/flutter_guide_app.git
cd flutter_guide_app
fvm install
fvm flutter pub get
git config core.hooksPath .githooks
```

A última linha ativa o hook `commit-msg`, que cobra a convenção de commits
descrita abaixo.

O app lê os ids de anúncio de um arquivo `.env` na raiz do repositório, que não
é versionado. As chaves só precisam existir para o app compilar e rodar:

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

## Antes de abrir um pull request

- [ ] `./scripts/verify.sh` passa
- [ ] Lógica nova tem teste, caminhos de falha incluídos; correção de bug tem teste que falha sem a correção
- [ ] `test/` continua espelhando `lib/src/`
- [ ] Strings novas visíveis ao usuário estão nos três arquivos ARB, com `description` em `lib/l10n/app_en.arb`
- [ ] `fvm flutter gen-l10n` rodado e a saída commitada, se algum ARB mudou
- [ ] `dart run build_runner build` rodado e a saída commitada, se alguma rota em `core/navigation/navigators/` mudou
- [ ] Documentação alterada nos três idiomas, se foi alterada
- [ ] Commits seguem a convenção abaixo

As regras estruturais pelas quais uma mudança é revisada estão no
[`CLAUDE.md`](../CLAUDE.md): onde cada tipo de código vai, o que os samples do
catálogo fazem de diferente e o que conta como efeito colateral. Não são
repetidas aqui, justamente para não divergirem.

## O gate local

```bash
./scripts/verify.sh
```

Ele roda exatamente o que a CI roda, na mesma ordem, para o app e para o
`packages/app_ui` de forma independente:

| Etapa | O que ela detecta |
| --- | --- |
| `build_runner` e `gen-l10n`, e o diff da saída | Rotas ou localizações commitadas que não batem mais com a fonte. A CI regenera a partir de um checkout limpo e falha em qualquer diferença. Só no app: o `packages/app_ui` não tem gerador |
| [`check_l10n.sh`](../scripts/check_l10n.sh) | Chave faltando em um idioma, ou chave do template sem `description`. O `gen-l10n` cai no inglês em silêncio |
| `dart format --set-exit-if-changed` | Formatação, a única verificação com uma resposta correta só |
| `flutter analyze` | Lints do `very_good_analysis` |
| `flutter test --coverage` | A suíte de testes |
| [`check_coverage.sh`](../scripts/check_coverage.sh) | Cobertura de linhas abaixo de 95% no app, 98% no `packages/app_ui`, excluindo fontes geradas e os samples do catálogo |

O escopo vem do que mudou: só o app, só o `packages/app_ui`, ou os dois,
dependendo de quais caminhos têm mudança pendente. O gate é pulado por
completo quando nada mudou em `lib`, `test`, `integration_test`,
`test_driver`, `packages` ou nos manifestos. Use `--all` para verificar tudo
mesmo assim, e `--skip-tests` para uma checagem rápida no meio da mudança,
nunca como verificação final.

Uma execução aprovada grava o hash da árvore em `.dart_tool/verify_stamp`, para
que ferramentas saibam se a árvore ainda corresponde a uma execução que passou.

## O que a CI verifica

| Job | O que faz | Merge |
| --- | --- | --- |
| `Vulnerabilities` | Roda o `osv-scanner` contra o `pubspec.lock` e o `packages/app_ui/pubspec.lock`, que são o que de fato é entregue, e não os ranges de caret do `pubspec.yaml`. Independente dos outros jobs: uma advisory recém-divulgada não é motivo para calar os testes | Bloqueia |
| `packages/app_ui` | Formatação, análise, testes e o gate de 98% de cobertura do pacote de design system, independente do app, enviado ao Codecov sob a flag `app_ui` | Bloqueia |
| `flutter_guide` | O gate acima, passo a passo | Bloqueia |
| `Build APK` | Roda depois de `flutter_guide` passar e constrói um APK de release, publicado como artefato por 14 dias. Sem keystore no checkout, cai na assinatura de debug | Bloqueia |
| `Integration tests` | Roda depois de `flutter_guide` passar, sobe um emulador Android e roda `integration_test/screenshot_test.dart` nele. A única verificação que roda o app de verdade: dotenv real, `SharedPreferences` real, sistema Android real, nada disso simulado como num teste de widget. Ativa o KVM antes, sem o qual o emulador cai para renderização por software e estoura o tempo | Bloqueia |
| Upload do Codecov | Reporta o delta de cobertura no pull request, com anotações inline | Só reporta |

A versão do SDK vem do `.fvmrc`, lida com `jq` no começo de cada job, em vez de
repetida no workflow. É uma divergência deliberada do padrão comum
`env: FLUTTER_VERSION`: duas cópias de uma versão divergem, e o pipeline passa
a construir numa versão que ninguém usa.

### Relatórios de cobertura

O [`check_coverage.sh`](../scripts/check_coverage.sh) é o que reprova a build;
o Codecov é o que torna o número legível. Cada pacote envia seu próprio
`lcov.info` sob sua própria flag, então o limiar de 95% do app e o de 98% do
`packages/app_ui` são acompanhados separadamente, e um pull request ganha um
comentário com o delta por flag e anotações inline nas linhas novas sem
cobertura. O `codecov.yml` guarda os alvos e repete as exclusões do script:
fontes geradas, `lib/l10n/` e os samples do catálogo em
`lib/src/features/catalog/data/samples/`. Esses samples são código didático
exibido ao usuário, e suas 6967 linhas puxam o número de 95% para 24% sem
dizer nada sobre o app em si.

Os uploads autenticam com o secret `CODECOV_TOKEN`. Pull request vindo de fork
não consegue lê-lo, então o passo usa `fail_ci_if_error: false`: upload que
falha é relatório ausente, nunca build reprovada.

### Releases

As releases são feitas pelo [release-please](https://github.com/googleapis/release-please).
Ele lê os Conventional Commits que entraram na `main` e mantém um pull request
aberto com a próxima versão e a entrada do `CHANGELOG.md` derivada deles:
`fix:` sobe o patch, `feat:` o minor, e `!` antes dos dois pontos o major.
Mergear esse pull request escreve a versão no `pubspec.yaml`, cria a tag e
publica a release no GitHub.

O `release.yml` então roda o mesmo gate da CI, constrói o APK e o app bundle, e
anexa os dois. Ele é chamado diretamente pelo `release_please.yml`, porque o
GitHub não inicia um workflow a partir de tag empurrada com o token padrão, e
ainda responde a uma tag `v*.*.*` empurrada à mão.

A build de release é assinada com a upload key, montada a partir de secrets do
repositório e apagada do runner depois. O job falha em vez de cair na
assinatura de debug, porque artefato assinado com debug não sobe na Play Store
nem instala por cima da build da loja. A publicação na Play Store continua
manual: baixe o `.aab` da release e envie por lá.

| Secret | Serve para |
| --- | --- |
| `ANDROID_KEYSTORE_BASE64` | A upload keystore em base64: `base64 -w0 upload-keystore.jks` |
| `ANDROID_KEYSTORE_PASSWORD` | A senha da store |
| `ANDROID_KEY_ALIAS` | O alias da chave dentro da keystore |
| `ANDROID_KEY_PASSWORD` | A senha da chave |
| `BANNER_AD_ID`, `BANNER_AD_SAMPLE_ID`, `INTERSTICIAL_AD_SAMPLE_ID`, `REWARDED_AD_SAMPLE_ID`, `APP_OPEN_AD_SAMPLE_ID` | Os ids de anúncio escritos no `.env` da build de release |
| `CODECOV_TOKEN` | O upload de cobertura na CI |

### Rodando os workflows localmente

O [`act`](https://github.com/nektos/act) roda os workflows em Docker, o que
vale a pena antes de empurrar qualquer mudança em `.github/workflows/`. O
`.actrc` já fixa a imagem do runner, então nenhuma flag é necessária:

```bash
act -l                            # lista todos os jobs, com id e estágio
act pull_request                  # tudo que a CI rodaria em um pull request
act pull_request -j app           # um job, pelo id
act pull_request -j app --dryrun  # imprime os passos sem executá-los
```

O `-j` recebe o id do job (`vulnerabilities`, `app_ui`, `app`, `build_apk`,
`integration`), não o nome exibido; o `act -l` mostra os dois. A primeira
execução baixa uma imagem de vários gigabytes, e o `act` aproxima os runners
do GitHub em vez de reproduzi-los, então uma execução verde aqui é sinal, não
garantia: o `secrets.CODECOV_TOKEN` fica vazio localmente, o scanner OSV
precisa de rede para consultar a base de advisories, e o `act` não roda de
jeito nenhum a action de emulador do job `integration`.

## Trabalhando com um agente de IA

O repositório carrega a própria configuração de agente, para que um assistente
siga o mesmo processo de um contribuidor em vez de improvisar um por prompt:

- O [`CLAUDE.md`](../CLAUDE.md) é o acordo de trabalho: o loop de cada mudança,
  onde cada tipo de código vai, o que os samples do catálogo fazem de diferente
  e o que é inegociável.
- O `.claude/hooks/format-dart.sh` formata o arquivo Dart logo depois de ele
  ser escrito.
- O `.claude/hooks/verify-gate.sh` recusa encerrar um turno que deixa código
  que o gate não aprovou.

Mudar o acordo é uma mudança normal, revisada como qualquer outra.

## Atualização de dependências

O [Renovate](https://docs.renovatebot.com) abre os pull requests de atualização
semanalmente, com o prefixo `build(deps):` para passarem no hook de mensagem e
alimentarem o release-please. O `renovate.json` guarda as regras, e a issue do
dependency dashboard lista tudo que ele está segurando.

Renovate em vez de Dependabot porque só o Renovate desabilita ou agrupa
atualizações por nome de pacote. Existem duas regras hoje: `intl` é ditado pelo
`flutter_localizations` que vem com o SDK fixado, então se move junto com o
SDK; e `go_router` se move junto com seu gerador de rotas, já que a divergência
entre os dois quebra a geração de código, não a análise. Nunca rode os dois
bots.

Um pull request de atualização é triado como qualquer outra mudança: o gate
precisa passar, e um bump que muda comportamento exige checar o comportamento,
não apenas um pipeline verde.

## Convenção de commits

Este projeto segue os [Conventional Commits](https://www.conventionalcommits.org):

```
<type>(<scope>): <subject>

<corpo opcional, explicando o porquê>
```

O hook `commit-msg` cobra todas as regras abaixo.

- **type**: `feat`, `fix`, `refactor`, `docs`, `style`, `test`, `chore`, `perf`, `build`, `ci`, `revert`
- **scope**: opcional, minúsculo, entre parênteses, por exemplo `catalog`, `theme`
- **breaking change**: `!` antes dos dois pontos, por exemplo `refactor(nav)!: drop the untyped router`
- **subject**: imperativo, começando em minúscula, sem ponto final
- **linha de subject**: no máximo 72 caracteres, incluindo type e scope
- **linha em branco** entre o subject e o corpo
- **corpo**: quebrado em 80 colunas, exceto URLs, trailers do git como
  `Co-Authored-By:` ou `Refs #123`, e blocos de código cercados

O corpo é opcional e existe para o *porquê*. O diff já mostra o que mudou.

## Branches

- A `main` é protegida: sem push direto, merge só via pull request.
- Nomes de branch: `<type>/<descrição-curta>`, por exemplo `feat/table-sample`,
  `fix/dropdown-alignment`.

## Pull requests

- Uma mudança lógica por pull request; mantenha pequeno e revisável.
- Merge só por squash ou rebase, sem merge commits, para o histórico seguir
  linear e cada entrada ser um Conventional Commit válido.
- Neste repositório (mantenedor único), o self-merge após a CI passar é
  permitido; a proteção de branch ainda exige o fluxo de pull request e as
  verificações passando.

## Código de Conduta

A participação neste projeto é regida pelo
[Código de Conduta](code_of_conduct.pt-BR.md). Relatos de segurança seguem a
[política de segurança](security.pt-BR.md), nunca uma issue pública.
