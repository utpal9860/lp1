mydata <- read.csv(file= "D:\\Aparna\\Data Analytics\\LP1\\diabetes.csv",header= TRUE,sep=",")
View(mydata)
#to split dataset into train and test sets install  caTools package
install.packages("caTools")
library(caTools)

# to split use sample.split
temp_field <-sample.split(mydata,SplitRatio = 0.7)

# 70 % will be in training

train<- subset(mydata, temp_field==TRUE)

# 30 % will be in testing
test <- subset(mydata,temp_field==FALSE)
# to dispaly few samples
View(train)
str(train)
str(test)
View(test)

install.packages("e1071")
library(e1071)

#caret package can also be used for naive bays
#na.action is used if data contains any missing value

#s3 method by default



# make a note that, the class cannot be numeric,it needs to be categorical for naive bayes as specified in the function, hence as.factor internally maps the 1 and 0 to categorical value
#this will generate the model for naive bayes when outout class tobe predicted is outcome and the data is mydata
#s3 method of formula
naiveBayes(as.factor(train$Outcome)~.,train)
my_model <- naiveBayes(as.factor(train$Outcome)~.,train)
names(my_model)
head(my_model)

my_model$tables$Pregnancies

# for testing last column is required so put [,9]
pred1 <- predict(my_model,test[,9])

#predicting , try putting type="class" or type= "raw" after the test data 
pred1 <- predict(my_model,test[,9],type = "class")

pred1
pred1 <- predict(my_model,test[,9])
pred1

# generating confusing matrix
table(pred1,test$Outcome,dnn = c("predicted","Actual"))

# to save the prediction
output <- cbind(test,pred1)
output
View(output)
str(mydata)
str(output)
