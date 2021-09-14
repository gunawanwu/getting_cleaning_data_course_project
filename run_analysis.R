#check your current working directory
getwd()

#set your intented working directory for this project
setwd("C:/Git_Clarivate/_RStudio/getting_cleaning_data_course_project")

#load required package
library(dplyr)

#download required dataset
filename <- "getdata_projectfiles_UCI HAR Dataset.zip"

# Checking if zip file already exists.
if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileURL, filename)
}  

# Checking if folder exists
if (!file.exists("UCI HAR Dataset")) { 
        unzip(filename) 
}

#assign each data to variables
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
str(features)
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
str(activities)
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
str(subject_test)
unique(subject_test)
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
str(x_test)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
str(y_test)
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
str(subject_train)
unique(subject_train)
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
str(x_train)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
str(y_train)

#Step 1: Merges the training and the test sets to create one data set.

X <- rbind(x_train, x_test)
str(X)
Y <- rbind(y_train, y_test)
str(Y)
Subject <- rbind(subject_train, subject_test)
str(Subject)
Merged_Data <- cbind(Subject, Y, X)
str(Merged_Data)

#Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.

Selected_Data <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))
str(Selected_Data)

#Step 3: Uses descriptive activity names to name the activities in the data set.

Selected_Data$code <- activities[Selected_Data$code, 2]

str(Selected_Data$code)

#Step 4: Appropriately labels the data set with descriptive variable names.

names(Selected_Data)

names(Selected_Data)[2] = "activity"
names(Selected_Data)<-gsub("Acc", "Accelerometer", names(Selected_Data))
names(Selected_Data)<-gsub("Gyro", "Gyroscope", names(Selected_Data))
names(Selected_Data)<-gsub("BodyBody", "Body", names(Selected_Data))
names(Selected_Data)<-gsub("Mag", "Magnitude", names(Selected_Data))
names(Selected_Data)<-gsub("^t", "Time", names(Selected_Data))
names(Selected_Data)<-gsub("^f", "Frequency", names(Selected_Data))
names(Selected_Data)<-gsub("tBody", "TimeBody", names(Selected_Data))
names(Selected_Data)<-gsub("-mean()", "Mean", names(Selected_Data), ignore.case = TRUE)
names(Selected_Data)<-gsub("-std()", "STD", names(Selected_Data), ignore.case = TRUE)
names(Selected_Data)<-gsub("-freq()", "Frequency", names(Selected_Data), ignore.case = TRUE)
names(Selected_Data)<-gsub("angle", "Angle", names(Selected_Data))
names(Selected_Data)<-gsub("gravity", "Gravity", names(Selected_Data))

names(Selected_Data)


#Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Final_Data <- Selected_Data %>%
        group_by(subject, activity) %>%
        summarise_all(funs(mean))

str(Final_Data)

write.table(Final_Data, "Final_Data.txt", row.name=FALSE)

