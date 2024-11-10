# O que é argumento
meus_numeros <- 1:5

sum(... = meus_numeros)

# Como funciona o pipe
# EXEMPLO SEM PIPE
# Criei 1 base
base <- tibble::tibble(
  id = letters[1:5],
  valores = 1:5
)

# Criei uma segunda base
base_com_valor_triplicado <- dplyr::mutate(base, valor_dobrado = valores*3)

# Criei uma terceira base
base_final <- dplyr::filter(base_com_valor_triplicado, valor_dobrado %% 2 == 0)

# EXEMPLO COM PIPE
tibble::tibble(
  id = letters[1:5],
  valores = 1:5
) |>
  dplyr::mutate(valor_dobrado = valores*3) |>
  dplyr::filter(valor_dobrado %% 2 == 0)



# mutate ------------------------------------------------------------------

tibble::tibble(
  id = letters[1:5],
  valores = 1:5
) |>
  dplyr::mutate(valor_dobrado = valores*3)


# funções que resumem 1: count() -------------------------------------------

tibble::tibble(
  id = c("a", "a", "a", "c", "a", "b", "b", "c", "c", "c"),
  valor = c(1, 2, 1, 1, 1, 2, 3, 4, 5, 4)
) |>
  dplyr::count(id, valor, sort = TRUE)

# funções que resumem 2: summarise() --------------------------------------

sample(
  x = 1:10,
  size = 10,
  replace=TRUE
)

set.seed(3)
base_para_summarise <- tibble::tibble(
  id = c("a", "a", "a", "a", "a", "b", "b", "c", "c", "c"),
  valor = sample(1:10, 10, replace=T)
)

base_para_summarise |>
  dplyr::summarise(
    somatorio = sum(valor)
  )

# SIMULANDO O COUNT COM O SUMMARISE
base_para_summarise |>
  dplyr::count()

base_para_summarise |>
  dplyr::summarise(
    n = dplyr::n()
  )

# GROUP BY E UNGROUP
base_para_summarise |>
  dplyr::group_by(id) |>
  dplyr::summarise(
    somatorio = sum(valor)
  ) |>
  dplyr::ungroup()

# Funções que não sumarizam dados
base_para_summarise |>
  dplyr::summarise(
    valor_dobrado = valor * 2
  )


# explicando o ungroup()

base_intermediaria <- base_para_summarise |>
  dplyr::group_by(id) |>
  dplyr::ungroup()

base_intermediaria |>
  dplyr::group_by() |>
  dplyr::mutate(
    n_colunas = dplyr::n()
  ) |>
  dplyr::ungroup()

# media
base_para_summarise |>
  dplyr::group_by(id) |>
  dplyr::summarise(
    media = mean(valor)
  )

# mediana
base_para_summarise |>
  dplyr::group_by(id) |>
  dplyr::summarise(
    mediana = median(valor)
  )

# all()
# character
# numeric = double e integer
# logical (TRUE / FALSE)

set.seed(3)
base_para_summarise <- tibble::tibble(
  id = c("a", "a", "a", "a", "a", "b", "b", "c", "c", "c"),
  valores = sample(1:10, 10, replace=T),
  logicos = sample(c(TRUE, FALSE), 10, replace=T)
)

base_para_summarise |>
  dplyr::group_by(id) |>
  dplyr::summarise(
    somatoria = all(logicos)
    # Tudo é TRUE?
    # se sim, retorna TRUE
    # se não retorna FALSE
  ) |>
  dplyr::ungroup()

base_para_summarise |>
  dplyr::group_by(id) |>
  dplyr::summarise(
    somatoria = any(logicos)
    # Alguma coisa é TRUE?
    # se sim, retorna TRUE
    # se não retorna FALSE
  ) |>
  dplyr::ungroup()

vetor <- "a"

set.seed(3)
vetor <- sample(letters, 100, replace=T)

vetor = "a"

vetor == "a"


install.packages("remotes")
remotes::install_github("jjesusfilho/cursoESMP")

cursoESMP::dados


# stringr -----------------------------------------------------------------

txt <- "como será que funciona o pacote stringr?" # vetor atômico <chr>

# 1) exemplos e sintaxe (ok)
stringr::str_detect(string = txt, pattern = "z")
stringr::str_count(txt, "r")
stringr::str_remove(txt, "r")
stringr::str_extract_all(txt, "r")

# 2) a variante `all` das funções (ok)
stringr::str_remove(txt, "r")
stringr::str_remove_all(txt, "r")

# 3) a análise é feita para cada elemento do vetor (ok)
txts <- c(
  "este é o texto 1",
  "agora temos o texto 2",
  "e o texto 3 também!!",
  "o texto 4 tem dois textos"
)

stringr::str_detect(txts, "texto")

# Eu quero retirar, de cada elemento do vetor, a palavra 'texto'.
# Qual das funções abaixo irá funcionar?
stringr::str_remove(txts, "texto")
stringr::str_remove_all(txts, "texto")

# E agora?
txts2 <- c(
  "este é o texto 1",
  "agora temos o texto 2",
  "e o texto 3 também!!",
  "tem o texto 4 que contem duas palavras texto"
)

stringr::str_remove(txts2, "texto")
stringr::str_remove_all(txts2, "texto")


# 4) O pipe funciona !!!
stringr::str_remove(txts, "texto") |>
  stringr::str_detect("texto")

stringr::str_remove_all(txts, "texto") |>
  stringr::str_detect("texto")

# 5) pattern e regex
# REGular EXpression (REG EX)

txt_cnj <- c(
  "eu tenho um processo aqui 00000235120248260471",
  "aqui tem outro processo 0000035-74.2024.8.26.0177",
  "agora eu to com um número (0000079-36.2023.8.26.0660) que fica no meio do texto",
  "qual a diferença de um número de telefone +55 11 91827-8901 e de um número do CNJ? 00001461720238260299",
  "aqui tem dois numeros: 0000035-74.2024.8.26.0177 e 00000235120248260471"
)

# queremos retirar o número do CNJ de todos os casos
stringr::str_extract(txt_cnj, "[:digit:]")
stringr::str_extract(txt_cnj, "\\d")
stringr::str_extract_all(txt_cnj, "\\d")
stringr::str_extract(txt_cnj, ".")
stringr::str_extract(txt_cnj, "\\.")
stringr::str_extract(txt_cnj, "\\d{7}-?\\d{2}\\.?\\d{4}\\.?\\d\\.?\\d{2}\\.?\\d{4}")


stringr::str_extract(
  txt_cnj,
  "\\d{7}-?\\d{2}\\.?\\d{4}\\.?\\d\\.?\\d{2}\\.?\\d{4}"
)


stringr::str_extract_all(
  txt_cnj,
  "\\d{7}-?\\d{2}\\.?\\d{4}\\.?\\d\\.?\\d{2}\\.?\\d{4}"
)

# 6) em uma pipeline, isso fica assim:
tibble::tibble(
  txt = txt_cnj
) |>
  dplyr::mutate(
    id_processo = txt_cnj |>
      stringr::str_extract("\\d{7}-?\\d{2}\\.?\\d{4}\\.?\\d\\.?\\d{2}\\.?\\d{4}") |>
      stringr::str_remove_all("[:punct:]") |>
      stringr::str_squish()
  )

txt1 <- "Este texto trata do MCI"
txt2 <- "Vamos olhar para a LEI Nº 12.965, DE 23 DE ABRIL DE 2014"
txt3 <- "É um grande marco da internet a promulgação da LGPD"
txt4 <- "Quando falamos de internet, é importante olharmos para a lei n. 12.965/2014 e não para a lei n. 10.406/2002"
txt5 <- "Comparemos a Lei nº 12965/2014 com a Lei Nº 13.709/2018"
txt6 <- "O MarcO CIVil da InterNET é importante"

txts <- c(txt1, txt2, txt3, txt4, txt5, txt6)

# Forma 1 - SEM PIPE
textos_minusculo <- stringr::str_to_lower(txts)
txts_minusculo_sem_pontuacao <- stringr::str_remove_all(textos_minusculo, "[:punct:]|º")
stringr::str_detect(txts_minusculo_sem_pontuacao, "mci|marco civil da internet|12965")

# Forma 1 - COM PIPE
txts |>
  stringr::str_to_lower() |>
  stringr::str_remove_all("[:punct:]|º") |>
  stringr::str_detect("mci|marco civil da internet|12965")

# Forma 2
rgx <- stringr::regex("mci|marco civil da internet|12\\.?965",
                      ignore_case = TRUE)

stringr::str_detect(txts, rgx)

# Resposta para a Ana
txts |>
  stringr::str_detect("[lL][eE][iI]")



# lubridate ---------------------------------------------------------------

dt_txt_br <- "20/01/2024"
dt_txt_jp <- "2024/01/20"
dt_txt_us <- "01/20/2024"

dt_txt_br |>
  lubridate::dmy()


# licao -------------------------------------------------------------------

# 3.  A partir da base `cursoESMP::movimentacao`,
# crie uma base contendo apenas as movimentações de
# sentença, chamada `movimentacoes_sentenca`.
# Para isso, crie a coluna `eh_sentenca`,
# para identificar cada movimentação que se refere a
# uma sentença.

todos_os_movimentos_possiveis <- cursoESMP::movimentacao |>
  dplyr::distinct(movimento)

movimentacoes_sentenca <- cursoESMP::movimentacao |>
  dplyr::select(processo, dt_mov, movimento) |>
  dplyr::mutate(
    eh_sentenca = stringr::str_detect(movimento, "extinto|procedente|deferid")
    # 1. contorlar maiusculo e minusculo
    # 2. identificar de fato as movimentações corretas (trabalho de formiga)
  ) |>
  dplyr::filter(eh_sentenca)


# usando a funcao stringr::regex() ----------------------------------------

txt1 <- "Este texto trata do MCI"
txt2 <- "Vamos olhar para a LEI Nº 12.965, DE 23 DE ABRIL DE 2014"
txt3 <- "É um grande marco da internet a promulgação da LGPD"
txt4 <- "Quando falamos de internet, é importante olharmos para a lei n. 12.965/2014 e não para a lei n. 10.406/2002"
txt5 <- "Comparemos a Lei nº 12965/2014 com a Lei Nº 13.709/2018"
txt6 <- "O MarcO CIVil da InterNET é importante"

txts <- c(txt1, txt2, txt3, txt4, txt5, txt6)

rgx <- stringr::regex(
  pattern = "mci|marco civil",
  ignore_case = TRUE
)

stringr::str_detect(
  string = txts,
  pattern = rgx
)


# respondendo ao Talles ---------------------------------------------------


txt1 <- "Este texto trata do MCI"
txt2 <- "Vamos olhar para a LEI Nº 12.965, DE 23 DE ABRIL DE 2014"
txt3 <- "É um grande marco da internet a promulgação da LGPD"
txt4 <- "Quando falamos de internet, é importante olharmos para a lei n. 12.965/2014 e não para a lei n. 10.406/2002"
txt5 <- "Comparemos a Lei nº 12965/2014 com a Lei Nº 13.709/2018"
txt6 <- "O MarcO CIVil da InterNET é importante"

txts <- c(txt1, txt2, txt3, txt4, txt5, txt6)

# ao invés de atribuir para um objeto
# começa com txts
txts_minusculo <- stringr::str_to_lower(txts)
# vira txts_minusculo
# usa o txts_minusculo
stringr::str_detect(txts_minusculo,"MCI")
# retorna o produto final

# usar o pipe
txts |>
  stringr::str_to_lower() |>
  stringr::str_detect(
    # string = txts,
    pattern = "mci|marco civil da internet"
  )

# crtl + shift + m
# 1) %>% # pipe do magrittr
# 2) |> # pipe nativo do R

