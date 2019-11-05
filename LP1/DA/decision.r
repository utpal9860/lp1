library(e1071)
library(rpart)
library(caTools)

mydata1 <-read.csv(file = "/home/tarun/LP1/DA/201805-capitalbikeshare-tripdata.csv", header = TRUE, sep=",")
mydata1

subset_mydata <- mydata1[,c(1,4,6,9)]
subset_mydata

temp_field <- sample.split(subset_mydata,SplitRatio=0.9)
train <- subset(subset_mydata, temp_field==TRUE)
test <- subset(subset_mydata, temp_field==FALSE)
summary(train)
summary(test)

head(train)
head(test)

fit <- rpart(train$Member.type~.,data=train,method="class")
plot(fit)
text(fit)

#test data excluding the last column
pred <- predict(fit,newdata=test[,-4],type=("class"))
mean(pred==test$Member.type)

# display the output of test data
output <- cbind(test,pred)
output

printcp(fit)
opt <- which.min(fit$cptable[,"xerror"])

cp <- fit$cptable[opt,"CP"]
cp

# prune tree
pruned_model <- prune(fit,cp)

#plot  tree
plot(fit)
text(fit)

#find proportion of correct predictions using test set
rpart_pruned_predict <- predict(pruned_model,test[,-4],type="class")

#higher the value of mean - improvement
mean(rpart_pruned_predict==test$Member.type)

output1 <- cbind(test,pred)
output1

