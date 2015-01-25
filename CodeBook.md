---
title: "CodeBook tidyData"
author: "Peter Sheerin"
date: "Saturday, January 24, 2015"
output: word_document
---

*  *  *  *

## Contents
+ ### The Data
+ ### Data Transformation and Clean Up
+ ### Data Dictionary

*  *  *  *

### The Data

The dataset used in this project was drawn from the *"Human Activity Recognition Using Smartphones Data Set"*. This is a database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.The links below contain a description of the original source data and the location of the excerpt provided for this project.

This excerpt was made up of *training* and *test* samples. These had seperate files containing the *activity*, the *subject identifier* and results for 561 different variables. For this project the following processing steps were carried out on this data to create the tidyData set:

* 1) Merges the training and the test sets to create one data set.
* 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
* 3) Uses descriptive activity names to name the activities in the data set.
* 4) Appropriately labels the data set with descriptive variable names. 
* 5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

A description of the variable contained in the tidy dataset derived from the original documentation is included in the *Data Dictionary* section.


~~~
Description of original source data: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Location of original source data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
~~~
*  *  *  *
### Data Transformation and Clean Up

This section describes any changes or alterations made to the data during processing. For a explaination of how the script works you should look at the *README.md* and the code *run_analysis.R* files.


**Merges the training and the test sets to create one data set.**

During this step no changes were made to the contents of the datasets.The *test* and *train* samples were joined together into a dataframe containing [*Activity, SubjectID, Variable_1, ..., Variable_561*].

**Extracts only the measurements on the mean and standard deviation for each measurement.** 

The instruction to extact only the mean and standard deviation for each measurement was interpreted to mean only those variables that were estimated from the signals using: 

        mean(): Mean value
        std(): Standard deviation

These variable were identified by the use of *-mean()* and *-std()* in the variable name.These 66 variables were extracted into a new dataframe along with the *Activity* and *SubjectID* identifiers.

**Uses descriptive activity names to name the activities in the data set.**

The *Activity* variable contained numbers 1-6 corresponding to *WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING* repectively. For this step the number was replaced with the corresponding descriptive activity name.

**Appropriately labels the data set with descriptive variable names.**

Descriptive variable names were added to the dataset. For the most part the names supplied with the project were suitable descriptive but some clean up was required.

For example:
*Sub* became *SubjectID*
*6 tBodyAcc-std()-X* became  *tBodyAcc-std()-X-Axis*

The *Data Dictionary* contains the full list of all descriptive variable names.

**From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.**

For the final processing step the dataset was first grouped by *Activity* and then *SubjectID*. The *summarise_each()* function was then used to extract the average of each of the 66 variable for the 180 different groupings of activity and subject into a new dataframe called *tidyData*.

This completed the projects processing steps.

*  *  *  *
### Data Dictionary

**Activity**        	type: Char

	Activity Type Carried Out
        
                WALKING
                WALKING_UPSTAIRS
                WALKING_DOWNSTAIRS
                SITTING
                STANDING
                LAYING
                

**SubjectID**	                type: Char

	Unique identifier for each subject who performed the activities
        
		1-30 Unique ID
                

**tBodyAcc-mean()-X-Axis**		type: Num

        Time domain measurement of the mean body acceleration signal in the X-Axis
        
**tBodyAcc-mean()-Y-Axis** 	        type: Num

        Time domain measurement of the mean body acceleration signal in the Y-Axis
        
**tBodyAcc-mean()-Z-Axis** 	        type: Num

        Time domain measurement of the mean body acceleration signal in the Z-Axis
        
**tGravityAcc-mean()-X-Axis** 	type: Num

        Time domain measurement of the mean gravity acceleration signal in the X-Axis

**tGravityAcc-mean()-Y-Axis** 	type: Num

        Time domain measurement of the mean gravity acceleration signal in the Y-Axis

**tGravityAcc-mean()-Z-Axis** 	type: Num

        Time domain measurement of the mean gravity acceleration signal in the Z-Axis

**tBodyAccJerk-mean()-X-Axis** 	type: Num

        Time domain measurement of the mean body linear acceleration and angular velocity derived in time in the X-Axis

**tBodyAccJerk-mean()-Y-Axis** 	type: Num

        Time domain measurement of the mean body linear acceleration and angular velocity derived in time in the Y-Axis

**tBodyAccJerk-mean()-Z-Axis** 	type: Num

        Time domain measurement of the mean body linear acceleration and angular velocity derived in time in the Z-Axis

**tBodyGyro-mean()-X-Axis** 	type: Num

        Time domain measurement of the mean body gyroscope signal in the X-Axis

**tBodyGyro-mean()-Y-Axis** 	type: Num

        Time domain measurement of the mean body gyroscope signal in the Y-Axis

**tBodyGyro-mean()-Z-Axis** 	type: Num

        Time domain measurement of the mean body gyroscope signal in the Z-Axis

**tBodyGyroJerk-mean()-X-Axis** 	type: Num

        Time domain measurement of the mean body gyroscope signal and angular velocity derived in time in the X-Axis

**tBodyGyroJerk-mean()-Y-Axis** 	type: Num

        Time domain measurement of the mean body gyroscope signal and angular velocity derived in time in the Y-Axis

**tBodyGyroJerk-mean()-Z-Axis** 	type: Num

        Time domain measurement of the mean body gyroscope signal and angular velocity derived in time in the Z-Axis

**tBodyAccMag-mean()**		type: Num

        Time domain measurement of the mean body acceleration magnitude calculated using the Euclidean norm

**tGravityAccMag-mean()**		type: Num

        Time domain measurement of the mean gravity acceleration magnitude calculated using the Euclidean norm
        
**tBodyAccJerkMag-mean()**	        type: Num

        Time domain measurement of the mean body acceleration and angular velocity derived in time magnitude
        
**tBodyGyroMag-mean()**		type: Num

        Time domain measurement of the mean body gyroscope magnitude 
        
**tBodyGyroJerkMag-mean()**	        type: Num

        Time domain measurement of the mean body gyroscope and angular velocity derived in time magnitude
        
**fBodyAcc-mean()-X-Axis** 	        type: Num

        Frequency domain measurement of the mean body acceleration signal in the X-Axis
        
**fBodyAcc-mean()-Y-Axis** 	        type: Num

        Frequency domain measurement of the mean body acceleration signal in the Y-Axis
  
**fBodyAcc-mean()-Z-Axis** 	        type: Num

        Frequency domain measurement of the mean body acceleration signal in the Z-Axis
  
**fBodyAccJerk-mean()-X-Axis** 	type: Num

        Fast Fourier Transform Frequency domain measurement of the mean body linear acceleration and angular velocity derived in time in the X-Axis
  
**fBodyAccJerk-mean()-Y-Axis** 	type: Num

        Fast Fourier Transform Frequency domain measurement of the mean body linear acceleration and angular velocity derived in time in the Y-Axis
  
**fBodyAccJerk-mean()-Z-Axis** 	type: Num

        Fast Fourier Transform Frequency domain measurement of the mean body linear acceleration and angular velocity derived in time in the Z-Axis
  
**fBodyGyro-mean()-X-Axis** 	type: Num

        Fast Fourier Transform Frequency domain measurement of the mean body gyroscope signal in the X-Axis
  
**fBodyGyro-mean()-Y-Axis** 	type: Num

        Fast Fourier Transform Frequency domain measurement of the mean body gyroscope signal in the Y-Axis
  
**fBodyGyro-mean()-Z-Axis** 	type: Num

        Fast Fourier Transform Frequency domain measurement of the mean body gyroscope signal in the Z-Axis
  
**fBodyAccMag-mean()**		type: Num

        Fast Fourier Transform Frequency domain measurement of the mean body acceleration magnitude calculated using the Euclidean norm
  
**fBodyBodyAccJerkMag-mean()**	type: Num

        Fast Fourier Transform Frequency domain measurement of the mean body acceleration and angular velocity derived in time magnitude
  
**fBodyBodyGyroMag-mean()**	        type: Num

        Fast Fourier Transform Frequency domain measurement of the mean body body gyroscope magnitude
  
**fBodyBodyGyroJerkMag-mean()**	type: Num

        Fast Fourier Transform Frequency domain measurement of the means body body gyroscope and angular velocity derived in time magnitude
  
**tBodyAcc-std()-X-Axis** 		type: Num

        Time domain measurement of the standard deviation in the body accleration signal in the X-Axis
  
**tBodyAcc-std()-Y-Axis** 		type: Num

        Time domain measurement of the standard deviation in the body accleration signal in the Y-Axis
  
**tBodyAcc-std()-Z-Axis** 		type: Num

        Time domain measurement of the standard deviation in the body accleration signal in the Z-Axis
  
**tGravityAcc-std()-X-Axis** 	type: Num

        Time domain measurement of the standard deviation in the gravity acceleration signal in the X-Axis
  
**tGravityAcc-std()-Y-Axis** 	type: Num

        Time domain measurement of the standard deviation in the gravity acceleration signal in the Y-Axis
  
**tGravityAcc-std()-Z-Axis** 	type: Num

        Time domain measurement of the standard deviation in the gravity acceleration signal in the Z-Axis
  
**tBodyAccJerk-std()-X-Axis** 	type: Num

        Time domain measurement of the standard deviation in the body linear acceleration and angular velocity derived in time in the X-Axis
  
**tBodyAccJerk-std()-Y-Axis** 	type: Num

        Time domain measurement of the standard deviation in the body linear acceleration and angular velocity derived in time in the Y-Axis
  
**tBodyAccJerk-std()-Z-Axis** 	type: Num

        Time domain measurement of the standard deviation in the body linear acceleration and angular velocity derived in time in the Z-Axis
  
**tBodyGyro-std()-X-Axis** 		type: Num

        Time domain measurement of the standard deviation in the body gyroscope signal in the X-Axis
  
**tBodyGyro-std()-Y-Axis** 		type: Num

        Time domain measurement of the  standard deviation in the body gyroscope signal in the Y-Axis
  
**tBodyGyro-std()-Z-Axis** 		type: Num

        Time domain measurement of the  standard deviation in the body gyroscope signal in the Z-Axis
  
**tBodyGyroJerk-std()-X-Axis** 	type: Num

        Time domain measurement of the standard deviation in the gyroscope signal and angular velocity derived in time in the X-Axis
  
**tBodyGyroJerk-std()-Y-Axis** 	type: Num

        Time domain measurement of the standard deviation in the gyroscope signal and angular velocity derived in time in the Y-Axis
  
**tBodyGyroJerk-std()-Z-Axis** 	type: Num

        Time domain measurement of the standard deviation in the gyroscope signal and angular velocity derived in time in the Z-Axis
  
**tBodyAccMag-std()**		type: Num

        Time domain measurement of the standard deviation in the body acceleration magnitude calculated using the Euclidean norm
  
**tGravityAccMag-std()**		type: Num

        Time domain measurement of the standard deviation in the gravity acceleration magnitude calculated using the Euclidean norm
  
**tBodyAccJerkMag-std()**		type: Num

        Time domain measurement of the standard deviation in the body acceleration and angular velocity derived in time magnitude
  
**tBodyGyroMag-std()**		type: Num

        Time domain measurement of the standard deviation in the body gyroscope magnitude
  
**tBodyGyroJerkMag-std()**	        type: Num

        Time domain measurement of the standard deviation in the body gyroscope and angular velocity derived in time magnitude
  
**fBodyAcc-std()-X-Axis** 		type: Num

        Fast Fourier Transform Frequency domain measurement of the standard deviation in the body accleration signal in the X-Axis
  
**fBodyAcc-std()-Y-Axis** 		type: Num

        Fast Fourier Transform Frequency domain measurement of the standard deviation in the body accleration signal in the Y-Axis
  
**fBodyAcc-std()-Z-Axis** 		type: Num

        Fast Fourier Transform Frequency domain measurement of the standard deviation in the body accleration signal in the Z-Axis
  
**fBodyAccJerk-std()-X-Axis** 	type: Num

        Fast Fourier Transform Frequency domain measurement of the standard deviation in the body linear acceleration and angular velocity derived in time in the X-Axis
  
**fBodyAccJerk-std()-Y-Axis** 	type: Num

        Fast Fourier Transform Frequency domain measurement of the standard deviation in the body linear acceleration and angular velocity derived in time in the Y-Axis
  
**fBodyAccJerk-std()-Z-Axis** 	type: Num

        Fast Fourier Transform Frequency domain measurement of the standard deviation in the body linear acceleration and angular velocity derived in time in the Z-Axis
  
**fBodyGyro-std()-X-Axis**		type: Num

        Fast Fourier Transform Frequency domain measurement of the standard deviation in the body gyroscope signal in the X-Axis
  
**fBodyGyro-std()-Y-Axis** 		type: Num

        Fast Fourier Transform Frequency domain measurement of the standard deviation in the body gyroscope signal in the Y-Axis
  
**fBodyGyro-std()-Z-Axis** 		type: Num

        Fast Fourier Transform Frequency domain measurement of the standard deviation in the body gyroscope signal in the Z-Axis
  
**fBodyAccMag-std()**		type: Num

        Fast Fourier Transform Frequency domain measurement of the standard deviation in the body acceleration magnitude calculated using the Euclidean norm
  
**fBodyBodyAccJerkMag-std()**	type: Num

        Fast Fourier Transform Frequency domain measurement of the standard deviation in the body acceleration and angular velocity derived in time magnitude
  
**fBodyBodyGyroMag-std()**	        type: Num

        Fast Fourier Transform Frequency domain measurement of the standard deviation in the body body gyroscope magnitude
  
**fBodyBodyGyroJerkMag-std()**	type: Num

        Fast Fourier Transform Frequency domain measurement of the standard deviation in the body body gyroscope and angular velocity derived in time magnitude
  
*  *  *  *
