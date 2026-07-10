### Answers to the exercises of Module 4
### Programming in R
### Felix Clouth

# empty your workspace
rm(list = ls())

######################### PART 1 ##############################

## question 1 ##

# a
# first save the data in an object so that it shows in your workspace.
sleep <- sleep
?sleep
# This dataset contains data that show the effect of two soporific drugs (increase in hours of sleep compared to control) on 10 patients.

# b
tapply(sleep$extra, sleep$group, mean)
tapply(sleep$extra, sleep$group, sd)

# c
t.test(extra ~ group, data = sleep)
# There is no significant difference between the effects of the two types of drugs on the extra hours of sleep.

# d
# Note: paired = TRUE, does not work for formula notation in recent versions of R. Therefore:
t.test(Pair(extra[group == 1], extra[group == 2]) ~ 1, data = sleep)
# when we take into account that the data are paired, we do find a significant difference in the effectiveness of the two drugs.


######################### PART 2 ##############################

## question 2 ##

# don't forget to set your working directory to the location where you 
# stored the data
anova_data <- read.csv("anova.csv", header = TRUE)

# ensure that the categorical variables are considered factors by R
anova_data$subject <- factor(anova_data$subject)
anova_data$sex <- factor(anova_data$sex)
anova_data$age <- factor(anova_data$age)

# inspect data
head(anova_data)
str(anova_data)

# a
boxplot(after ~ sex, data = anova_data, xlab = "Sex", ylab = "Score After")

# b
aov1 <- aov(after ~ sex, data = anova_data)
summary(aov1)

# c
boxplot(after ~ age, data = anova_data, xlab = "Age", ylab = "Score After")

aov2 <- aov(after ~ age, data = anova_data)
summary(aov2)

# d
boxplot(after ~ sex + age, data = anova_data, xlab = "Group", ylab = "Score After")

# e
aov3 <- aov(after ~ sex * age, data = anova_data)
summary(aov3)
# there is a significant interaction between sex & age in the effect on after


######################### PART 3 ##############################

## question 3 ##
# a
# load the dataset from Canvas
personality <- read.table("epi.bfi.txt", header = TRUE)

# calculate the correlation
cor(personality$epiE, personality$bfext)
# 0.54

# b
cor.test(personality$epiE, personality$bfext)
# The correlation is significant: t = 9.7981, df = 229, p-value < .001

# c
personality_cor_test <- cor.test(personality$epiE, personality$bfext)
print(personality_cor_test$conf.int[1:2])


######################### PART 4 ##############################

## question 4 ##
# a
# remember that I saved the epi.bfi data in the object personality
lm1 <- lm(bdi ~ traitanx, data = personality)
summary(lm1)
# Trait anxiety is a significant predictor for depression. The R2 is 0.4287

# b
lm2 <- lm(bdi ~ traitanx + stateanx, data = personality)
summary(lm2)
# both trait and state anxiety are significant predictors of depression

# c
lm3 <- lm(bdi ~ traitanx * stateanx, data = personality)
summary(lm3)
# the interaction between trait and state anxiety is a significant predictor of depression

# d
anova(lm1, lm2)
# adding state anxiety to the model significantly improved our prediction
anova(lm2, lm3)
# adding the interaction also significantly improved our model


## question 5 ##
glm1 <- glm(am ~ mpg , data = mtcars, family = binomial(link = "logit"))

summary(glm1)
# There is an significant association between miles per gallon and the transmission type. 



