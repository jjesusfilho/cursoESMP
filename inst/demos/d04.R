
# base R x pacotes --------------------------------------------------------

data <- data.frame(
  x = 1:10,
  y = 15:24
)

plot(x = data$x, y = data$y)

ggplot2::ggplot(data) +
  ggplot2::aes(x = x, y = y) +
  ggplot2::geom_point()


# função -----------------------------------------------------------------

ricardo <- 1:10
objeto2 <- 11:20

plot(x = Feliz, y = valorABACAXI)

?plot


# filter ------------------------------------------------------------------

# Precisa conter expressões lógicas
da <- tibble::tibble(
  letras = letters[1:10],
  numeros = 1:10
)

da$numeros

da$numeros == 2 # o que é esperado disso?

# vetores
# vetores atômicos
# listas
# podem ter elementos de tamanhos (lenght) diferentes
# mas para uma lista ser uma base de dados, então
# todos os elementos da lista precisam ser do mesmo
# tamanho

vetor <- c("primeiro elemento", "segundo elemento", "terceiro elemento", "quarto elemento")
vetor <- c("primeiro elemento", "segundo elemento", NA, "terceiro elemento", "quarto elemento")

minha_tibble <- tibble::tibble(
  a = c(1, 2, 3, 4, NA),
  b = c("a", "b", "c", "d", "d")
)

a[1]
b[1]

# 1) listas se tornam bases de dados ou tibbles,
# com vetores de igual tamanho
# 2) vetores se tornam colunas
# 3) a posição dos elementos em cada vetor se torna uma linha

# filter ------------------------------------------------------------------
base <- tibble::tibble(
  id = letters[1:10],
  valor = 1:10
)

valor <- 1:10

valor %% 2

dplyr::filter(base, valor %% 2 == 1)


# select ------------------------------------------------------------------

base_para_select <- tibble::tibble(
  letras = letters[1:5], # letters
  numeros = 1:5,
  blabla = letters[1:5],
  excluir = blabla
)

dplyr::select(base_para_select, coisinhas = letras)


# mutate ------------------------------------------------------------------

base_para_mutate <- tibble::tibble(
  id = letters[1:5],
  valor = 1:5
)

dplyr::mutate(base_para_mutate,
              valor = valor*2)

# pipe --------------------------------------------------------------------
base_original <- tibble::tibble(
  id = letters[1:5],
  valor = 1:5
)

base_original_com_valor_duplicado <- dplyr::mutate(base_original, valor_duplicado = valor*2)
base_valor_duplicado_filtrada <- dplyr::filter(base_original_com_valor_duplicado, valor_duplicado  > 5)
base_final <- dplyr::select(base_valor_duplicado_filtrada, id, valor_duplicado)

base_final <- tibble::tibble(
  id = letters[1:5],
  valor = 1:5
) |>
  dplyr::mutate(
    valor_duplicado = valor*2
  ) |>
  dplyr::filter(
    valor_duplicado > 5
  ) |>
  dplyr::select(id, valor_duplicado)

# recebe uma base
# retorna uma base


