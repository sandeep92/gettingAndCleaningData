##Getting and Cleaning Data Course Project
##Step 1: Merges the training and the test sets to create one data set.

## set the working directory
getwd()
# Load the data.table package
library(data.table)
# reading the feature.txt file in to R
feature_vector     <-  read.table("./CourseEra/UCI HAR Dataset/features.txt", sep = "")
# reading the X_train.txt file in to R with the respective variables
X_train         <-  read.table("./CourseEra/UCI HAR Dataset/train/X_train.txt", sep = "", col.names = feature_vector$V2)
# reading the X_test.txt file
X_test          <-  read.table("./CourseEra/UCI HAR Dataset/test/X_test.txt", sep = "", col.names = feature_vector$V2)
# Combining both the X data in to one table
X_data          <-  rbind(X_train, X_test)

# reading the subject_train.txt file and assinging the column name "Subject"
Subject_train   <-  read.table("./CourseEra/UCI HAR Dataset/train/subject_train.txt", sep = "", col.names = c("Subject"))
# reading the subject_test.txt file 
Subject_test    <-  read.table("./CourseEra/UCI HAR Dataset/test/subject_test.txt", sep = "", col.names = c("Subject"))
# Combining both the Subject data in to one table
Subject_data    <-  rbind(Subject_train, Subject_test)

# reading the Y_train.txt file with appropriate variables
Y_train         <-  read.table("./CourseEra/UCI HAR Dataset/train/Y_train.txt", sep = "", col.names = c("Activity"))
# reading the Y_test.txt file
Y_test          <-  read.table("./CourseEra/UCI HAR Dataset/test/Y_test.txt", sep = "", col.names = c("Activity"))
# Combining both the Y data in to one table
Y_data          <-  rbind(Y_train, Y_test)

# Combining all the table in to one table
Data            <-  cbind(X_data, Subject_data, Y_data) # original Data set


## Step 2: Extracts only the measurements on the mean and standard deviation for each measurement. 

# geeting the mean() columns
c_mean          <-  grep("mean()", feature_vector, fixed=TRUE)
# geeting the std() columns
c_std           <-  grep("std()", feature_vector, fixed=TRUE)
#Extracted data only with mean and std columns
Data_extracted  <-  cbind(Data[,c_mean], Data[,c_std]) # Extracted Data Set

## Step 3: Uses descriptive activity names to name the activities in the data set

# Changing to activity names (one by one; didn't find the appropriate function)
Data$Activity[Data$Activity == 1] <-  "WALKING"
Data$Activity[Data$Activity == 2] <-  "WALKING_UPSTAIRS"
Data$Activity[Data$Activity == 3] <-  "WALKING_DOWNSTAIRS"
Data$Activity[Data$Activity == 4] <-  "SITTING"
Data$Activity[Data$Activity == 5] <-  "STANDING"
Data$Activity[Data$Activity == 6] <-  "LAYING"

## Step 4: Appropriately labels the data set with descriptive activity names. 

#labelling
names(Data)     <-  gsub("Mag", "Magnitude", names(Data))

## Step 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# loading the reshape2 package 
library(reshape2)
#  first using the melt function, melt the Data into long format
melted_data     <-  melt(Data, id.vars = c("Subject", "Activity"))
# using the dcast function, it will cast the long data into wide data
tidyData        <-  dcast(melted_data, Subject + Activity ~ variable, mean)
# write the tidydata into text file
write.table(tidyData, file = "E:\\TidyData.txt",row.names = FALSE,sep = ";")
#display the tidydata
tidydata
