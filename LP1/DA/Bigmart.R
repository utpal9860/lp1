library(dplyr)
install.packages("dplyr")
library(dplyr)
library(ggplot2)
library(caret)
install.packages("caretEnsemble")
library(caretEnsemble)
install.packages("VIM")
library(VIM)
install.packages("gridExtra")
library(gridExtra)
big_mart <- read.csv("/home/tarun/LP1/DA/Bigmart_Train.csv")
head(big_mart)
summary(big_mart)
#Cleaning Item_Fat_Content Variable
#Transforming "low fat" and "LF" to "Low Fat"
index <- which(big_mart$Item_Fat_Content == "LF" | 
                 big_mart$Item_Fat_Content == "low fat")

big_mart[index, "Item_Fat_Content"] <- "Low Fat"


#Transforming "reg" to "Regular
index2 <- which(big_mart$Item_Fat_Content == "reg")

big_mart[index2, "Item_Fat_Content"] <- "Regular"

#Dropping Unused Levels
big_mart$Item_Fat_Content <- factor(big_mart$Item_Fat_Content)
#Imputing Missing Values
#Using kNN imputation for missing values
big_mart_imputed <- kNN(big_mart)
big_mart_imputed <- big_mart_imputed %>% 
  select(Item_Identifier:Item_Outlet_Sales)

summary(big_mart_imputed)
#Discovering Way to Impute Values for Outlet_Size
#Outlet Identifier by Outlet Size Table
table(big_mart_imputed$Outlet_Identifier, big_mart_imputed$Outlet_Size)
#Outlet Identifier by Outlet_Type Table
table(big_mart_imputed$Outlet_Identifier, big_mart_imputed$Outlet_Type)
#Outlet Type by Outlet Size Table
table(big_mart$Outlet_Type, big_mart_imputed$Outlet_Size)
#Imputing Small for OUT010 Location Small for OUT010 Location
index3 <- which(big_mart_imputed$Outlet_Identifier == "OUT010")
big_mart_imputed[index3, "Outlet_Size"] <- "Small"
#Imputing Small for OUT017 Location
index4 <- which(big_mart_imputed$Outlet_Identifier == "OUT017")
big_mart_imputed[index4, "Outlet_Size"] <- "Small"
#Imputing Medium for OUT045 Location
index5 <- which(big_mart_imputed$Outlet_Identifier == "OUT045")
big_mart_imputed[index5, "Outlet_Size"] <- "Medium"
#Dropping Unused Levels for Outlet Size Variable
big_mart_imputed$Outlet_Size <- factor(big_mart_imputed$Outlet_Size)
#Summary Cleaned Dataset
summary(big_mart_imputed)
#Visualizing Data
#Item Outlet Sales Histogram
ggplot(big_mart_imputed, aes(x=Item_Outlet_Sales)) +
  geom_histogram(binwidth = 200) +
  labs(title = "Item Outlet Sales Histogram", 
       x = "Item Outlet Sales")
#Item Outlet Sales Histogram by Outlet Identifier
ggplot(big_mart_imputed, aes(x=Item_Outlet_Sales, 
                             fill = Outlet_Identifier)) +
  geom_histogram(binwidth = 200) +
  facet_wrap(~ Outlet_Identifier) +
  labs(title = "Item Outlet Sales Histogram", 
       x = "Item Outlet Sales")
#Sales by Outlet Identifier
ggplot(big_mart_imputed, aes(x = Outlet_Identifier,
                             y = Item_Outlet_Sales)) +
  geom_boxplot() +
  labs(title = "Sales by Outlet Identifier",
       x = "Outlet Identifier",
       y = "Item Outlet Sales") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
#Item Outlet Sales by Item MRP and Outlet Identifier
ggplot(big_mart_imputed, aes(x = Item_MRP,
                             y = Item_Outlet_Sales)) +
  geom_bin2d() +
  facet_wrap(~ Outlet_Identifier) +
  labs(title = "Item Outlet Sales by Item MRP and Outlet Identifier",
       x = "Item MRP",
       y = "Item Outlet Sales")
#Median Sales by Location
big_mart_imputed %>%
  group_by(Outlet_Identifier) %>%
  summarize(median_sales = median(Item_Outlet_Sales)) %>%
  arrange(desc(median_sales))
#Correlation of Item Outlet Sales and Item MRP
cor(big_mart_imputed$Item_MRP, big_mart_imputed$Item_Outlet_Sales)
#Machine Learning Models
#Removing Near Zero Variance Variables
#Preparing Data For Machine Learning
big_mart_sub <- big_mart_imputed  %>%
select(-Item_Identifier, -Outlet_Identifier)
set.seed(366284)
inTrain <- createDataPartition(y = big_mart_sub$Item_Outlet_Sales, 
                               p = 0.7, list=FALSE)
train <- big_mart_sub[inTrain, ]
test <- big_mart_sub[-inTrain, ]
#Building List
control <- trainControl(method = "repeatedcv", number = 10, repeats = 3, savePredictions = TRUE, classProbs = TRUE)

algorithmList <- c('glm', 'glmnet', 'lm', 'ranger', 'treebag', 'gbm', 'bagEarth')
models <- caretList(Item_Outlet_Sales ~ ., train, trControl = control, methodList = algorithmList)
#Model Performance
results <- resamples(models)
summary(results)

