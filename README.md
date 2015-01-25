---
title: "Getting and Cleaning Data Course Project README"
author: "Peter Sheerin"
date: "Saturday, January 24, 2015"
output: word_document
---

*  *  *  *

##Project Outline
The stated purpose of this project was to demonstrate the ability to collect, work with, and clean a data set. The goal was to prepare tidy data that can be used for later analysis.

###The Following Files are Provided
**tidyData.csv**
        A dataset containing the output of the project processing steps that conforms to the principles of tidy data.

**run_analysis.R**
        The script written for performing the analysis described in the projects processing steps.

**README.md**
        This markup document explaining how the script works and different files provided.

**CodeBook.md**
        A markup document describingthe variables, the data, the transformations and work performed to clean the dataset.

*  *  *  *
### How the Script Works

This section describes how the sript functions for each of the projects processing steps. You can find the commented code in the file *run_analysis.R*.

**Load required libraries**

This R script makes use of commands from the *dplyr* package so the script loads this library as a first step.

**STEP 1: Merge the Training and Test sets to create one data set.**

Next we read in the *features list, Subject ID, Activity* and all 561 variables for both the *test* and *training* datasets.

The 561 variables were read in as a set of strings one for each line in the original data file and " " use to split the strings into lists. The *unlist* function was then used to convert these into two long lists of strings, one each for *test* and *training*.

Due to double spacing between some values in the original datasets a number of empty elements were artifically introduced by the spliting step so these were removed.There were no NA values in the dataset so no further cleaning was needed.

The now clean set of strings was converted to numbers using the *as.numeric()* funtion. Then converted to a dataframe with the same number of rows as the original structure prior to the use of unlist resulting in 2947 obs in *test* and 7352 obs in *train* with 561 variables in each.

The cleaned *test* and *train* datasets were then combined using *rbind()* and the feature list applied as lables using *colnames()* now to make STEP 2 easier. The *test* and *train* data for *Activity* and *SubjectID* was combined in the same order and added to the data frame. This resulted in 10299 obs of 563 variables.


**STEP 2: Extracts only the measurements on the mean and standard deviation for each measurement**

The *dplyr* function *select* was used to extract the *Activity, SubjectId* and those variables that were estimated from the signals using: 

        mean(): Mean value
        std(): Standard deviation

These variable were identified by the use of *-mean()* and *-std()* in the variable name using the *contains()* function. Resulted in 10299 obs of 68 variables.


**STEP 3: Use descriptive activity names to name the activities in the data set**

To add descriptive names to the *Activity* data, the numeric indictors were changed to names sourced from the *activity_labels.txt* file provided.For example

~~~
MeanStdData$Activity[MeanStdData$Activity==1] <- "WALKING"
~~~

**STEP 4; Appropriately label the data set with descriptive variable names**

As the variables labels from the feature list applied in step one were still present. A vector was constructed from them with cleaned up descriptive names and apply using the *colnames()* fuction. This ensured that the variables would be labeled in the correct order.


**STEP 5: Create a second, independent tidy data set with the average of each variable for each activity and each subject.**

For the final processing step the dataset was first grouped by *Activity* and then *SubjectID* using the *group_by()* funtion. Then the *summarise_each()* function was used to find the average of each of the 66 variable for the 180 different groupings of activity/subject using the *funs(mean)* option and extracted into a new dataframe called *tidyData*.

Note that for my installation I also had to remove the limit on the number of columns summaried by the *summarise_each()* funtion using:

~~~
options(dplyr.width = Inf)
~~~

This *tidyData* dataframe was then saved using *write.table* to a csv using the following options:

~~~
write.table(tidyData,file="tidyData.txt",sep=",",row.name=FALSE)
~~~
