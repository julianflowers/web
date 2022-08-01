## open alex https://docs.openalex.org/

devtools::install_github("kth-library/openalex", dependencies = TRUE)
install.packages("https://github.com/nleguillarme/taxonerd/releases/download/v1.3.3/taxonerd_for_R_1.3.3.tar.gz", repos=NULL)
vignette("taxonerd") # See vignette for more information on how to install and use TaxoNERD for R

library(openalex); library(jsonlite); library(tidyverse); library(readtext); library(pdftools);library(taxonerd)

openalex::openalex_polite("jrf128@student.aru.ac.uk")

search <- 'https://api.openalex.org/works?search="%22large%20herbivores%22"&per-page=200&cursor=Ils4OC4zNjQ5NiwgMTA1OTg2ODgwMDAwMCwgJ2h0dHBzOi8vb3BlbmFsZXgub3JnL1cxOTY0MjE0MjI3J10i'

res <- fromJSON(search, simplifyDataFrame = TRUE)


res$meta

res$results$title


get_alex_results <- function(n = 200, search){
  
  require(jsonlite)
  require(dplyr)
  require(purrr)
  
  search <- search
  
  n= n
  
  search <- paste0("%22", str_replace_all(search, "\\s", "%20"), "%22")
  
  uri <- paste0('https://api.openalex.org/works?search=', "'", search, "'", "&per-page=", n, "&cursor=*")
  
  res <- fromJSON(uri, simplifyDataFrame = TRUE)
  
  cursor <- res$meta$next_cursor
  
  uri1 <- paste0('https://api.openalex.org/works?search=', "'", search, "'", "&per-page=", n, "&cursor=", cursor)
  
  out <- list(results = res)
  
}

test <- get_alex_results(search = "herbivory climate")

test

glimpse(test)

test$results$results$title |> head()

safe_read <- safely(pdftools::pdf_text)

test1 <- test$results$results$open_access |>
  filter(is_oa == TRUE) |>
  slice(2:3) |>
  mutate(text = map(oa_url, ~safe_read(.x))) |>
  unnest("text") 

test1 |>
  slice(c(1, 3)) |>
  unnest("text") |>
  DT::datatable(escape=TRUE)
