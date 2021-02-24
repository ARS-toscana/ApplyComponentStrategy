# ApplyComponentStrategy


 - ##	Context


When using existing healthcare databases to conduct a study, there is limited
or no control over the primary data collection. Study variables classifying presence of a disease are defined by retrieving and processing existing information. The choice of algorithms to define study variables may allow multiple options, as variation may occur across multiple dimensions (eg one may retrieve medical concepts that imply the study variable has been observed, or concepts that may be associated with the study variable; one may retrieve diagnoses recorded in primary care, or during a visit to a emergency room; one may use concepts that do not belong to data domains other than diagnosis, such as medicines or procedures). The component algorithm strategy builds on the design of a set of standardized set of binary algorithms for the study variable of interest, called components. Components may then be composed to create more complex algorithms. The impact of using different algorithms on the resulting estimates of disease occurrence is subsequently measured and compared graphically and/or analytically (Gini et al, Vaccine 2019; Roberto et al, Plos One 2016)


 - ## Purpose

There are two functions for this purpose:

 1.	ApplyComponentStrategy takes as input a dataset where component algorithms have been assigned, and the instructions to build composite algorithms based on them. It produces:


    -	a dataset where the composites have been calculated
    -	a dataset where the overlap of selected pairs of algorithms is computed


The input and output datasets may be either at individual level, or datasets of counts.


 2.	CreateFigureComponentStrategy takes as input the final dataset of the previous function, and it produces a graph that allows exploring the impact of the overlap


-	## Structure of input data

 #### ApplyComponentStrategy
The input dataset is assumed to contain information for all the members of a population. The structure is as follows:

  - If the input is individual level data, each row is referred to a unit of observation; variables are
    - A set of binary variables, each associated to a component algorithm, indicating whether the person is identified by that algorithm
    - As an option: covariates 

  - If the input is count
    - A set of binary variables, each associated to a component algorithm, indicating all the combinations of presence of the algorithms (eg only the first; both the first and the second; etc); 
    - As an option: covariates
    - The number of persons having the corresponding combination of algorithms and of strata

  #### CreateFigureComponentStrategy
The input dataset is the final output dataset of the other function. The output dataset can change if strata is present in the parameters.  


- ## Main parameters

#### ApplyComponentStrategy
  - dataset (str): name of the dataset to be processed
  - individual (boolean, default=F): whether the dataset is at individual level (T) or a dataset of counts (F, the default)
  - intermediate_output (boolean, only default=F): whether an intermediate individual-level dataset is saved for later analysis
  - intermediate_output_name (str, only if intermediate_output=T, default=intermediate_output_dataset): if intermediate_output=T this is the name assigned to the intermediate dataset
  - components (list of str): list of the names of the binary variables associated to the components
  - composites (list of pairs of integers): each pair is associated to a composite algorithm; it contains the numbering in the two algorithms that form the component; the numbering refers to the order in the list –components-, or to the order of this list itself, but in the latter case the numbering starts from the number of components; e.g is there are 4 components, the numbering of this list starts with 5; no composite can be composed by algorithms associated with a numbering higher than the composite itself: i.e. the composite 8 can only be associated to a pair of integers smaller than 8
  - labels_of_components (list of str, optional): this list must have the same length as –components-; each string is the label of the corresponding component
  - expected_number (str, optional): variable containing the number of persons expected to be observed with the study variable of interest (in the corresponding stratum, if any)
  - count_var (str, only if individual=F): name of the variable containing the counts
  - strata (list of str, optional): list of the names of the variables containing covariates or strata
  - nameN (str, default: ‘N’): prefix of the variables in the output dataset counting occurrences of algorithms 
  - namePROP (str, default: ‘PROP’): prefix of the variables in the output dataset counting proportion of individuals detected by the algorithm 
  - K (int, default=100): scale of the proportions
  - namevar_10 (str): proportion of individuals in the algorithm A but not in B, scaled by K.
  - namevar_11 (str): proportion of individuals both in the algorithm A and B, scaled by K.
  - namevar_01 (str): proportion of individuals in the algorithm B but not in A, scaled by K.
  - namevar_ (str): proportion of individuals in the population, scaled by K.
  - namevar_TRUE: (str, optional, default=NULL) Variable containing the proportion of persons (scaled by K) expected to be observed with the study variable of interest
  - namevar_strata (vector of str, optional, default=NULL): vector of the names of the variables containing covariates or strata.
  - namevar_labels (str): variable containing labels.
  - figure_name (str, default="figure"): namefile assigned to the figure. Path is included in the name,if any. The figure is saved in ".pdf".



#### CreateFigureComponentStrategy 
 
  - dataset: name of dataset 
  - numcomponents: number of components
  - namevar_10 (str): proportion of individuals in the algorithm A but not in B, scaled by K.
  - namevar_11 (str): proportion of individuals both in the algorithm A and B, scaled by K.
  - namevar_01 (str): proportion of individuals in the algorithm B but not in A, scaled by K.
  - namevar_ (str): proportion of individuals in the population, scaled by K.
  - namevar_TRUE (str, optional, default=NULL): variable containing the proportion of persons (scaled by K) expected to be observed with the study variable of interest
  - namevar_strata (vector of str, optional, default=NULL): vector of the names of the variables containing covariates or strata.
  - namevar_labels (str): variable containing labels.
  - K (int, default=100): scale of the proportions.
  - figure_name (str, default="figure"): namefile assigned to the figure. Path is included in the name, if any. The figure is saved in ".pdf".


- ## Action

  - Check that the assumptions of the parameters are correct (eg that all required parameters are included, that their assignment is coherent, etc), otherwise throw a error
  - Create as many variables as the number of composites, and each such variable is 1 if either of the algorithms associated to the pair is 1
  - If -intermediate_output-=T save the resulting dataset as -intermediate_output_name-
  - Aggregate the dataset by the list of algorithms (both components and composites) and possibly by strata, by counting the rows (if individual=T) or summing –count_var- (otherwise)
  - For each algorithm generate one row (per strata, if any)
    - For each component algorithm a variable nameN_ containing the number of individuals in the algorithms
    - For each composite algorithm
      - Two variables _algA and _algB containing the pair of integer associated to the component (‘A’ being the first and ‘B’ the second)
      - A variable nameN_10 containing the number of individuals in the algorithm A but not in B
      - A variable nameN_11 containing the number of individuals both in algorithm A and B
      - A variable nameN_01 containing the number of individuals in the algorithm B but not in A
    - In both cases, a variable nameN_pop containing the number of the individuals in the population (in the stratum, if any)
  - Compute proportions of all the nameN over nameN_pop, scaled by K
  - If figure=T, also the function CreateFigureComponentStrategy will be activate. It will generate a bar graph figure as in the example
  - Return the dataset

 
- ## Structure of output


- ## Example


