

anatocismo <- "15053"

classes <- "8714,8501"

tjsp::tjsp_baixar_cjpg(assunto = anotocismo,
classe = classes,
diretorio = "data-raw/cjpg")

tjsp::tjsp_baixar_cjpg(assunto = anatocismo,
classe = classes,
diretorio = "data-raw/cjpg")

cjpg <- tjsp::tjsp_ler_cjpg(diretorio = "data-raw/cjpg")

cd_processo <- unique(cjpg$cd_doc)

saveRDS(cjpg, "data/cjpg.rds")


cd_processo <- unique(cjpg$cd_doc) |>
JurisMiner::dividir_sequencia(g  = 2)

purrr::walk(cd_processo, ~{
tjsp::tjsp_autenticar()
tjsp::tjsp_baixar_cpopg_cd_processo(.x, diretorio = "data-raw/cpopg")
})

a <- JurisMiner::listar_arquivos("data-raw/cpopg")

dados <- tjsp::tjsp_ler_dados_cpopg(a)

saveRDS(dados, "data/dados.rds")

partes <- tjsp::tjsp_ler_partes(a)

saveRDS(partes,"data/partes.rds")

mov <- tjsp::tjsp_ler_movimentacao(a)

saveRDS(mov,"data/movimentacao.rds")
