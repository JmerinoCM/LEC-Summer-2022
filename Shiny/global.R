#setwd("D:/Escritorio/Shiny del sabado/Shiny")

#### Librerias ####

library(shiny) # libreria base
library(shinydashboard) # apariencia del shiny
library(tidyverse) # operar objetos
library(ggplot2)
library(ggthemes) # temas para ggplot
library(viridis)
library(shinyWidgets)
library(plotly)
library(DT)
library(reactable) 
library(htmltools)
library(shinyjs)
library(echarts4r)
library(paletteer)
### Cargar datos ####

allcombi <- read.csv(file = 'www/allcombi.csv')
allcombi <- allcombi[-1]
allcombi_t <- read.csv(file = 'www/allcombi_t.csv')
allcombi_t <- allcombi_t[-1]
w8_agr_rank_t <- read.csv(file = 'www/w8_agr_rank_t.csv')
w8_agr_rank_t <- w8_agr_rank_t[-1]

teams <- names(w8_agr_rank_t)
teams_ext <- c("Posicion",teams)
posiciones_v <- data.frame(Posicion=seq(1:10))


m6 <- c("BDS","RGE")
m7 <- c("SK","XL")
m8 <- c("MAD","AST")
m9 <- c("VIT","FNC")
m10 <- c("MSF","G2")
m11 <- c("XL","AST")
m12 <- c("BDS","MAD")
m13 <- c("SK","G2")
m14 <- c("VIT","RGE")
m15 <- c("MSF","FNC")


# Filtros dinamicos ####
allcombi2 <- allcombi
allcombi2$seq <- seq(1:ncol(allcombi_t))

##### Grafica chart4R

teams_list_tree <- c("AST","BDS","FNC","G2","MAD","MSF","RGE","SK","VIT","XL")
AST_tree <- rep("AST",10)
BDS_tree <- rep("BDS",10)
FNC_tree <- rep("FNC",10)
G2_tree <- rep("G2",10)
MAD_tree <- rep("MAD",10)
MSF_tree <- rep("MSF",10)
RGE_tree <- rep("RGE",10)
SK_tree <- rep("SK",10)
VIT_tree <- rep("VIT",10)
XL_tree <- rep("XL",10)
every_tree <- rep("Everything",10)
rank_tree <- c("1","2","3","4","5","6","7","8","9","10")
teams_list_tree_vals <- rep(100,10)
#cero_list_tree <- rep(10,100)
posiciones_tree <- c("",
                     AST_tree,
                     BDS_tree,
                     FNC_tree,
                     G2_tree,
                     MAD_tree,
                     MSF_tree,
                     RGE_tree,
                     SK_tree,
                     VIT_tree,
                     XL_tree,
                     every_tree)
equipos_tree <- c("Everything",
                  rank_tree,
                  rank_tree,
                  rank_tree,
                  rank_tree,
                  rank_tree,
                  rank_tree,
                  rank_tree,
                  rank_tree,
                  rank_tree,
                  rank_tree,
                  teams_list_tree)

#####
AST_tree_2 <- rep("AST",2)
BDS_tree_2 <- rep("BDS",2)
FNC_tree_2 <- rep("FNC",2)
G2_tree_2 <- rep("G2",2)
MAD_tree_2 <- rep("MAD",2)
MSF_tree_2 <- rep("MSF",2)
RGE_tree_2 <- rep("RGE",2)
SK_tree_2 <- rep("SK",2)
VIT_tree_2 <- rep("VIT",2)
XL_tree_2 <- rep("XL",2)
# play_prev_tree <- c("Playoffs","No")
# class_si_tree <- rep(play_prev_tree,10)
class_si_tree <- c("Playoffs AST","No AST",
                   "Playoffs BDS","No BDS",
                   "Playoffs FNC","No FNC",
                   "Playoffs G2","No G2",
                   "Playoffs MAD","No MAD",
                   "Playoffs MSF","No MSF",
                   "Playoffs RGE","No RGE",
                   "Playoffs SK","No SK",
                   "Playoffs VIT","No VIT",
                   "Playoffs XL","No XL")
# class_rank <- c(rep("Playoffs",6),rep("No", 4))
# class_rank_tree <- rep(class_rank,10)
class_rank_tree <- c(rep("Playoffs AST",6),rep("No AST",4),
                     rep("Playoffs BDS",6),rep("No BDS",4),
                     rep("Playoffs FNC",6),rep("No FNC",4),
                     rep("Playoffs G2",6),rep("No G2",4),
                     rep("Playoffs MAD",6),rep("No MAD",4),
                     rep("Playoffs MSF",6),rep("No MSF",4),
                     rep("Playoffs RGE",6),rep("No RGE",4),
                     rep("Playoffs SK",6),rep("No SK",4),
                     rep("Playoffs VIT",6),rep("No VIT",4),
                     rep("Playoffs XL",6),rep("No XL",4))
rank_tree_10 <- rep(rank_tree,10)
#clas_si_vals <- c(rep(10,6),rep(10, 4)) # <- valores del acumulado
posiciones_tree_2 <- c("",
                     every_tree,
                     AST_tree_2,
                     BDS_tree_2,
                     FNC_tree_2,
                     G2_tree_2,
                     MAD_tree_2,
                     MSF_tree_2,
                     RGE_tree_2,
                     SK_tree_2,
                     VIT_tree_2,
                     XL_tree_2,
                     class_rank_tree
                     )
equipos_tree_2 <- c("Everything",
                  teams_list_tree,
                  class_si_tree,
                  rank_tree_10
                  )


