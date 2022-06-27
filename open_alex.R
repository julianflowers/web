## open alex https://docs.openalex.org/

devtools::install_github("kth-library/openalex", dependencies = TRUE)

library(openalex); library(jsonlite); library(tidyverse)

openalex::openalex_polite("jrf128@student.aru.ac.uk")

concepts <- "https://api.openalex.org/concepts"

concepts_db <- fromJSON(concepts, simplifyDataFrame = TRUE)

glimpse(concepts_db)

search <- 'https://api.openalex.org/works?search="%22large%20herbivores%22"&per-page=200&cursor=Ils4OC4zNjQ5NiwgMTA1OTg2ODgwMDAwMCwgJ2h0dHBzOi8vb3BlbmFsZXgub3JnL1cxOTY0MjE0MjI3J10i'

res <- fromJSON(search, simplifyDataFrame = TRUE)


res$meta

res$results$title


get_alex_results <- function(n = 200, search){
  
  require(jsonlite)
  
  search <- search
  
  n= n
  
  search <- paste0("%22", str_replace_all(search, "\\s", "%20"), "%22")
  
  uri <- paste0('https://api.openalex.org/works?search=', "'", search, "'", "&per-page=", n, "&cursor=*")
  
  res <- fromJSON(uri, simplifyDataFrame = TRUE)
  
  cursor <- res$meta$next_cursor
  
  uri1 <- paste0('https://api.openalex.org/works?search=', "'", search, "'", "&per-page=", n, "&cursor=", cursor)
  
  
  
}

test <- get_alex_results(search = "large herbivores")

test$meta
