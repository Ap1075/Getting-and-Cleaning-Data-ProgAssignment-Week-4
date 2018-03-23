library(dplyr)

X_test <- read.table("./test/X_test.txt")
Y_test <- read.table("./test/Y_test.txt")
subtest <- read.table("./test/subject_test.txt")

X_train <- read.table("./train/X_train.txt")
Y_train <- read.table("./train/Y_train.txt")
subtrain <- read.table("./train/subject_train.txt")

X<- rbind(X_train,X_test)
Y<- rbind(Y_train,Y_test)
sub<- rbind(subtrain,subtest)

variable_names <- read.table("features.txt")

acts <- read.table("activity_labels.txt")

myvars <- variable_names[grep("mean\\(\\)|std\\(\\)", variable_names[,2]),]
X<- X[,myvars[,1]]

colnames(Y)<- "activity"
Y$activitylabel <- factor(Y$activity, labels= as.character(acts[,2]))
activitylabel <- Y[,-1]
activitylabel<- activitylabel[,2]

colnames(X) <- variable_names[myvars[,1],2]
total <- cbind(X, activitylabel, sub)
total_mean <- total %>% group_by(activitylabel, subject) %>% summarize_all(funs(mean))
write.table(total_mean, file = "./mytidydata.txt", row.names = FALSE, col.names = TRUE)

