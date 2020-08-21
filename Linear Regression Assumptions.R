#===========================================================================================================================#
#
#                                      Testing Linear Regression Assumptions on Marketing Data
#                                               By - Arshan and Yash
#
#===========================================================================================================================#


#Importing required library.
library(tidyverse)
library(broom)
library(ggfortify)

# Load the data
data("marketing", package = "datarium")
# Inspect the data
sample_n(marketing, 3)

#Build a regression model
model <- lm(sales ~ youtube , data = marketing)
summary(model)

model.diag.metrics <- augment(model)
head(model.diag.metrics)

#Creating a diagnostic plot

autoplot(model)

##Linearity of the data
plot(model, 1)

#In our example, there is no pattern in the residual plot. 
#This suggests that we can assume linear relationship between the predictors and the outcome variables.


## Homogeneity of variance
plot(model, 3)

#This plot shows if residuals are spread equally along the ranges of predictors. 
#It's good if you see a horizontal line with equally spread points. In our example, this is not the case.
#It can be seen that the variability (variances) of the residual points increases with the value 
#of the fitted outcome variable, suggesting non-constant variances in the residuals errors (or heteroscedasticity).
#A possible solution to reduce the heteroscedasticity problem is to use a log or square root transformation 
#of the outcome variable (y).


##Normality of residuals
plot(model, 2)

#The QQ plot of residuals can be used to visually check the normality assumption. 
#The normal probability plot of residuals should approximately follow a straight line.
#In our example, all the points fall approximately along this reference line, so we can assume normality.


##Observations of the error term are uncorrelated with each other.
lmtest::dwtest(model)

#as the DW = 1.9347, there is no autocorrelation as the value is greater than 1.5 and less than 2.5.


