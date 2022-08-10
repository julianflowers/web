p <- here::here("~/Desktop/MOD007045/MOD007045/What works in conservation/XML-edition")
xml <- list.files(p, "xml", full.names = T)

xml

library(rvest); library(xml2);library(furrr)

xml_extract <- function(xml){read_xml(xml) |> html_text()}

book <- future_map(xml, xml_extract)

book_df <- enframe(book) |>
  unnest(value)

head()

book_df |>
  mutate(value = str_split(value, "http://www.conservationevidence.com/actions")) |>
  unnest("value") |>
  write_csv("wwic.csv")

|> 
  gt::gt()
)

library(quanteda)

corp <- corpus(book_df, text_field = "value")
kwic(corp, "Threat", window = 10) |>
  data.frame() |>
  DT::datatable()
