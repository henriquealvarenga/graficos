# ==============================================================
# _common.R — Configurações compartilhadas do site
# Gráficos — Visualizando Dados
# Henrique Alvarenga da Silva
# ==============================================================

# --- Bibliotecas ---
library(tidyverse)
library(ggplot2)
library(plotly)
library(scales)
library(patchwork)
library(knitr)
library(kableExtra)
library(cowplot)

# --- Paleta de cores do projeto ---
cores <- list(
  azul = "#2563EB",
  roxo = "#7C3AED",
  verde = "#059669",
  ciano = "#0891B2",
  ambar = "#D97706",
  vermelho = "#DC2626",
  rosa = "#DB2777",
  escuro = "#1E293B",
  cinza = "#64748B",
  claro = "#F8FAFC"
)

# Paleta categórica principal (até 8 grupos)
paleta_cat <- c(
  "#2563EB",
  "#059669",
  "#D97706",
  "#DC2626",
  "#7C3AED",
  "#0891B2",
  "#DB2777",
  "#64748B"
)

# Paleta para 2 grupos (ex: sexo)
paleta_sexo <- c("female" = "#ef24c6ff", "male" = "#2563EB")

# Paleta sequencial
paleta_seq <- c("#DBEAFE", "#93C5FD", "#3B82F6", "#1D4ED8", "#1E3A8A")

# --- Tema ggplot2 customizado ---
tema_graficos <- function(base_size = 13) {
  theme_minimal(base_size = base_size) +
    theme(
      # Texto
      text = element_text(family = "sans", color = "#334155"),
      plot.title = element_text(
        face = "bold",
        size = rel(1.3),
        color = "#0F172A",
        margin = margin(b = 8)
      ),
      plot.subtitle = element_text(
        size = rel(0.95),
        color = "#64748B",
        margin = margin(b = 15)
      ),
      plot.caption = element_text(
        size = rel(0.75),
        color = "#94A3B8",
        hjust = 1,
        margin = margin(t = 10)
      ),
      # Eixos
      axis.title = element_text(
        face = "bold",
        size = rel(0.9),
        color = "#475569"
      ),
      axis.text = element_text(size = rel(0.85), color = "#64748B"),
      axis.line = element_line(color = "#CBD5E1", linewidth = 0.5),
      axis.ticks = element_line(color = "#CBD5E1", linewidth = 0.3),
      # Grid
      panel.grid.major = element_line(color = "#F1F5F9", linewidth = 0.4),
      panel.grid.minor = element_blank(),
      # Legenda
      legend.position = "bottom",
      legend.title = element_text(face = "bold", size = rel(0.85)),
      legend.text = element_text(size = rel(0.8)),
      legend.background = element_rect(fill = "transparent"),
      legend.key = element_rect(fill = "transparent"),
      # Facets
      strip.text = element_text(
        face = "bold",
        size = rel(0.9),
        color = "#1E293B",
        margin = margin(b = 5, t = 5)
      ),
      strip.background = element_rect(fill = "#F1F5F9", color = NA),
      # Margens
      plot.margin = margin(15, 15, 15, 15),
      plot.background = element_rect(fill = "white", color = NA),
      panel.background = element_rect(fill = "white", color = NA)
    )
}

# Aplicar tema como padrão
theme_set(tema_graficos())

# --- Carregar datasets ---
# Dataset diabetes (403 pacientes)
pacientes <- read_csv("data/pacientes.csv", show_col_types = FALSE)

# Dataset dengue (período de incubação por sorotipo)
dengue <- read_delim(
  "data/dengue.csv",
  delim = ";",
  locale = locale(decimal_mark = ","),
  show_col_types = FALSE
)

# --- Funções auxiliares ---

# Converter ggplot para plotly com tema consistente
para_plotly <- function(p, ...) {
  ggplotly(p, ...) |>
    plotly::layout(
      font = list(family = "Inter, sans-serif"),
      hoverlabel = list(
        bgcolor = "white",
        font = list(family = "Inter, sans-serif", size = 13)
      )
    ) |>
    plotly::config(
      displayModeBar = TRUE,
      modeBarButtonsToRemove = c("lasso2d", "select2d"),
      displaylogo = FALSE,
      locale = "pt-BR"
    )
}

# Tabela formatada
tabela_bonita <- function(df, caption = NULL, ...) {
  kable(df, caption = caption, ...) |>
    kable_styling(
      bootstrap_options = c("striped", "hover", "condensed"),
      full_width = FALSE,
      position = "center"
    )
}

# Mensagem de setup
cat("✓ Configurações carregadas: tema, paleta e funções auxiliares\n")
