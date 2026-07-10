### Answers to the exercises of Module 1
### Programming in R
### Felix Clouth

######################### PART 1 ##############################

## question 1 ##
11 + 31
# 42

## question 2 ##
1+1
1 + 1
1 +     1 

# All give the same answer (2)
# It is recommended to use the second option: 1 + 1
# The rule of thumb is pretty much: would I put a space here in normal text? Then do so.

## question 3 ##

## question 4 ##
4 * 4 * 4
# 64
4 * (4 + 2)
# 24
4 * 4 + 2
# 18

## question 5 ##
1 + 1
2 * 6
1 + 1; 2 * 6
# The ; symbol works the same as a line break
# However, code is much more readable if every new command is on a new line

## question 6 ##
25 / (6 - 1
# R misses the closing parenthesis. If you execute this line, the console will keep waiting for the rest by showing a + instead of a >. You can solve this by either typing the closing parenthesis, or by pressing ESC.

## question 7 ##
# 7 * 3

## question 8 ##
# I looked up packages for Structural Equation Modelling and chose lavaan
install.packages("lavaan")
library("lavaan")

# note: for the library() command, I don't necessarily need the quotation marks:
library(lavaan) 


######################### PART 2 ##############################

## question 9 ##
log(42)
# 3.73767
log(exp(1))
# 1
log(0)
# -Inf
log(-1)
# NA
"harry" + 5
# Error in "harry" + 5 : non-numeric argument to binary operator
# This happens because you are trying to add up a character string and a number

## question 10 ##
a <- b <- ab <- ba <- 1
# this means 
a <- 1
b <- 1
ab <- 1
ba <- 1
c <- 1
# 5 objects were assigned value 1

## question 11 ##
# either quit R by hand, and save the workspace when the pop-up menu asks you
# or do
quit(save = "yes")
# START R AGAIN
ls()
rm(list = ls())

## question 12 ##
# a.
fluffy <- 37
fluffy + 5
# 42
fluffy + 5 == 42
# TRUE
# this is different from 2d, because there is no intermediate rounding here

# b. 
typeof(fluffy)
# "double"

## question 13 ##
# a. 
fluffy <- "An unfriendly animal?"
fluffy
# any different capitalization gives an error, because R is case sensitive

# b.
# fluffy is now of type "character". You can check this with:
typeof(fluffy)
# "character"
fluffy + 5
# Error in fluffy + 5 : non-numeric argument to binary operator

## question 14 ##
gryffindor <- c("Harry", "Ron", "Hermione", "Neville", "Ginny", "Oliver")
# a.
typeof(gryffindor)
# "character"

# b. 
gryffindor <- c("Harry", "Ron", "Hermione", 1, 2, 3)
typeof(gryffindor)
# "character"
# note that R forced all elements to be of the same type
# you can see this by calling "gryffindor" again, to see what's in it
# R now considers the numbers 1, 2, and 3 as characters
gryffindor
#"Harry"    "Ron"      "Hermione" "1"        "2"        "3" 

## question 15 ##
# a
rep(3,12) #repeat the value 3, 12 times

# b
rep(seq(2, 20, by=2), 2) #repeat the pattern 2 4 ... 20, twice

# c
rep(c(1, 4), c(3, 2)) # repeat 1, 3 times and 4, twice

# d
rep(seq(2, 20, 2), each = 2)
rep(seq(2, 20, 2), rep(2, 10))


######################### PART 3 ##############################

## question 16 ##
# first run the code from the question:
llama_agreeableness <- c(50, 20, 15, 80, 35, 52)

# a.
typeof(llama_agreeableness)
# "double"

# b.
sum(llama_agreeableness)
# 252

# c.
length(llama_agreeableness)
# 6

# d. 
sum(llama_agreeableness) / length(llama_agreeableness)
# 42

# e.
mean(llama_agreeableness)
# 42

# f. 
sd(llama_agreeableness)
# 23.9583

# g.
(llama_agreeableness - mean(llama_agreeableness)) / sd(llama_agreeableness)
# or you can use the function "scale"
scale(llama_agreeableness)

## question 17 ##
# a.
llama_age <- c(14, 9, 10, 25, 11, 15)

# b.
llama_age <- c(llama_age, NA)
# this adds a missing value ("Not Available") to the vector

# c. 
llama_age <- c(llama_age, llama_age)
# this creates a new vector called "llama_age" that consists of twice the original vector "llama_age"

# d.
llama_age <- c("Arthur" = 14, "Zaphod" = 9, "Trillian" = 10, "Ford" = 25, "Marvin" = 11, "Rooster" = 15)
# check what this does by calling "llama_age" again
llama_age
# this will give a vector with names

# e.
names(llama_age)
# this will tell you all the names of the elements in the vector llama_age
  
## question 18 ##
# look up the help file of mean:
?mean

# you can use the argument "trim" to specify you want to remove 20% of the most extreme values
mean(llama_age, trim = .2)
# 12.5

## question 19 ##
# a & b.
# to test whether a correlation is significant,
# you need the function cor.test(). This tip is given
# in the help files of cor(), under "See Also".
cor.test(c(1, 2, 3, 4), c(1, 4, 5, 15))
# p = .08635; this is not significant at alpha = .05

# c.
?cor
# this will lead you to:
?cor.test
# or use
apropos("cor")

## question 20 ##
# %% is the modulo operator (http://en.wikipedia.org/wiki/Modulo_operation)
# ?%% does not work
?'%%' # works
# %% computes the remainder after division
31 %% 7
# %/% computes the integer part of a fraction
31 %/% 7
7 * 4 + 3

##### BONUS #####

# question 21
# a. 
# if you change the working directory, you change the location where R will 
# either look for files, or where it will write files to

# b.
# you can also change the working directory with:
setwd("C:/Users/fjclouth/Desktop/Teaching/R")
# to check where your working directory is at the moment, you can do
getwd()
# which stands for "get working directory"

# c. 
# you can simply copy-paste the code into a program such as Notepad
# and save the file as a .txt file (I named it exercise.txt)
# you can then run it again with the following code
setwd("C:/Users/fjclouth/Desktop/Teaching/R")
source("exercise.txt")
# 200
# if you want to write the output to another file, you can do that directly:
# note that by running the file with source(), a and b are now in my workspace
write(a*b, file = "output.txt")

# I can also use the function "sink()" (see ?sink)
setwd("C:/Users/fjclouth/Desktop/Teaching/R")
sink(file = "output.txt")
source("exercise.txt")
sink(file = NULL)


######################### PART 4 ##############################

## question 22 ##
# a. 
a <- c(1, 2) 
a[1] + 10
# 11
# here we added 10 to the first element of a, which has the value 1

# b. 
a <- c(1, "hello") 
a[1] + 10
# this gives an error, because a is now of type character
typeof(a)

## question 23 ##
x <- c(1, 3, 5, 7, NA)
# I can only select the first 4 elements
x[c(1:4)]
# I can remove the last element
x[-5]
# I can also specifically say I want to remove the missing value
x[!is.na(x)]
# note that I used the function is.na() rather than x == NA (this doesn't work)
# also note that I used ! as a negation sign

## question 24 ##
# a.
llama_age[3]

# b. 
llama_age[c(1, 2)]
# or
llama_age[1:2]

# c.
llama_age[c(1, 5)]

# d.
llama_age[-c(2, 3, 4)]
# or
llama_age[-(2:4)]

# e.
llama_age[c("Zaphod", "Ford")]

## question 25 ##
llama_age["Rooster"] <- 16




