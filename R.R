
## Use a pound key (#) to indicate a comment

## Calculator (make sure you know the rules)
7+3*9
32/4*4

## Why doesn't Dushoff like the second one?
print((32/4)*4) 

## Assigning values to variables

x <- 23
print(x)

## What will happen here?
x + 17
print(x)

## What happened here?
y <- x + 17
y 

## Question from card
print(x+17)

######################################################################

## Values in R
## We need to understand:
#### numeric, character and logical

## str tells us about the structure of a variable
num <- 3
str(num) 

## Quotes make something into a character value instead of an R name
char <- "Hello, class?"
str(char)

logic <- TRUE ## No quotes
str(logic)

## R's fundamental object is a _vector_
words <- c("Mary", "had", "a", "little", "lamb")
# c() for concatenate puts elements together into a vector
str(words)

v <- 1:5  ## 'm:n' creates a sequence from m to n
str(v)

## r vector_math
v <- 1:5
w <- c(0, 1, 1, 2, 4)
v+w
2*w

mean(c(2, 5, 11))

x <- 1:10
m_x <- mean(x)
print(m_x)

######################################################################

## Functions
## We've already seen a bunch of functions

## For example?

## Learn about functions using rstudio help -- I am not an expert

## Pay attention to what the arguments are
## In general, pass arguments using "="

