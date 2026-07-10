### Answers to the exercises of Module 2
### Programming in R
### Felix Clouth

######################### PART 1 ##############################

## question 1 ##
# a
mymatrix <- matrix(1:9, nrow = 3, ncol = 3, byrow = TRUE)
# note that you need the argument byrow = TRUE to specify that
# the values will be filled in from left to right,
# instead of vertically

# b
mymatrix[2, 3]


## question 2 ##
# a
llama.agreeableness <- c(50, 20, 15, 80, 35, 52)
llama.age <- c(14, 9, 10, 25, 11, 15)
llamas <- data.frame(llama.age, llama.agreeableness)

llamas$llama.agreeableness

# b
llamas$metal <- rep(1:2, times = 3)

# c
llamas$metal <- factor(llamas$metal) 
levels(llamas$metal) <- c("No", "Yes")
# the vector has turned into a factor
# this means that every value refers to a category
# the categories are also given informative names

# d
llama.names <- c("Arthur", "Zaphod", "Trillian", "Ford", "Marvin", "Rooster")
row.names(llamas) <- llama.names
# I now gave my dataframe rownames that correspond to the names of the llamas

# e
llamas[3, ]

# f
llamas[c(1, 3), ]

# g
llamas[c("Zaphod", "Rooster"), ]


## question 3 ##
# a
# I have three students. 
# Student 1 had a 7.5 and an 8 for her most recent courses.
# Student 2 a 9 and a 7, and student 3 a 6.5 and a 5
grades <- matrix(c(7.5, 9, 6.5, 8, 7, 5), nrow = 3, ncol = 2)

# It makes more sense to fill this out by row:
grades <- matrix(c(7.5, 8, 9, 7, 6.5, 5), nrow = 3, ncol = 2, byrow = TRUE)

# I also don't need to specify both the number of rows and columns
# R understands that if I have 6 observations, and 3 rows, I automatically want 2 columns
grades <- matrix(c(7.5, 8, 9, 7, 6.5, 5), nrow = 3, byrow = TRUE)

# b
students <- data.frame(name = c("Harry", "Ron", "Hermione", "Ginny"),
                       eye_color = c("green", "blue", "brown", "green"),
                       gender = c("male", "male", "female", "female"),
                       height = c(165, 175, 155, 170))

# note that R automatically turns the categorical variables into factors, e.g.:
students$eye_color

# c
info <- list(course = "Programming",
             students = students, 
             grades = grades)
# note that I'm assigning a name to the data frame and matrix again in the list
# if I don't, the objects in the list don't have names, only numbers: [[2]] and [[3]]


## question 4 ##
StarWars <- list(series = "starwars",
                 movie_order = c(4, 5, 6, 1, 2, 3, 7, 8, 9),
                 characters = data.frame(name = c("Luke", "C-3PO", "R2-D2", "Darth Vader", "Leia"),    
                                         height = c(172, 167, 96, 202, 150),
                                         evil = c(FALSE, FALSE, FALSE, TRUE, FALSE)))

# a
StarWars$series <- "Star Wars"

# b
# you can do that in several ways:
StarWars[[2]][3]
StarWars[["movie_order"]][3]
StarWars$movie_order[3]

# c
# you can do that in several ways:
StarWars$characters$species <- factor(c("Human", "Droid", "Droid", "Human", "Human"), 
                                      levels = c("Human", "Droid"))
StarWars[[3]]$species <- factor(c("Human", "Droid", "Droid", "Human", "Human"), 
                                levels = c("Human", "Droid"))


##### BONUS ######

## question 5 ##
# first, create a mini data frame for Chewbacca
Chew_DF <- data.frame(name = "Chewbacca",
                      height = 228,
                      evil = FALSE,
                      species = NA)

# then add Chewbacca's row to the data frame
StarWars$characters <- rbind(StarWars$characters, Chew_DF)


######################### PART 2 ##############################

## question 6 ##
# a
llamas[llamas$llama.age > 11, ]

# b
# select those with age smaller than or equal to 11
llamas[llamas$llama.age <= 11, ]
# select those for which it is not true that their age is larger than 11
llamas[!(llamas$llama.age > 11), ]

# c
llamas[llamas$llama.age > 11 & llamas$metal == "Yes", ]

# d
llamas[llamas$llama.age > 11 | llamas$metal == "Yes", ]


## question 7 ##
# a
cardata <- mtcars

# b
# all these functions are tools to quickly inspect your data
# you can try them on the car data
# you can see the differences between the functions even more clearly
# when you use them on the StarWars data frame, because
# this data frame contains different types

str(cardata)
?str()
# this function gives an overview of the structure of the data
# it shows the variable names, their types, and the first couple of values

summary(cardata)
?summary()
# this function shows "result summaries" for all variables
# the specific info it shows depends on the type of the variable
# for numerics, it shows the distribution (min, max, quartiles, mean, median)
# for logicals and factors, it shows you the categories and the number of observations for each level

head(cardata)
?head
# this function shows you the first 6 rows of the data
# or the first 6 elements of a vector

View(cardata)
?View
# this opens a window with the data in spreadsheet format

# c
?mtcars
# this opens the help page containing details of the dataset
sum(cardata$cyl >= 6)
# 21

# note that I didn't use "length()"!
# see what happens then:
length(cardata$cyl >= 6)
# 32
# this is equal to all rows in the data
nrow(cardata)
# 32

# the reason I can use sum(), is that R translates TRUE & FALSE to 1 and 0
# so if I sum a vector of TRUE & FALSE values, it basically gives back the
# number of TRUEs
cardata$cyl >= 6
as.numeric(cardata$cyl >= 6)
sum(cardata$cyl >= 6)

# d
mean(cardata$wt)
# 3.21725 
# this should be multiplied by 1000 lbs (see help file of mtcars)

# e
mean(cardata$hp[cardata$cyl < 6])
# 82.63636


## question 8 ##
# a
install.packages("dplyr")
library(dplyr)

# save starwars data in an object
starwars_data <- starwars

# b
dim(starwars_data)
# 87 rows and 14 columns, so 14 variables
ncol(starwars_data)
# 14
# you can also see how many variables there are in the RStudio panel "Environment"

# c
sum(starwars_data$height)
# this gives a missing value (NA), because this variable contains missing values
# to solve this, run:
sum(starwars_data$height, na.rm = TRUE)
# 14123 cm
# in meters, this would be:
sum(starwars_data$height, na.rm = TRUE)/100
# 141.23 meter

# d
starwars_data$name[which.max(starwars_data$height)]
# Yarael Poof; you should totally Google him (her?)
starwars_data$name[which.max(starwars_data$mass)]
# Jabba Desilijic Tiure (Jabba the Hutt) of course 


## question 9 ##
# because I will have to read in data several times
# I decided to save all data files in the same folder
# this way, I only have to set my working directory once for all sub questions
setwd("C:/Felix/Desktop")

# a
pokemon_txt <- read.table("pokemon.txt", header = TRUE)
head(pokemon_txt) # to check if it looks ok

# b
pokemon_csv <- read.csv("pokemon.csv", header = TRUE)
head(pokemon_csv)

pokemon_csv2 <- read.csv2("pokemon.csv", header = TRUE)
head(pokemon_csv2)

# the first one (read.csv()) looks really weird. There is only 1 column, 
# and a lot of semi-colons (;) everywhere. The second one looks normal: 
# separated columns. The difference between read.csv() and read.csv2() 
# has to do with the type of "column separator" that was used to create 
# the file. This can differ per computer, so when reading in a csv file, 
# always check if your data looks the way you want it to. If it doesn't, 
# try the other function to read it in and check again.

# c
load("pokemon.RData")
# this immediately transfers the data set "pokemon" to my workspace
# check:
head(pokemon)
# if I try to save this into an object immediately, as with read.table etc.
# this happens:
pokemon_RData <- load("pokemon.RData")
head(pokemon_RData)
# [1] "pokemon"
# Thus: if you load an RData file, don't save it in an object

# d
install.packages("rio") 
library(rio) 
pokemon_sav <- import("pokemon.sav")
head(pokemon_sav)

# e
pokemon_xlsx <- import("pokemon.xlsx")
head(pokemon_xlsx)
# yes
# I can immediately check that by calling two functions at once
# I import the data, and ask R to only give me the first 6 observations
# note I didn't save these data files anywhere now
head(import("pokemon.txt"))
head(import("pokemon.csv"))


## question 10 ##
pokemon_data <- pokemon_txt

# a
pokemon_water <- pokemon_data[pokemon_data$Type1 == "Water", ]
head(pokemon_water)

# b
# set your working directory to the place where you want to save the data
setwd("C:/Felix/Desktop")
write.csv(pokemon_water, file = "pokemon_water.csv", row.names = FALSE)
# note that I can also use write.csv2

# you can see the difference if you simply try to open the files
# one will probably look "normal" in Excel, the other looks weird
write.csv2(pokemon_water, file = "pokemon_water2.csv", row.names = FALSE)

# c
setwd("C:/Felix/Desktop")
save(pokemon_water, file = "pokemon_water.RData")

# or in one line:
save(pokemon_water, file = "C:/Felix/Desktop/pokemon_water.RData")


##### BONUS ######

## question 11 ##
# first check if the object starwars still contains the data set
head(starwars)
table(starwars[starwars$starships != "character(0)", "hair_color"])
# auburn, white         black         blond         brown          none 
#             1             4             2             8             5 

## question 12 ##
install.packages("readxl")
library(readxl)

setwd("C:/Felix/Desktop")
pokemon_xlsx2 <- read_excel("pokemon.xlsx")

install.packages("foreign")
library(foreign)

pokemon_sav2 <- read.spss("pokemon.sav", to.data.frame = TRUE)
# note that I have to specify that I want a data frame back
# if I don't do this, R will give me a list 

