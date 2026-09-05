# Arquitetura

<p align="center">
<a href="architecture.md">English</a> · <a href="architecture.es.md">Español</a> · <strong>Português (BR)</strong>
</p>

Como o código é organizado e por quê. Para o que o app é, veja o
[README](../README.pt-BR.md); para como configurar e enviar uma mudança, veja
[contributing.pt-BR.md](contributing.pt-BR.md).

## Layout

```text
packages/app_ui/     Tokens de design e widgets sem dependência do app, pubspec próprio
lib/
├── main.dart                  Inicialização: dotenv, anúncios, preferências, ProviderScope
├── l10n/                      Arquivos ARB e a saída do gen-l10n
└── src/
    ├── flutter_guide_app.dart Widget raiz: tema, locale, router
    ├── core/                  Tudo de que mais de uma feature depende
    │   ├── constants/         Códigos de idioma, links externos
    │   ├── di/                Providers de dependências entre features
    │   ├── enums/             Tipos de componente, de interface e de tema
    │   ├── extensions/        Extensões sobre tipos do Dart e do Flutter
    │   ├── helpers/           Parsing e tratamento de deep links
    │   ├── models/            Modelos compartilhados entre features
    │   ├── navigation/        Notifier do índice da barra inferior, classes de rota tipadas
    │   ├── router/            O provider do GoRouter, montado a partir dessas rotas
    │   ├── services/          Invólucros sobre SDKs de plataforma
    │   ├── shell/             Scaffold raiz: app bar e barra inferior
    │   └── theme/             ThemeData e o notifier de tema
    ├── features/              Um diretório por feature, três camadas cada
    │   ├── catalog/           O catálogo de componentes e os samples
    │   ├── code_theme_selector/
    │   ├── home/
    │   └── settings/
    └── shared/                Widgets e utilitários que leem estado do app
```

Cada feature tem as mesmas três camadas, e só as que tiverem conteúdo:

```text
features/<feature>/
├── data/          Implementações de repositório, data sources, models
├── domain/        Contratos de repositório e entidades
└── presentation/  Telas, widgets, view models, providers
```

## Camadas

A direção da dependência é uma só: `presentation` depende de `domain`, `data`
implementa `domain`, e `domain` não depende de nenhum dos dois. Uma tela nunca
alcança um data source direto; ela lê um view model, que tem um contrato de
repositório, implementado em `data`, que chega ao mundo externo por um service
em [`core/services/`](../lib/src/core/services).

`core/` é para o que mais de uma feature precisa. Um arquivo usado por exatamente
uma feature pertence àquela feature, mesmo quando parece genérico. `shared/`
guarda widgets e helpers sem feature própria, como o
[`card_widget`](../lib/src/shared/widgets/card_widget) e o
[`open_url`](../lib/src/shared/utils/open_url).

`Widget` nunca cruza para `domain` ou `data`. É por isso que a resolução dos
samples fica na camada de apresentação, em
[`sample_registry.dart`](../lib/src/features/catalog/presentation/samples/sample_registry.dart),
mesmo que as listas de samples que ele lê sejam dado.

## Gerenciamento de estado

Riverpod, com providers escritos à mão, não gerados. Uma tela observa um view
model; um view model é um `Notifier` ou `AsyncNotifier` que lê seu repositório
por um provider e expõe o estado.

Os providers são agrupados pelo que ligam, não pelo tipo:

- [`core/di/`](../lib/src/core/di) tem os que atravessam features:
  preferências, tema, índice da barra inferior e se os anúncios estão ativos.
- `features/<feature>/presentation/providers/` tem os da própria feature.

O [`sharedPreferencesProvider`](../lib/src/core/di/shared_preferences_provider.dart)
é declarado sem valor e sobrescrito no `main.dart` com a instância que a
inicialização já aguardou. Isso mantém o resto do grafo síncrono: nada abaixo
precisa virar `FutureProvider` só porque o armazenamento abriu de forma
assíncrona, e um teste sobrescreve o mesmo provider com uma instância de mock.

O [`adsEnabledProvider`](../lib/src/core/di/ads_enabled_provider.dart) existe
para a captura de screenshots poder sobrescrevê-lo para `false`. Imagem de
divulgação não deve carregar banner de anúncio, e um override sai mais barato
que uma flag de build.

## Navegação

[`go_router`](../lib/src/core/router/app_router.dart), configurado a partir de
rotas tipadas geradas pelo `go_router_builder`. Cada rota é uma subclasse de
`GoRouteData` em
[`core/navigation/navigators/`](../lib/src/core/navigation/navigators), um
arquivo por feature, com uma diretiva `part 'x.g.dart';`; o `dart run
build_runner build` escreve o arquivo companheiro, que é commitado como a
saída do l10n e verificado do mesmo jeito no `verify.sh` e na CI.

O `appRouterProvider` é um `Provider<GoRouter>` simples (não auto-disposto),
lido uma vez pelo widget raiz e pela ligação de deep link. Ser um provider em
vez de um campo estático é o que permite a um teste sobrescrevê-lo, ou montar
um a partir de um `ProviderContainer` novo por teste, do jeito que o
[`pump_router_app.dart`](../test/helpers/pump_router_app.dart) faz.

O `onException` manda uma localização não resolvível de volta para a raiz, em
vez de mostrar uma tela de erro: toda rota aqui é alcançável por deep link, e
uma desconhecida é link velho, não uma falha sobre a qual o usuário possa agir.

A rota de sample carrega seus argumentos pelo `extra` do go_router, declarado
como um campo `$extra` nulável em `ComponentSampleRoute`. O `extra` só é
preenchido por um `push` dentro do app, nunca por um deep link ou uma pilha de
navegação restaurada, os dois casos que o deixam `null`; o `redirect` da rota
manda esse caso de volta para a raiz, em vez do código gerado forçar um cast
de `extra` nulo, que é o que um campo não nulável ainda faria.

## Deep links

O [`DeepLinkService`](../lib/src/core/services/deep_link_service.dart) escuta o
`app_links` e encaminha cada URI para o
[`DeepLinkHandler`](../lib/src/core/helpers/deep_link_handler.dart), que a
resolve em um
[`DeepLinkTarget`](../lib/src/core/helpers/deep_link_target.dart) e navega.

`DeepLinkTarget` é uma sealed class de dado puro, sem efeitos colaterais. O
parsing é a parte com casos de borda, então está separado da navegação e da
localização e é testado sozinho; ao handler sobra a parte que precisa de
`BuildContext`.

## Persistência

Apenas preferências do usuário: tema, idioma e tema de código. Não há banco de
dados.

O [`SharedPreferencesService`](../lib/src/core/services/shared_preferences_service.dart)
envolve o plugin, e as chaves ficam em um lugar só, em
[`shared_preferences_keys.dart`](../lib/src/core/constants/shared_preferences_keys.dart).
Um repositório fala com o service, nunca com o `SharedPreferences` direto, que é
o que permite a um teste trocar o armazenamento sem tocar no plugin.

O repositório de idioma mapeia um `pt_BR` gravado para `pt` na leitura. Versões
anteriores à remoção do ARB com região gravavam esse valor, que não casa mais
com nenhuma entrada de `Language.all`, então sem o mapeamento uma atualização
resetaria em silêncio o idioma do usuário para inglês.

## Tema

O [`theme.dart`](../lib/src/core/theme/theme.dart) guarda o `ThemeData` claro e
escuro, e o [`ThemeNotifier`](../lib/src/core/theme/theme_notifier.dart) guarda
o modo escolhido e o persiste. O tema de código é uma feature separada, porque é
outra escolha, com outro conjunto de opções: ele seleciona a paleta usada pelo
`flutter_syntax_highlighter` ao renderizar um sample.

## Design system (`packages/app_ui`)

Um pacote Flutter separado, adicionado como dependência `path` no
`pubspec.yaml`, guardando o que não tem nenhum acoplamento com este app: os
tokens de design (`AppSpacing`, `AppRadius`, `AppDurations`, a paleta de
cores) e os widgets construídos só a partir deles e do próprio Flutter,
exportados por
[`app_ui.dart`](../packages/app_ui/lib/app_ui.dart) e importados como
`package:app_ui/app_ui.dart`.

A fronteira é imposta pelo que um arquivo pode importar, não por um lint:
nada em `packages/app_ui/lib/` pode importar `flutter_guide/`, ler um
provider do Riverpod ou ler `AppLocalizations`. Um widget que precisa de
qualquer um desses é código de app, não design system, e fica em
`lib/src/shared/`, não importa quão genérico pareça. O
`ChangeThemeButtonWidget` é o exemplo concreto: ele lê `themeNotifierProvider`
e `AppLocalizations` diretamente, então fica no app em vez de ser forçado
para dentro do `app_ui` com um parâmetro estranho para cada valor que antes
lia sozinho. O `StandardAppBarWidget` o incorpora, e fica ao lado dele pelo
mesmo motivo.

O `packages/app_ui` tem seu próprio `pubspec.yaml`, `analysis_options.yaml` e
`test/`, com gate independente a um limiar de 98% de cobertura no
[`scripts/verify.sh`](../scripts/verify.sh), que o roda quando uma mudança
toca `packages/app_ui/*`, e na CI como job próprio, reportando sob a flag
`app_ui` do Codecov.

## Localização

Três idiomas: inglês, espanhol e português. Os arquivos ARB são só de idioma,
sem região, para um dispositivo pt-PT receber português em vez de cair no
inglês.

O `app_en.arb` é o template e carrega `description` em toda chave, que é o único
contexto que um tradutor recebe. O
[`check_l10n.sh`](../scripts/check_l10n.sh) cobra as descriptions e a paridade
de chaves, porque o `gen-l10n` cai no template em silêncio quando falta uma
chave em um idioma.

A saída gerada é commitada, e a CI a regenera para provar que o commit bate com
sua fonte.

## Os samples do catálogo

O [`features/catalog/data/samples/`](../lib/src/features/catalog/data/samples)
tem 226 arquivos, e eles são o produto: o código que o app mostra ao usuário
como material didático. São dado, não código de app, e seguem regras diferentes
de propósito.

- **Literais ficam à vista.** Um sample que lê um token de espaçamento ensina um
  token cujo valor o leitor não consegue ver.
- **Ficam fora do gate de cobertura.** Suas 6967 linhas cobríveis puxam o número
  de 95% para 24% sem dizer nada sobre o app. A exclusão vive no
  [`check_coverage.sh`](../scripts/check_coverage.sh) e se repete no
  `codecov.yml`.
- **Registro, não ligação.** Um sample é um `ComponentModel` em
  `sample_definitions/`, nomeado por uma constante em `sample_names/`, e
  resolvido pelo `SampleRegistry`. Adicionar um significa adicionar uma entrada
  de lista.

O `sample_registry_test.dart` resolve todo componente registrado, então um
sample ausente de uma lista de definição falha ali, e não em tempo de execução.

## Anúncios

`google_mobile_ads`, inicializado no `main.dart` e lido do `.env` pelo
`flutter_dotenv`. Os ids não estão no repositório; as chaves precisam existir
para o app rodar, e é por isso que o `contributing.pt-BR.md` traz um bloco
`.env` com valores vazios.

A inicialização deliberadamente não é aguardada: um SDK de anúncios lento para
responder não deve segurar o primeiro frame.

## Testes

O `test/` espelha o `lib/src/`, arquivo por arquivo. Os dublês são mocks do
`mocktail`, e uma dependência é substituída por override de `ProviderContainer`,
não alcançando dentro da árvore de widgets. O `test/helpers/` traz o
ferramental: `pumpApp` para um widget sob um `MaterialApp` localizado,
`pumpScopedApp` para um que abre conteúdo em overlay, e `pump_router_app.dart`
para qualquer coisa roteada.

O gate de cobertura é 95%, medido sobre `lib/` menos as fontes geradas e os
samples do catálogo.

O [`integration_test/screenshot_test.dart`](../integration_test/screenshot_test.dart)
roda num emulador Android real na CI, em job próprio. Existe para capturar
screenshots de divulgação, não como substituto dos testes de widget, mas
rodá-lo na CI também prova que o app inicia e cada tela que visita renderiza
num dispositivo real: `dotenv`, `SharedPreferences` e todo o grafo do Riverpod
rodam de verdade ali, nada disso simulado.
