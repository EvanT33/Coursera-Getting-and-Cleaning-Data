##### Getting and Cleaning Data Course Project #####



########################################################################
### STEP 1: Merges the training and the test sets to create one data set
########################################################################

# Import X_train dataset. Merge with y_train and rename train data labels
X_train <- read.table("~/Coursera Data Science Specialization/UCI HAR Dataset/train/X_train.txt", 
                      
                      quote="\"", comment.char="")
y_train <- read.table("~/Coursera Data Science Specialization/UCI HAR Dataset/train/y_train.txt", 
                      quote="\"", comment.char="")
names(y_train)[1]<-"Label"
train <- cbind(X_train, y_train)
train$set <- "train"


# Import subject_train and merge onto training data
subject_train <- read.table("~/Coursera Data Science Specialization/UCI HAR Dataset/train/subject_train.txt", quote="\"", comment.char="")
names(subject_train)[1] <- "subject"
train <- cbind(train, subject_train)



# Import X_test dataset. Merge with y_test and rename test data labels
X_test <- read.table("~/Coursera Data Science Specialization/UCI HAR Dataset/test/X_test.txt", 
                     quote="\"", comment.char="")
y_test <- read.table("~/Coursera Data Science Specialization/UCI HAR Dataset/test/y_test.txt", 
                     quote="\"", comment.char="")
names(y_test)[1]<-"Label"
test <- cbind(X_test, y_test)
test$set <- "test"


# Import subject_test and merge onto testing data
subject_test <- read.table("~/Coursera Data Science Specialization/UCI HAR Dataset/test/subject_test.txt", quote="\"", comment.char="")
names(subject_test)[1] <- "subject"
test <- cbind(test, subject_test)


# Append train and test sets
data <- rbind(train, test)



##################################################################################
### STEP 3: Uses descriptive activity names to name the activities in the data set
##################################################################################

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
names(data)[563] <- "subject"
names(data)[564] <- "label"
names(data)[565] <- "activity"




##################################################################################################
### STEP 2: Extracts only the measurements on the mean and standard deviation for each measurement
##################################################################################################

# Keep only desired variables (mean and std variables)
data <- data[ ,grep(".*mean\\(.*|.*std\\(.*|.*label.*|.*subject.*", names(data))]
names(data)[ncol(data)] <- "activity"




#############################################################################
### STEP 4: Appropriately labels the data set with descriptive variable names 
#############################################################################

# Rename columns with descriptive variable names
names(data) <- gsub("std\\()", "STD", names(data))
names(data) <- gsub("mean\\()", "MEAN", names(data))
names(data) <- gsub("-", "", names(data))




#################################################################################
### STEP 5: From the data set in step 4, creates a second, independent tidy 
### data set with the average of each variable for each activity and each subject
#################################################################################

# subject activity variables(?) (should be 180 rows)
data_aggregated <- aggregate(data, by = list(data$subject, data$activity), FUN = mean, na.rm = TRUE)
names(data_aggregated)[1:2] <- c("subject", "activity")
data_aggregated <- data_aggregated[, 1:68]




#########################################
####### Export tidy dataset #############
#########################################

write.table(data_aggregated, "tidydata.txt", row.names = FALSE, quote = FALSE)
