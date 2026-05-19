# Dos Dados aos Gráficos

Material didático em formato de website Quarto, cobrindo fundamentos da visualização de dados, principais tipos de gráficos e pensamento crítico sobre representação gráfica. Todos os exemplos são executados em R com `ggplot2` e pacotes auxiliares.

Publicado em: <https://henriquealvarenga.github.io/graficos>

---

## ⚠️ Antes de cada `git push`: rode `quarto render` localmente

Este repositório usa a **Estratégia A**: o diretório `_freeze/` é **versionado** e o CI no GitHub Actions só executa `quarto render` reusando o congelamento — **não instala R nem roda os chunks**.

Se você esquecer de rodar `quarto render` antes do push:

- o site no GitHub Pages fica desatualizado em relação aos `.qmd` modificados, ou
- se você adicionou um chunk novo sem cache em `_freeze/`, o build no Actions falha (não há R disponível no CI).

Sempre:

```bash
quarto render
git add -A
git commit -m "..."
git push
```

---

## Estrutura

```
.
├── _quarto.yml              # configuração do website Quarto
├── _common.R                # setup R compartilhado pelos capítulos
├── custom.scss              # tema visual customizado
├── index.qmd                # página inicial
├── about.qmd                # página "Sobre"
├── cap00…cap15-*.qmd        # capítulos do livro
├── data/                    # CSVs lidos pelos chunks
├── images/                  # imagens estáticas (logo, ilustrações)
├── references/              # bibliografia (.bib) e CSL
├── OTHER_YAML/              # configs alternativas (versão PDF, etc.)
├── _freeze/                 # ✅ VERSIONADO — congelamento de chunks
├── docs/                    # ❌ IGNORADO — gerado pelo CI
└── .github/workflows/
    └── publish.yml          # build + deploy no GitHub Pages
```

---

## Estratégia de publicação

GitHub Pages está em modo **"GitHub Actions"** (não "Deploy from a branch"). O fluxo é:

1. Você edita os `.qmd` localmente.
2. Roda `quarto render` — atualiza `_freeze/` (e regenera `docs/` localmente, mas `docs/` é ignorado pelo git).
3. `git add -A && git commit && git push`.
4. O workflow [`.github/workflows/publish.yml`](.github/workflows/publish.yml) faz checkout, roda `quarto render` (instantâneo, porque reusa `_freeze/`), empacota `docs/` e publica via `actions/deploy-pages`.

### Por que a Estratégia A?

Os capítulos usam pacotes R pesados e variados (`tidyverse`, `plotly`, `survival`, `survminer`, `datasauRus`, `HistData`, `DAAG`, `gapminder`, `kableExtra`, …). Sem um `renv.lock`, instalar tudo no CI a cada push seria lento (5–15 min) e frágil. Versionar `_freeze/` torna o build no Actions trivial e determinístico — o preço é a disciplina de rodar `quarto render` antes do push.

---

## Publicação manual

Sequência completa para publicar:

```bash
quarto render
git add -A
git commit -m "descrição da mudança"
git push
```

Acompanhe o build em <https://github.com/henriquealvarenga/graficos/actions>.
