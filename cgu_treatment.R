#testes

library(dplyr)
library(readr)

simec <- read.csv(url("http://simec.mec.gov.br/painelObras/download.php"), sep=";",
                  na.strings = c(" ", ""))


cgu <- read_delim("C:/Users/jvoig/OneDrive/Documentos/planilha_nova_cgu/cgu.csv", 
                  ";", escape_double = FALSE, col_types = cols(CHAVE = col_character()), 
                  locale = locale(), trim_ws = TRUE)

cgu <- cgu %>%
  select(1:35) %>%
  rename(ID = CHAVE)

length(unique(cgu$ID)) == nrow(cgu) #TRUE , não há duplicatas.
n_occur <- data.frame(table(cgu$ID))

idsimec <- simec %>%
  mutate(ID = as.character(ID)) %>%
  select(ID, Nome)

idcgu <- cgu %>%
  select(ID) %>%
  left_join(idsimec)
