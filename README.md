# Coursera-Getting-and-Cleaning-Data Course Project

The file run_analysis.R does the following:

1. Imports and merges the training data and output labels
2. Imports and merges the subject identifiers onto the dataset in #1
3. Imports and merges the testing data and output labels
4. Imports and merges the subject identifiers onto the dataset in #3
5. Appends the training and testing data into 1 dataset, called "data.R"
6. Imports and merges on the descriptive activity names "Walking, Sitting, Laying, etc."
7. Imports the features.txt file and uses these as the new variable names
8. Removes any features which are not related to mean or standard deviation measures
9. Collapses the data by subject and activity, while taking the mean (ignoring NAs) of each measurement
10. Writes the file "tidydata.txt" to the working directory
