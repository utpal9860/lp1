library(datasets)
data(iris)
names(iris)
dim(iris)
View(iris)
#internal structure
str(iris)
summary(iris)
class(iris)
typeof(iris)
#min value
min(iris$Sepal.Length)

#max value
max(iris$Sepal.Length)
# range
range(iris$Sepal.Length)
#mean
mean(iris$Sepal.Length)
#variance
var(iris$Sepal.Length)
#standard deviation
sd(iris$Sepal.Length)
quantile(iris$Sepal.Length)
quantile(iris$Sepal.Length,c(0.3,0.6))

# Boxplotis a chart that graphically represents the five most important descriptive values for a data set. These values include the minimum value, the first quartile, the median, the third quartile, and the maximum value. When graphing this five-number summary, only the horizontal axis displays values. Within the quadrant, a vertical line is placed above each of the summary numbers. A box is drawn around the middle three lines (first quartile, median, and third quartile) and two lines are drawn from the box's edges to the two endpoints (minimum and maximum).
boxplot(iris$Sepal.Length)
summary(iris$Sepal.Length)


# combined boxplot for 4 features
# plot all features except 5 th 
myboxplt<-boxplot(iris[,-5])

myboxplt

#display outliers

myboxplt$out


# histogram
#a histogram and a bar chart is that a histogram displays frequencies for a group of data, rather than an individual data point; therefore, no spaces are present between the bars. Typically, a histogram groups data into small chunks (four to eight values per bar on the horizontal axis),
hist(iris$Sepal.Length)

h<-hist( iris$Sepal.Length,main="sepal length frequencies- histogram",xlab="Sepal length",xlim=c(3.5,8.5),col="blue",breaks = 3)

# to diaplay the details of histogram
h

#using breaks and las

h <- hist( iris$Sepal.Length,main="sepal length frequencies- histogram",xlab="Sepal length",xlim=c(3.5,8.5),col="blue", labels = TRUE, breaks = 3, border = "green",las=0)
