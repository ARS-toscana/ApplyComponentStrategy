##################################################################################
#####################           Venn diagram               #######################
##################################################################################

#install.packages("RColorBrewer")
#install.packages("ggVennDiagram")

library(VennDiagram)
library(RColorBrewer)

# Generate 3 sets 
set.seed(9)
A1 <- paste(rep("Algorithm_" , 500) , sample(c(1:1000) , 500 , replace=F) , sep="")
A2 <- paste(rep("Algorithm_" , 500) , sample(c(1:1000) , 500 , replace=F) , sep="")
A3 <- paste(rep("Algorithm_" , 500) , sample(c(1:1000) , 500 , replace=F) , sep="")

# Prepare a palette of 3 colors with R colorbrewer:
myCol <- brewer.pal(3, "Dark2")

# Chart
venn.diagram(
  x = list(A1, A2, A3),
  category.names = c("Narrow, meaning H", "Narrow, meaning P" , "Possible, meaning H"),
  filename = 'venn_diagramm.png',
  output=TRUE,
  
  # Output features
  imagetype="png" ,
  height = 880 ,
  width = 880 ,
  resolution = 300,
  compression = "lzw",

  # Circles
  lwd = 2,
  lty = 'blank',
  fill = myCol,
  
  # Numbers
  cex = .6,
  fontface = "bold",
  fontfamily = "sans",
  
  # Set names
  cat.cex = 0.6,
  cat.fontface = "bold",
  cat.default.pos = "outer",
  cat.pos = c(-27, 27, 135),
  cat.dist = c(0.055, 0.055, 0.085),
  cat.fontfamily = "sans",
  rotation = 1
)

##################################################################################
#####################       ApplyComponentStrategy         #######################
##################################################################################

rm(list=ls())

#load libraries
if (!require("rstudioapi")) install.packages("rstudioapi")
library(rstudioapi)
if (!require("data.table")) install.packages("data.table")
library(data.table)

#set the directory where the script is saved as the working directory
thisdir<-setwd(dirname(rstudioapi::getSourceEditorContext()$path))
thisdir<-setwd(dirname(rstudioapi::getSourceEditorContext()$path))

#set directories for input and output
diroutput <- paste0(thisdir,"/g_output/")
dirtemp <- paste0(thisdir,"/g_intermediate/")
dirinput <- paste0(thisdir,"/input/")
dirfigure <- paste0(thisdir,"/g_figure/")


# CREATE FOLDERs
suppressWarnings(if (!file.exists(diroutput)) dir.create(file.path( diroutput)))
suppressWarnings(if (!file.exists(dirtemp)) dir.create(file.path( dirtemp)))
suppressWarnings(if (!file.exists(dirfigure)) dir.create(file.path( dirfigure)))

# load the function
setwd(thisdir)
source("ApplyComponentStrategy_v13_2.R")
source("CreateFigureComponentStrategy_v4.R")



###################################################################
#           ASSIGN PARAMETERS OF THE INPUT FILES
###################################################################

input<-fread(paste0(dirinput,"input_example.csv"))


output<- ApplyComponentStrategy(dataset = input,
                                individual = F,         ## F -> data counts
                                intermediate_output=T, 
                                intermediate_output_name=paste0(dirtemp,"intermediate output"), 
                                components=c("Narrow, meaning H",
                                             "Possible, meaning H",
                                             "Narrow, meaning P"),
                                composites_to_be_compared=list(list(1, 2)),
                                labels_of_composites_to_be_compared=c("All Narrow"),
                                composites=list(list(4, 3)),
                                labels_of_components=c(
                                  "Narrow, meaning H",
                                  "Narrow, meaning P",
                                  "Possible, meaning H"),
                                labels_of_composites = c("All Narrow VS Possible, meaning H"),
                                count_var = 'Person',      ## only if individual = F
                                #expected_number="N_TRUE",   ## optional
                                #K=1000,
                                #strata=list("orderDS") ,
                                aggregate=F,
                                dirfigure= dirfigure,
                                figure_name = "Example_figure" ,
                                output_name= paste0(diroutput,"output_dataset")
)