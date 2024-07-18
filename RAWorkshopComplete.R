# 0. Load packages ==================================
if(!require("tidyverse")) install.packages("tidyverse") #Most of the functions to tidy up and also to plot
if(!require("ggpubr")) install.packages("ggpubr") #package for plots
if(!require("lme4")) install.packages("lme4") #this is for linear and mixed models
if(!require("effectsize"))install.packages("effectsize") #calculating effect size for linear models

# 1. Import the data on R ==================================
#In this step we will import the dataset into R

dragons<-read.csv("dragons.csv")
#We need to inspect the data to (1)Understand its structure and (2) Make sure the data is imported in the format we want
View(dragons)
str(dragons)
## what do you notice in the output of str?

## What are the possible values of each column?
summary(dragons)


# 2. Tidy the data ==================================
#Make sure that the data is in the right format for R to interact with it
## factor variables
dragons$TimeTest<-as.factor(dragons$TimeTest)


#What other variables would you convert?
dragons$Sex <- as.factor(dragons$Sex)
dragons$MountainRange<-as.factor(dragons$MountainRange)


# 3. Transform the data ==================================
#R-friendly format: one observation per row
#\**Warning: Different statistical methods and graphs require data in different formats: We may need to transform the data more than once!**



# 4. Visualize the data ==================================
#How does the data look like?

#Lets get some descriptive statistics
mean(dragons$TestScore)
dragons%>%group_by(TimeTest)%>%summarise(MeanByTime = mean(TestScore) )
dragons%>%group_by(TimeTest, MountainRange)%>%summarise(MeanByTime = mean(TestScore))
#add sd to the previous function
dragons%>%group_by(TimeTest, MountainRange)%>%summarise(MeanByTime = mean(TestScore),SDByTime = sd(TestScore))
#is there any other variable you would like to see?
#Let's draw a couple of graphs

#histogram of test scores
hist(dragons$TestScore)

#Violin plot
ggplot(dragons, aes(x=TimeTest, y=TestScore, fill=TimeTest)) +
  geom_violin(trim=FALSE)+ 
  geom_dotplot(binaxis='y', stackdir='center', position=position_dodge(2))+
  stat_summary(fun=mean, geom="point", shape=15, size=4, position=position_dodge(1))

#Boxplot with paired data
ggpaired(dragons,
         id = "Name",
         x = "TimeTest",y ="TestScore",
         fill = "TimeTest",
        # facet.by = c("MountainRange"),
         point.size = .5,
         line.color = "grey"
)

#what about BodyWeight?

#correlation plot between BodyWeight and TestScore
ggplot(dragons, aes(x = BodyWeight, y = TestScore)) +
  geom_point()+
  geom_smooth(method = "lm")


# 5. Model the data ==================================
#Statistical inferences and statistical modeling of the data

#We need to contrast-code factor IVs (center around 0)
dragons$TimeTest_cc<-ifelse(dragons$TimeTest == "1_pre.training",-.5,.5)
dragons$MountainRange_cc<-ifelse(dragons$MountainRange=="Maritime",-.5,5)

#Statistical analysis for H1.1: Dragons will have higher Test scores after training than before
model_test<-lmer(TestScore~TimeTest_cc+(1|Name), data = dragons)
summary(model_test)

## effect size
effectsize::standardize_parameters(model=model_test)

#Statistical analysis for H1.2:  Where a dragon is from should have no effect on their improvement
model_pop_test<-lmer(TestScore~TimeTest_cc*MountainRange_cc +(1|Name), data = dragons)
summary(model_pop_test)

## effect size
effectsize::standardize_parameters(model=model_pop_test)


#Statistical analysis for H2.1:  Dragons will weight more after training than before
model_pop_weight<-lmer(BodyWeight~TimeTest_cc*MountainRange_cc +(1|Name), data = dragons)
summary(model_pop_weight)

#Statistical analysis for H2.2: The smarter a dragon is, the heavier it will be
model_weight_test<-lmer(BodyWeight~TestScore+(1|Name), data = dragons)
summary(model_weight_test)
