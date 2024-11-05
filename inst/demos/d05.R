txt <- "como será que funciona o pacote stringr?" # vetor atômico <chr>

# 1) exemplos e sintaxe
stringr::str_detect(string = txt, pattern = "r")
stringr::str_count(txt, "r")
stringr::str_remove(txt, "r")
stringr::str_extract(txt, "r")

# 2) a variante `all` das funções
stringr::str_remove(txt, "r")
stringr::str_remove_all(txt, "r")

# 3) a análise é feita para cada elemento do vetor
txts <- c(
  "este é o texto 1",
  "agora temos o texto 2",
  "e o texto 3 também!!"
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
txt_cnj <- c(
  "eu tenho um processo aqui 00000235120248260471",
  "aqui tem outro processo 0000035-74.2024.8.26.0177",
  "agora eu to com um número (0000079-36.2023.8.26.0660) que fica no meio do texto",
  "qual a diferença de um número de telefone +55 11 91827-8901 e de um número do CNJ? 00001461720238260299"
)

# queremos retirar o número do CNJ de todos os casos
stringr::str_extract(txt_cnj, "[:digit:]")
stringr::str_extract(txt_cnj, "\\d")
stringr::str_extract_all(txt_cnj, "\\d")
stringr::str_extract(txt_cnj, ".")
stringr::str_extract(txt_cnj, "\\.")
stringr::str_extract(txt_cnj, "\\d{7}-?\\d{2}\\.?\\d{4}\\.?\\d\\.?\\d{2}\\.?\\d{4}")

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
