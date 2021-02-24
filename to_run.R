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
source("ApplyComponentStrategy_v13_1.R")
source("CreateFigureComponentStrategy_v3.R")



###################################################################
#           ASSIGN PARAMETERS OF THE INPUT FILES
###################################################################

#input<-fread(paste0(dirinput,"input_strata3.csv"))

# input <-fread(paste0(diroutput,"output.csv"))
input<-fread(paste0(dirinput,"input.csv"))


# prova <- ApplyComponentStrategy(dataset = input,
#                                numcomponents=4,
#                                namevar_labels= "ord_alg" ,
#                                namevar_10 ="PROP_10",
#                                namevar_11 ="PROP_11",
#                                namevar_01 ="PROP_01",
#                                namevar_ ="PROP_" ,
#                               namevar_TRUE = "PROP_TRUE" ,
#                                K=1000
#                                 )

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
                                count_var = 'persons',      ## only if individual = F
                                expected_number="N_TRUE",   ## optional
                                K=1000,
                              #strata=list("orderDS") ,
                              #  strata=list("orderDS","gender") ,   ## LIST
                               #strata=list("orderDS","gender","nation") ,    ## optional
                               aggregate=F,
                               figure_name = paste0(dirfigure,"namefiguretest") ,# add a parameter: figure_directory
                               output_name= paste0(diroutput,"output_dataset")
            
                               )
# 
# #output=fread(paste0(diroutput,"output.csv"))
# out <- CreateFigureComponentStrategy(dataset=input,
#                                 
#                                      # namevar_strata=c("orderDS","gender","nation"),   ## VECTOR
#                                       namevar_TRUE="PROP_TRUE",
#                                       K=1000,
#                                      numcomponents=4,
#                                      namevar_10 ="PROP_10",
#                                      namevar_11 ="PROP_11",
#                                      namevar_01 ="PROP_01",
#                                      namevar_ ="PROP_" ,
#                                      namevar_labels= "ord_alg" )