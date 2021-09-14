The run_analysis.R script performs the data preparation and then followed by the 5 steps required as described in the course project’s definition.

1) Download the dataset
Dataset downloaded and extracted under the folder called UCI HAR Dataset

2) Assign each data to variables
features <- features.txt : 561 obs. of  2 variables
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag


activities <- activity_labels.txt : 6 obs. of  2 variables
List of activities performed when the corresponding measurements were taken and its codes (labels)

1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING

subject_test <- test/subject_test.txt : 2947 obs. of  1 variable
contains test data of 9/30 volunteer subjects being observed

> unique(subject_test)
     subject
1          2
303        4
620        9
908       10
1202      12
1522      13
1849      18
2213      20
2567      24

x_test <- test/X_test.txt : 2947 obs. of  561 variables
contains recorded features test data

y_test <- test/y_test.txt : 2947 obs. of  1 variable
contains test data of activities’code (labels)

subject_train <- test/subject_train.txt : 7352 obs. of  1 variable
contains train data of 21/30 volunteer subjects being observed

> unique(subject_train)
     subject
1          1
348        3
689        5
991        6
1316       7
1624       8
1905      11
2221      14
2544      15
2872      16
3238      17
3606      19
3966      21
4374      22
4695      23
5067      25
5476      26
5868      27
6244      28
6626      29
6970      30

x_train <- test/X_train.txt : 7352 obs. of  561 variables
contains recorded features train data

y_train <- test/y_train.txt : 7352 obs. of  1 variable
contains train data of activities’code (labels)

3) Merges the training and the test sets to create one data set
X (10299 obs. of  561 variables) is created by merging x_train and x_test using rbind() function
Y (10299 obs. of  1 variable) is created by merging y_train and y_test using rbind() function
Subject (10299 obs. of  1 variable) is created by merging subject_train and subject_test using rbind() function
Merged_Data (10299 obs. of  563 variables) is created by merging Subject, Y and X using cbind() function

4) Extracts only the measurements on the mean and standard deviation for each measurement
Selected_Data (10299 obs. of  88 variables) is created by subsetting Merged_Data, selecting only columns: subject, code and the measurements on the mean and std for each measurement

5) Uses descriptive activity names to name the activities in the data set
Entire numbers in code column of the Selected_Data replaced with corresponding activity taken from second column of the activities variable

6) Appropriately labels the data set with descriptive variable names
code column in Selected_Data renamed into activities
All Acc in column’s name replaced by Accelerometer
All Gyro in column’s name replaced by Gyroscope
All BodyBody in column’s name replaced by Body
All Mag in column’s name replaced by Magnitude
All start with character f in column’s name replaced by Frequency
All start with character t in column’s name replaced by Time

7) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
Final_Data (180 obs. of 88 variables) is created by sumarizing Selected_Data taking the means of each variable for each activity and each subject, after groupped by subject and activity.
Export Final_Data into Final_Data.txt file.


