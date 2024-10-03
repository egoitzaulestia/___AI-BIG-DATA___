library(ggvis)
library(dplyr)
if (FALSE) {
  library(RSQLite)
  library(dbplyr)
}

db <- src_sqlite("C:/Users/User/Desktop/Shiny_MED/38-GraficoDinamico/movies.db")
omdb <- tbl(db, "omdb")
tomatoes <- tbl(db, "tomatoes")

print(db)
print(omdb)
print(tomatoes)