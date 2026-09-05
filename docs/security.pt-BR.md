# Política de Segurança

<p align="center">
<a href="security.md">English</a> · <a href="security.es.md">Español</a> · <strong>Português (BR)</strong>
</p>

## Versões suportadas

O FlutterGuide é mantido em uma única linha de desenvolvimento. A versão
suportada é a branch `main` atual e a última release na Google Play. As
correções entram ali e não são retroportadas para releases antigas.

## Como relatar uma vulnerabilidade

Por favor, **não** abra uma issue pública para um relato de segurança. Uma
issue fica visível desde o instante em que é criada, o que divulga o problema
antes de existir correção.

Use o relato privado de vulnerabilidade do GitHub, na aba **Security** do
repositório, em **Report a vulnerability**. Se isso não estiver disponível para
você, escreva para
[dariomatias.dev@gmail.com](mailto:dariomatias.dev@gmail.com).

Inclua:

- Uma descrição do problema e o que um atacante ganha com ele.
- Passos para reproduzir, de preferência mínimos.
- A versão ou commit testado e a versão do Android usada.

Este é um projeto de escala amadora, com um mantenedor só. Não há time de
segurança nem compromisso de tempo de resposta, mas todo relato é lido e
respondido, e quem relata recebe crédito quando a correção sai, salvo
preferência contrária.

## Escopo

O app não tem servidor, não tem contas e não envia dados do usuário para fora
do dispositivo. O que ele guarda são preferências: tema, idioma e tema de
código, no `SharedPreferences`. Isso define o escopo:

**Dentro do escopo**

- Tratamento de deep links. O app registra um esquema de URL e resolve links
  recebidos em navegação, que é sua principal entrada não confiável.
- A configuração de anúncios lida do `.env` em tempo de build.
- Qualquer coisa no pipeline de build ou release que possa entregar um
  artefato modificado: permissões dos workflows, o fluxo de assinatura,
  integridade das dependências.

**Fora do escopo**

- Problemas de servidor, autenticação e tomada de conta: nenhum dos três
  existe aqui.
- Vulnerabilidades nos pacotes que os samples do catálogo apenas demonstram.
  Elas pertencem aos mantenedores deles; relate na origem.
- O comportamento do próprio SDK do Google Mobile Ads, que é do Google.

Relatos sobre o [site](https://flutterguide.app) pertencem àquele projeto, não
a este repositório.
