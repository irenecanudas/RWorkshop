# 0. Load packages ==================================
if(!require("tidyverse")) install.packages("tidyverse") #Most of the functions to tidy up and also to plot
if(!require("ggpubr")) install.packages("ggpubr") #package for plots
if(!require("lme4")) install.packages("lme4") #this is for linear and mixed models


# 1. Import the data on R ==================================
#In this step we will import the dataset into R


#We need to inspect the data to (1)Understand its structure and (2) Make sure the data is imported in the format we want

## what do you notice in the output of str?

## What are the possible values of each column?


# 2. Tidy the data ==================================
#Make sure that the data is in the right format for R to interact with it
## factor variables

#What other variables would you convert?


# 3. Transform the data ==================================
#R-friendly format: one observation per row
#\**Warning: Different statistical methods and graphs require data in different formats: We may need to transform the data more than once!**

# 4. Visualize the data ==================================
#How does the data look like?

#Lets get some descriptive statistics

#is there any other variable you would like to see?
#Let's draw a couple of graphs

#histogram of test scores


#Violin plot


#Boxplot with paired data


#what about BodyWeight?


# 5. Model the data ==================================
#Statistical inferences and statistical modeling of the data

#We need to contrast-code factor IVs (center around 0)

#Statistical analysis for H1.1: Dragons will have higher Test scores after training than before

## effect size


#Statistical analysis for H1.2:  Where a dragon is from should have no effect on their improvement


## effect size


#Statistical analysis for H2.1:  Dragons will weight more after training than before

#Statistical analysis for H2.2: The smarter a dragon is, the heavier it will be

