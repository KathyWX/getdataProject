## Course Project of the "Getting and Cleaning Data" course on Coursera

## This run_analysis.R script does the following five parts:
## part 1. Merges the training and the test sets to create one data set.
## part 2. Extracts only the measurements on the mean and standard deviation 
##         for each measurement. 
## part 3. Uses descriptive activity names to name the activities in the data set
## part 4. Appropriately labels the data set with descriptive variable names. 
## part 5. Creates a second, independent tidy data set with the average of 
##         each variable for each activity and each subject. 

library(plyr)
library(reshape)

## part 4: Appropriately labels the data set with descriptive variable names.
## I use the variable names stored in the features.txt file contained in the 
## getdata-projectfiles-UCI HAR Dataset.zip file.

X.feature.names <- read.table("./UCI HAR Dataset/features.txt", sep=" ", 
                              col.names=c("feature.id", "feature.name"))

## part 3: Use descriptive activity names to name the activities in the data set.
## I use the activity labels stored in the activity_labels.txt file contained in
## the getdata-projectfiles-UCI HAR Dataset.zip file.

activity.id2labels <- read.table("./UCI HAR Dataset/activity_labels.txt", sep=" ",
                                 col.names=c("activity.id", "activity.label"))

##################
## For Test Set ##
##################

## part 4: Appropriately labels the data set with descriptive variable names.
X.test.raw <- read.table("./UCI HAR Dataset/test/X_test.txt",
                         col.names=X.feature.names$feature.name)

## part 2: Extracts only the measurements on the mean and standard deviation 
##         for each measurement. 
## Subsetting those columns contain "mean" or "std" in their name
X.test.raw <- X.test.raw[, grepl("mean|std" , names(X.test.raw))]

#part 3: Use descriptive activity names to name the activities in the data set.
y.test.raw <- read.table("./UCI HAR Dataset/test/y_test.txt",
                         col.names=c("activity.id"))
y.test.id2label <- join(y.test.raw, activity.id2labels)
activity.label <- y.test.id2label$activity.label

## Intermediate step
## I used the subject ids stored in the subject_test.txt file
## contained in the getdata-projectfiles-UCI HAR Dataset.zip file.
subject.ids.test <- read.table("./UCI HAR Dataset/test/subject_test.txt",
                               col.names=c("subject.id"))

## Intermediate step for part 1: 
## horizontally combine subject ids, activity labels, and 
## measurement values to create the test.data set.
test.data <- cbind(subject.ids.test, 
                   activity.label, 
                   X.test.raw)

######################
## For training Set ##
######################
## part 4: Appropriately labels the data set with descriptive variable names.
X.train.raw <- read.table("./UCI HAR Dataset/train/X_train.txt",
                         col.names=X.feature.names$feature.name)

## part 2: Extracts only the measurements on the mean and standard deviation 
## for each measurement. 
## Subsetting those columns contain "mean" or "std" in their names.
X.train.raw <- X.train.raw[, grepl("mean|std" , names(X.train.raw))]

## part 3: Use descriptive activity names to name the activities in the data set.
y.train.raw <- read.table("./UCI HAR Dataset/train/y_train.txt",
                         col.names=c("activity.id"))
y.train.id2label <- join(y.train.raw, 
                         activity.id2labels)
activity.label <- y.train.id2label$activity.label

## Intermediate step:
## I used the subject ids stored in the subject_test.txt file
## contained in the getdata-projectfiles-UCI HAR Dataset.zip file.
subject.ids.train <- read.table("./UCI HAR Dataset/train/subject_train.txt",
                               col.names=c("subject.id"))

## Intermediate step for part 1: 
## Horizontally combine subject ids, activity labels, and 
## measurement values to create the train.data set.
train.data <- cbind(subject.ids.train, 
                    activity.label, 
                    X.train.raw)

## part 1: Merges the training and the test sets to create one data set.
whole.data <- rbind(test.data, train.data)
whole.data$subject.id <- as.factor(whole.data$subject.id)

## Finally
## part 5: Creates a second, independent tidy data set with the average of 
##         each variable for each activity and each subject. 
## Here I used the "melt" and "cast" functions in "reshape" package 
## to create the final tidy.data set.
melted.whole.data <- melt(whole.data, id=c("subject.id", "activity.label"))
tidy.data <- cast(melted.whole.data, 
                  subject.id + activity.label~variable, 
                  mean)
column.names <- colnames(tidy.data)
colnames(tidy.data) <- c(column.names[1:2],
                              paste("average.", 
                                    column.names[3:length(column.names)],
                                    sep=""))
write.table(tidy.data, file = "HAR_tidy.txt", row.names=FALSE)

## The end