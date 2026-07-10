### Answers to the exercises of Module 3
### Programming in R
### Felix Clouth

# empty your workspace
rm(list = ls())

######################### PART 1 ##############################

## question 1 ##
# set the working directory to the location of the data
setwd("C:/Felix/Desktop")

# load the data in R, don't forget the header = TRUE command
height_data <- read.table("height.txt", header = TRUE)

# inspect your data (see Week 2)
head(height_data)
str(height_data)
summary(height_data)
View(height_data)


## question 2 ##
# I only want to change the column names of the question variables
# that is; column 2:27
colnames(height_data)[2:27] <- paste("Q", 1:26, sep = "")
# If you do not specify the argument sep="", then the default separator (" ") will be used and you will get "Q 1" instead of "Q1"

# alternatively, I could use the function paste0()
colnames(height_data)[2:27] <- paste0("Q", 1:26)
# here the default is ""


## question 3 ##
height_data$gender[height_data$gender == 1] <- "m"
height_data$gender[height_data$gender == 2] <- "f"
height_data$gender[height_data$gender == 9] <- "?"


## question 4 ##
# first check which values the variable gender can take
table(height_data$gender)
# ?  4  f  M 
# 7  3 74 57 

# we see that for some reason, people got the value "4"
# this is not one of the categories that could be chosen, so this is probably wrongly coded
# we'll change this into a "?" as well
height_data$gender[height_data$gender == 4] <- "?"


## question 5 ##
# We can replace all 9s in the data, without having to do that per column separately
# Like this:
height_data[height_data == 9] <- NA
# However, we need to take into account that different variables have different ways of coding missings
# The code above would also change the ID number of participant 9 to a NA

# We need to select the right columns for each case
# this means that our code needs to be extended:
height_data[ , 2:27][height_data[ , 2:27] == 9] <- NA

# For weight & grade, we need to change the values 99 into NA
height_data[ , c(29, 31)][height_data[ , c(29, 31)] == 99] <- NA

# We can manually count which columns these are, but this is very error prone
# Especially if our data becomes larger
# We can also make this more flexible, by doing this:
colsNA99 <- which(colnames(height_data) == "weight" | colnames(height_data) == "grade")
height_data[ , colsNA99][height_data[ , colsNA99] == 99] <- NA

# Finally, for height:
height_data[ , "height"][height_data[ , "height"] == 999] <- NA
# or
height_data$height[height_data$height == 999]<-NA
# or 
height_data[,28][height_data[,28] == 999]<-NA


## question 6 ##
# First we need to calculate the means
mean.grade <- mean(height_data$grade, na.rm = TRUE)
mean.height <- mean(height_data$height, na.rm = TRUE)

# these means have a ton of decimals, and it would be nice to stick to the number
# of decimals that the original variables have
# for this we can use the function "round"
mean.grade <- round(mean(height_data$grade, na.rm = TRUE), digits = 1)
mean.height <- round(mean(height_data$height, na.rm = TRUE), digits = 0)

# Now replace all missing values in these variables with the means
# note that x == NA does not work like x == 9 does!
height_data$grade[is.na(height_data$grade)] <- mean.grade
height_data$height[is.na(height_data$height)] <- mean.height

# Alternatively, You do not need to save the means in a separate object
height_data$grade[is.na(height_data$grade)] <- round(mean(height_data$grade, na.rm = TRUE), digits = 1)
height_data$height[is.na(height_data$height)] <- round(mean(height_data$height, na.rm = TRUE), digits = 0)


##### BONUS ######
## question 7 ##
# select all answers to the questionnaire
scores <- height_data[ , 2:27]

# some items were negatively worded and need to be reverse coded

# first identify which items were negatively worded:
negative <- c(2, 5, 6, 8, 11, 15, 16, 18, 19, 21, 22, 24, 26)

# a quick way to reverse code, is the following:
# another strategy is described below
scores[ , negative] <- 1 - scores[ , negative]

# calculate the sum score for each participant
# use the new data.frame "scores" I just created
tot.score <- rowSums(scores, na.rm = TRUE)

# test the correlation
cor.test(height_data$height, tot.score)
# note that we take the "height" vector from the original data frame
# and relate it to our new variable
# this is fine: R doesn't care where the vectors came from

# Pearson's product-moment correlation
# 
# data:  data$height and tot.score
# t = 4.6792, df = 139, p-value = 6.759e-06
# alternative hypothesis: true correlation is not equal to 0
# 95 percent confidence interval:
#  0.2167992 0.5034982
# sample estimates:
#       cor 
# 0.3688904 

# the correlation is .37, and is significant (p < .001)

# extra challenge: do it in a single line
cor.test(height_data$height, rowSums(cbind(height_data[ , c(2, 4, 5, 8, 10, 11, 13, 14, 15, 18, 21, 24, 26)], 1 - height_data[ , c(3, 6, 7, 9, 12, 16, 17, 19, 20, 22, 23, 25, 27)]), na.rm = TRUE))
# I highly recommend not to do this because your code becomes unreadable rather quickly


# note that we basically treated the missing values as zeros: 
# we did not count them towards the sum score
# this may introduce bias, so instead, we could also replace the NA's with .5
# this makes no conceptual sense, but helps with calculating the sum score

scores <- height_data[ , 2:27]
scores[is.na(scores)] <- .5

# some items were negatively worded and need to be reverse coded
negative <- c(2, 5, 6, 8, 11, 15, 16, 18, 19, 21, 22, 24, 26)
scores[ , negative] <- 1 - scores[ , negative]

# calculate the sum score
tot.score <- rowSums(scores, na.rm = TRUE)

# test the correlation
cor.test(height_data$height, tot.score)

#-----------

# another way to reverse code, which is slightly less efficient, is the following:

# select all answers to the questionnaire
scores <- height_data[ , 2:27]

# identify which items were negatively worded:
negative <- c(2, 5, 6, 8, 11, 15, 16, 18, 19, 21, 22, 24, 26)

# reverse code in steps:
scores[ , negative][scores[ , negative] == 0] <- 99
scores[ , negative][scores[ , negative] == 1] <- 0
scores[ , negative][scores[ , negative] == 99] <- 1


# note that I have to add an extra step in which I changed all zeroes into a placeholder number
# why do we need to do this?
# consider the small example below:

# I create a super simple vector of a single 1 and 0
x <- c(1,0)
x

# again I want to recode the 1 into 0, and vice versa
# you might intuitively want to do this:
x[x == 0] <- 1
x[x == 1] <- 0

# but see what happened to x now:
x
# [1] 0 0

# both values are now 0
# I avoid this with an extra step:
x <- c(1,0)

x[x == 0] <- 99 # or any other number, as long as it's not 1
x[x == 1] <- 0
x[x == 99] <- 1

x



######################### PART 2 ##############################

## question 8 ##
# Set your working directory to the folder where you saved the data
setwd("C:/Felix/Desktop")
load("big5.RData")


## question 9 ##
# a
nrow(big5)
# 500 observations
ncol(big5)
# 241 variables
# alternatively, I could have done:
dim(big5)
# 500 observations and 241 variables
# you can also see this information displayed in the Environment pane

# b
View(big5)
# by scrolling through the columns, you can see that all but the last one look similar
# I will therefore only check the values for the first column
# I can use different commands to do that
unique(big5[ , 1])
table(big5[ , 1])
summary(big5[ , 1])

# a nice way to see the range for all columns, is this:
range(big5[, 1:240])
# not that range(big5[, 1:241]) will return an error because the last column (variable) is a factor


## question 10 ##
# a
names(big5)
# or
colnames(big5)

# b
# I want to have the column means of all columns except the last one
# I know from the previous exercise that there are 241 columns
# so I can do this:
colMeans(big5[ , -241])
# a bit more flexible is to say this:
colMeans(big5[ , -ncol(big5)])
# I can also specifically say I don't want the column with the name "gender"
# programming it this way, makes my code more flexible
# this code would still work even if I add columns to my data, or shift their order
colMeans(big5[ , -which(colnames(big5) == "gender")])


## question 11 ##
# By scrolling through the columns of the data
# you can see that the last Agreeableness item is A239
# We want to select all columns up until that one:
which(colnames(big5) == "A239")
# column 48 is the last agreeableness column, so:
rowMeans(big5[ , 1:48])
# or, again, more flexible
rowMeans(big5[ , 1:which(colnames(big5) == "A239")])
# if "A4" was not the first item in the dataset, we would have to find its position as well:
rowMeans(big5[ , which(colnames(big5) == "A4"):which(colnames(big5) == "A239")])

# a
student.agr <- rowMeans(big5[ , 1:which(colnames(big5) == "A239")])

# b
# First, I'm gonna save all Agreeableness columns as a separate data frame
# this saves me a lot of typing later on
big5.agreeableness <- big5[ , 1:which(colnames(big5) == "A239")]
# Next, I can use apply to calculate the standard deviation for all rows (1) in this new data frame
student.sds <- apply(big5.agreeableness, 1, sd)


## question 12 ##
# a
tapply(student.agr, big5$gender, mean)
#        0        1 
# 3.016667 3.486564 
# to calculate the difference in means, I can of course type in the numbers:
3.486564 - 3.016667
# 0.469897

# but it's nicer to save the two means in an object, and use that to calculate the difference:
means.gender <- tapply(student.agr, big5$gender, mean)
means.gender[2] - means.gender[1]

# I can even then round it immediately:
round(means.gender[2] - means.gender[1], 2)
# 0.47

# b
tapply(student.agr, big5$gender, sd)
#         0         1 
# 0.4595837 0.2968752 

# c
tapply(student.sds, big5$gender, mean)
# 0         1 
# 1.0307119 0.9396303 

# the difference with 12b is the following:
# in 12b, we looked at each student's mean score on agreeableness
# we then calculated what the standard deviation was for these scores, per gender
# in other words: how much do men vary in their overall agreeableness, and how much
# do women vary in their agreeableness.
# In this case, men differed more from each other in terms of mean agreeableness
# than women.

# In 12c, we're looking at something else: 
# we first check for each student how much they varied in their answers to all
# agreeableness questions (students.sds)
# We then calculated the means of those sds for men and women.
# These numbers indicate whether men and women were consistent in answering the questions
# In this case, men varied more in their answers than women; women were more consistent
# in answering the questions


##### BONUS ######

## question 13 ##
# a
perc_5 <- function(scores){
  sum(scores == 5)/length(scores)
}

# b
# select only the columns of the openness questions
# in the data set, I saw that the first openness column is O3
which(colnames(big5) == "O3")
# that's the 193rd column
# The last openness column is O238
which(colnames(big5) == "O238")
# 240
open <- big5[ , 193:240]

# a different way to quickly select columns with the letter "O" in them
# is to use the function "grepl()", which looks for patterns in text
open <- big5[ , grepl("O", colnames(big5))]

# c
# we can then apply our new function to each row of our new data frame
perc_max_perstudent <- apply(open, 1, perc_5)

# d
# which student had the most fives?
which.max(perc_max_perstudent)
# student 7


## question 14 ##
# shuffling the mtcars dataset
set.seed(120225)
mtcars_shuffled <- mtcars[sample(nrow(mtcars)), ]

# a
# we can select all of the Mercedes (Merc) cars using the grepl function
mtcars_shuffled[grepl("Merc", rownames(mtcars_shuffled)),]

# b
# we load in the vectors we want to checks for
desired_axle_ratio <- c(3.07, 3.21, 3.15, 3.62, 3.85, 3.92, 4.08, 4.43)

# we can then subselect values that match any in this vector using the %in% 
# operator
mtcars_shuffled[mtcars_shuffled$drat %in% desired_axle_ratio,]

# OR using the match statement (with some extra work)
drat_matches <- match(mtcars_shuffled$drat, desired_axle_ratio)

mtcars_shuffled[!is.na(drat_matches),]


