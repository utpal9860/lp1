mydata<-read.csv("/home/tarun/LP1/DA/diabetes.csv")
View(mydata)
dim(mydata)
names(mydata)
str(mydata)
train<-mydata[1:500,]
View(train)
test<-mydata[501:768,]
library(caTools)
install.packages("e1071")
library(e1071)
my_model<-naiveBayes(as.factor(train$Outcome)~.,train)
names(my_model)
pred1<-predict(my_model,test)
pred1
val<-cbind(test,pred1)
str(val)
View(val)
install.packages("ggplot2")
library(gmodels)
tab_data<-table(pred1,test[,9])
tab_data
library(caret)
confusionMatrix(tab_data)
