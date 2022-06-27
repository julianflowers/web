#install.packages("devtools")
devtools::install_github("kth-library/semanticscholar", dependencies = TRUE)
library(semanticscholar)
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
suppressPackageStartupMessages(library(purrr))
library(knitr)

# get a paper using an identifier
paper <- S2_paper("arXiv:1705.10311", include_unknown_refs = TRUE)



semanticscholar::S2_search_papers(keyword = "large herbivore climate change", offset = 101, limit = 100)

# authors on that paper
authors <- paper$authors

# for one of the authors
author_ids <- authors$authorId
author <- S2_author(author_ids[1])

# get just paper count, citation count and hIndex for a specific author
countz <- S2_author2(author_ids[1], fields = "url,paperCount,citationCount,hIndex")
countz %>% dplyr::as_tibble()
#> # A tibble: 1 × 5
#>   authorId url                                   paperCount citationCount hIndex
#>   <chr>    <chr>                                      <int>         <int>  <int>
#> 1 3324024  https://www.semanticscholar.org/auth…         31          1127     12

# for a specific paper, get the TLDR;

S2_paper2(identifier = "649def34f8be52c8b66281af98ae884c09aef38b", fields="tldr")$tldr$text
#> [1] "This paper reduces literature graph construction into familiar NLP tasks, point out research challenges due to differences from standard formulations of these tasks, and report empirical results for each task."

# list some of the papers
papers <- 
  author$papers %>% 
  select(title, year)

papers %>% head(5) %>% knitr::kable()
