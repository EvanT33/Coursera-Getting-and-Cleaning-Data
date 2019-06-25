### Getting and Cleaning Data Course Project


# Import X_train dataset. Merge with y_train and rename train data labels
X_train <- read.table("~/Coursera Data Science Specialization/UCI HAR Dataset/train/X_train.txt", 
                      quote="\"", comment.char="")
y_train <- read.table("~/Coursera Data Science Specialization/UCI HAR Dataset/train/y_train.txt", 
                      quote="\"", comment.char="")
names(y_train)[1]<-"Label"
train <- cbind(X_train, y_train)
train$set <- "train"


# Import X_test dataset. Merge with y_test and rename test data labels
X_test <- read.table("~/Coursera Data Science Specialization/UCI HAR Dataset/test/X_test.txt", 
                      quote="\"", comment.char="")
y_test <- read.table("~/Coursera Data Science Specialization/UCI HAR Dataset/test/y_test.txt", 
                      quote="\"", comment.char="")
names(y_test)[1]<-"Label"
test <- cbind(X_test, y_test)
test$set <- "test"


# Append train and test sets
data <- rbind(train, test)


# Update labels
activity_labels <- read.table("~/Coursera Data Science Specialization/UCI HAR Dataset/activity_labels.txt", 
                              quote="\"", comment.char="")
names(activity_labels) <- c("Label","activity")
data <- merge(data, activity_labels, by = "Label")


# Update variable names
features <- read.table("~/Coursera Data Science Specialization/UCI HAR Dataset/features.txt", 
                       quote="\"", comment.char="")

col_idx <- grep("Label", names(data))
data <- data[, c((1:ncol(data))[-col_idx], col_idx)]
names(data) <- features$V2
names(data)[562] <- "set"
names(data)[563] <- "activity"
names(data)[564] <- "label"




