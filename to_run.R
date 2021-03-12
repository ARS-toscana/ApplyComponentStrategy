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

input<-fread(paste0(dirinput,"input.csv"))


output<- ApplyComponentStrategy(dataset = input,
                                individual = F,         ## F -> data counts
                                intermediate_output=T, 
                                intermediate_output_name=paste0(dirtemp,"intermediate output"), 
                                components=c("alg1","alg2","alg3","alg4"),
                                composites=list(
                                  list(1,3),
                                  list(1,2),
                                  list(3,4),
                                  list(5,2),
                                  list(5,4),
                                  list(2,4), 
                                  list(5,10),
                                  list(6,7)),
                                labels_of_components=c(
                                  "Narrow, meaning H",
                                  "Possible, meaning H",
                                  "Narrow, meaning P",
                                  "Possible, meaning P"),
                                labels_of_composites = c("Narrow", "H", "P", "Narrow and Possible H",
                                                         "Narrow and Possible P", "Possible", "all", "all"),
                                count_var = 'persons',      ## only if individual = F
                                expected_number="N_TRUE",   ## optional
                                K=1000,
                               #strata=list("orderDS") ,
                               aggregate=F,
                               dirfigure= dirfigure,
                               figure_name = "namefiguretest" ,
                               output_name= paste0(diroutput,"output_dataset")
                               )
