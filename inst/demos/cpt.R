# preparacao --------------------------------------------------------------

library(bizdays)
library(changepoint)

da <- readr::read_rds("inst/data/cpt.rds") |>
  dplyr::filter(dt_dist >= as.Date("2023-02-01") & dt_dist < as.Date("2023-05-29") |
                  dt_dist >= as.Date("2024-02-01") & dt_dist < as.Date("2024-05-29")) |>
  dplyr::select(processo, cd_processo, dt_dist) |>
  dplyr::mutate(
    ano = lubridate::year(dt_dist) |>
      forcats::as_factor(),
    mes = lubridate::month(dt_dist),
    semana = lubridate::week(dt_dist),
    dt_md = format(as.Date(dt_dist), "%m-%d"),
    fds = lubridate::wday(dt_dist, label = TRUE),
    fds = fds %in% c("sáb", "dom"),
    bzd = bizdays::is.bizday(dt_dist, "Brazil/ANBIMA")
  ) |>
  dplyr::filter(
    bzd,
    mes <= 5 & mes > 1
  ) |>
  dplyr::filter(ano == 2024) |>
  dplyr::select(processo, dt_dist)

da_2024 <- da |>
  dplyr::count(dt_dist) |>
  dplyr::arrange(dt_dist) |>
  dplyr::transmute(
    index = dplyr::row_number(),
    dt_dist,
    n
  )

n2024 <- da_2024$n

plot(n2024, type = "l")

# demonstracao visual ------------------------------------------------------------------

cpt <- tibble::tibble()
n <- length(n2024)
for(t in 1:(n-1)) {
  # Define segments
  segment1 <- n2024[1:t]
  segment2 <- n2024[(t+1):n]

  # Calculate residuals within each segment
  mu1 <- mean(segment1)
  resid1 <- (segment1-mu1)^2
  mu2 <- mean(segment2)
  resid2 <- (segment2-mu2)^2

  # Join the residuals
  residuals <- c(resid1, resid2)

  # Sum up all the residuals
  resid_totais <- sum(residuals)

  # CUSUM
  scalling_factor <- sqrt((t*(n-t))/n)
  mean_dif <- abs(mu1-mu2)
  c <- scalling_factor*mean_dif

  # Create de-para elemento position and its value
  ponto <- tibble::tibble(
    t,
    resid = sqrt(resid_totais/80),
    c = c,
    scalling_factor,
    mean_dif
  )

  # Create the data base with all elements
  cpt <- cpt |>
    dplyr::bind_rows(ponto)

  plot(dplyr::select(cpt, t, resid))
  # plot(dplyr::select(cpt, t, c))

  # Sys.sleep(0.2)

}

# Plot it
resid <- cpt |>
  ggplot2::ggplot() +
  ggplot2::aes(x = t, y = resid) +
  ggplot2::geom_point(color="steelblue") +
  ggplot2::geom_vline(
    xintercept = cpt |>
      dplyr::filter(resid == min(resid)) |>
      dplyr::pull(t),
    linetype = 2,
    color = "orange",
    size = .9
  ) +
  ggthemes::theme_solarized()

cusum <- cpt |>
  ggplot2::ggplot() +
  ggplot2::aes(x = t, y = c) +
  ggplot2::geom_point(color="steelblue") +
  ggplot2::geom_vline(
    xintercept = cpt |>
      dplyr::filter(c == max(c)) |>
      dplyr::pull(t),
    linetype = 2,
    color = "orange",
    size = .9
  ) +
  ggthemes::theme_solarized()

gridExtra::grid.arrange(resid, cusum, ncol = 1)

which.min(cpt$resid)

cpt |>
  dplyr::filter(point_location == which.min(cpt$resid))

# function ----------------------------------------------------------------

amoc_2024 <- changepoint::cpt.mean(n2024, method = "AMOC")
plot(amoc_2024)
cpts_2024 <- cpts(amoc_2024)
