## ApplyComponentStrategy


 - ####	Context


When using existing healthcare databases to conduct a study, there is limited
or no control over the primary data collection. Study variables classifying presence of a disease are defined by retrieving and processing existing information. The choice of algorithms to define study variables may allow multiple options, as variation may occur across multiple dimensions (eg one may retrieve medical concepts that imply the study variable has been observed, or concepts that may be associated with the study variable; one may retrieve diagnoses recorded in primary care, or during a visit to a emergency room; one may use concepts that do not belong to data domains other than diagnosis, such as medicines or procedures). The component algorithm strategy builds on the design of a set of standardized set of binary algorithms for the study variable of interest, called components. Components may then be composed to create more complex algorithms. The impact of using different algorithms on the resulting estimates of disease occurrence is subsequently measured and compared graphically and/or analytically (Gini et al, Vaccine 2019; Roberto et al, Plos One 2016)


 - #### Purpose

There are two functions for this purpose:
 1.	ApplyComponentStrategy takes as input a dataset where component algorithms have been assigned, and the instructions to build composite algorithms based on them. It produces:


   -	a dataset where the composites have been calculated
   -	a dataset where the overlap of selected pairs of algorithms is computed
The input and output datasets may be either at individual level, or datasets of counts.


 2.	CreateFigureComponentStrategy takes as input the final dataset of the previous function, and it produces a graph that allows exploring the impact of the overlap
