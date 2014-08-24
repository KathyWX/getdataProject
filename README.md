Course Project of the "Getting and Cleaning Data" course
========================================================

README
==========

[Getting and Cleaning Data](https://www.coursera.org/course/getdata)
Course Project: Human Activity Recognition Using Smartphones

I take the following steps to finish this project.

#### Step 1 
Obtain the feature (i.e., measurement, variable) names from the 
features.txt file in the zip file. With these feature names, I can meet the 
part 4: Appropriately labels the data set with descriptive variable names.

#### Step 2
Obtain the activity labels from activity_labels.txt file contained
in the zip file. With these labels, I can meet the part 3: Uses descriptive
activity names to name the activities in the data set.

#### Step 3
For test set, I read the X_test.txt to get X.test.raw data frame. Then
I subset the columns of X.test.raw containing mean or std in their names to meet part 2:
Extracts only the measurements on the mean and standard deviation for each measurement.
I also did a left join with y.test.raw obtained from y_test.txt and activity.id2labels
obtained from activity_labels.txt to get the labels corresponding to ids in y_test.txt, 
by using join function in plyr package.

#### Step 4
I horizontally combine subject ids, activity labels, and measurement values.
This is a intermediate step for part 1: Merges the training and the test sets to create one data set.

#### Step 5 and 6
I did similar things as in 3rd and 4th steps on the training data set.

#### Step 7
I merged the training and the test sets to meet part 1.

#### Step 8
I used melt() and cast() functions in "reshape" R package to get the final tidy.data.

#### Step 9
I used write.table() function to write the tidy.data to HAR_tidy.txt.


## Instructions for this course project are given Below

The purpose of this project is to demonstrate your ability to collect,
work with, and clean a data set. The goal is to prepare tidy data that
can be used for later analysis. You will be graded by your peers on a
series of yes/no questions related to the project. You will be required
to submit: 1) a tidy data set as described below, 2) a link to a Github
repository with your script for performing the analysis, and 3) a code
book that describes the variables, the data, and any transformations or
work that you performed to clean up the data called CodeBook.md. You
should also include a README.md in the repo with your scripts. This
repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable
computing - see for example [this article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/).
Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most
advanced algorithms to attract new users. The data linked to from the course
website represent data collected from the accelerometers from the Samsung
Galaxy S smartphone. A full description is available at the site where the
data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

You should create one R script called run_analysis.R that does the following. 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
