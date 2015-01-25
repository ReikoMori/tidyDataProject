## --------------------------------------------------------------------------------------------------------- 
## Getting and Cleaning Data Course Project
## Author:  Peter Sheerin
## Filename: run_analysis.R
##
## Data description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
## Data source:      https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
##
## ---------------------------------------------------------------------------------------------------------

## Load required libraries
#install.packages("dplyr")   command to install dplyr if required
library(dplyr)


## STEP 1: Merge the Training and Test sets to create one data set.
#Read in the features list
featureData <- readLines("./UCI\ HAR\ Dataset/features.txt")

#Read in the Subject Identifier and Activity datasets
testSub <- readLines("./UCI\ HAR\ Dataset/test/subject_test.txt")
testAct <- readLines("./UCI\ HAR\ Dataset/test/y_test.txt")
trainSub <- readLines("./UCI\ HAR\ Dataset/train/subject_train.txt")
trainAct <- readLines("./UCI\ HAR\ Dataset/train/y_train.txt")

#Read in the data as a set of strings once for each lined in the original data file.
#and use " " to split each string into a list 
testData <- strsplit(readLines("./UCI\ HAR\ Dataset/test/X_test.txt")," ")
trainData <- strsplit(readLines("./UCI\ HAR\ Dataset/train/X_train.txt")," ")

#Use unlist to convert the dataset into one long list of strings
testData <- unlist(testData)
trainData <- unlist(trainData)

#Remove the empty elements caused by a double space in the dataset being interpretated as a missing value by strsplit()
testData <- testData[testData!=""]
trainData <- trainData[trainData!=""]

#Convert the now clean set of strings to numbers
testData <- as.numeric(testData)
trainData <- as.numeric(trainData)

#Convert to a dataframe with the same number of rows as the original structure prior to the use of unlist
#Note: we know the number of columns to use (561) from the featureData set which contains feature names
testData <- data.frame(matrix(testData,ncol=561))
trainData <- data.frame(matrix(trainData,ncol=561))

#Merge test and training feature data into Data Frame 
#Note: applying featureData as labels now to make STEP 2 easier.
combiData <- rbind(testData,trainData)
colnames(combiData) <- featureData

#Add activity and subject data as columns
combiData$Activity <- c(testAct,trainAct)
combiData$SubjectID <- c(testSub,trainSub)


## STEP 2: Extracts only the measurements on the mean and standard deviation for each measurement.

MeanStdData <- select(combiData,Activity,SubjectID,contains("mean("),contains("std("))


## STEP 3: Use descriptive activity names to name the activities in the data set

#Labels sourced from activity_labels.txt
MeanStdData$Activity[MeanStdData$Activity==1] <- "WALKING"
MeanStdData$Activity[MeanStdData$Activity==2] <- "WALKING_UPSTAIRS"
MeanStdData$Activity[MeanStdData$Activity==3] <- "WALKING_DOWNSTAIRS"
MeanStdData$Activity[MeanStdData$Activity==4] <- "SITTING"
MeanStdData$Activity[MeanStdData$Activity==5] <- "STANDING"
MeanStdData$Activity[MeanStdData$Activity==6] <- "LAYING"


## STEP 4; Appropriately label the data set with descriptive variable names

#Create a vector with the cleaned up descriptive variable names and apply it to the dataset
labels <- c("Activity","SubjectID","tBodyAcc-mean()-X-Axis","tBodyAcc-mean()-Y-Axis","tBodyAcc-mean()-Z-Axis","tGravityAcc-mean()-X-Axis","tGravityAcc-mean()-Y-Axis","tGravityAcc-mean()-Z-Axis","tBodyAccJerk-mean()-X-Axis","tBodyAccJerk-mean()-Y-Axis","tBodyAccJerk-mean()-Z-Axis","tBodyGyro-mean()-X-Axis","tBodyGyro-mean()-Y-Axis","tBodyGyro-mean()-Z-Axis","tBodyGyroJerk-mean()-X-Axis","tBodyGyroJerk-mean()-Y-Axis","tBodyGyroJerk-mean()-Z-Axis","tBodyAccMag-mean()","tGravityAccMag-mean()","tBodyAccJerkMag-mean()","tBodyGyroMag-mean()","tBodyGyroJerkMag-mean()","fBodyAcc-mean()-X-Axis","fBodyAcc-mean()-Y-Axis","fBodyAcc-mean()-Z-Axis","fBodyAccJerk-mean()-X-Axis","fBodyAccJerk-mean()-Y-Axis","fBodyAccJerk-mean()-Z-Axis","fBodyGyro-mean()-X-Axis","fBodyGyro-mean()-Y-Axis","fBodyGyro-mean()-Z-Axis","fBodyAccMag-mean()","fBodyBodyAccJerkMag-mean()","fBodyBodyGyroMag-mean()","fBodyBodyGyroJerkMag-mean()","tBodyAcc-std()-X-Axis","tBodyAcc-std()-Y-Axis","tBodyAcc-std()-Z-Axis","tGravityAcc-std()-X-Axis","tGravityAcc-std()-Y-Axis","tGravityAcc-std()-Z-Axis","tBodyAccJerk-std()-X-Axis","tBodyAccJerk-std()-Y-Axis","tBodyAccJerk-std()-Z-Axis","tBodyGyro-std()-X-Axis","tBodyGyro-std()-Y-Axis","tBodyGyro-std()-Z-Axis","tBodyGyroJerk-std()-X-Axis","tBodyGyroJerk-std()-Y-Axis","tBodyGyroJerk-std()-Z-Axis","tBodyAccMag-std()","tGravityAccMag-std()","tBodyAccJerkMag-std()","tBodyGyroMag-std()","tBodyGyroJerkMag-std()","fBodyAcc-std()-X-Axis","fBodyAcc-std()-Y-Axis","fBodyAcc-std()-Z-Axis","fBodyAccJerk-std()-X-Axis","fBodyAccJerk-std()-Y-Axis","fBodyAccJerk-std()-Z-Axis","fBodyGyro-std()-X-Axis","fBodyGyro-std()-Y-Axis","fBodyGyro-std()-Z-Axis","fBodyAccMag-std()","fBodyBodyAccJerkMag-std()","fBodyBodyGyroMag-std()","fBodyBodyGyroJerkMag-std()")
colnames(MeanStdData) <- labels


## STEP 5: Create a second, independent tidy data set with the average of each variable for each activity and each subject.

#Remove limit on the number of columns summarised by function
options(dplyr.width = Inf)

#Group the dataset by Activity then Subject and use summerise_each to write the averages to tidyData 
tidyData  <-summarise_each(group_by(MeanStdData,Activity,SubjectID),funs(mean))

write.table(tidyData,file="tidyData.txt",sep=",",row.name=FALSE)
