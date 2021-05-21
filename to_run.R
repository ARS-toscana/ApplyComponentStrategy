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
source("ApplyComponentStrategy_v15.R")
source("CreateFigureComponentStrategy_v4.R")



###################################################################
#           ASSIGN PARAMETERS OF THE INPUT FILES
###################################################################

input<-fread(paste0(dirinput,"ese1.csv"))


output <- ApplyComponentStrategy(dataset = input,
                                 individual = F,
                                 components = c("emergency_room_diagnosis",
                                                "hospitalisation_primary",
                                                "hospitalisation_secondary"),
                                 labels_of_components = c("emergency_room_diagnosis",
                                                          "hospitalisation_primary",
                                                          "hospitalisation_secondary"),
                                 composites_to_be_created=list(list(2, 3)),
                                 labels_of_composites_to_be_created=c("H, all"),
                                 pairs_to_be_compared=list(list(1,4),
                                                           list(2,3)),
                                 labels_of_pairs_to_be_compared = c("ER  vs H All",
                                                                    "H primary vs H secondary"),
                                 figure_name="example_1",
                                 K=10000,
                                 count_var="N",
                                 figure=T,
                                 aggregate=F ,
                                 output_name= paste0( diroutput, "output_example"),
                                 dirfigure= dirfigure
)