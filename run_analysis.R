# 1. Merges the training and the test sets to create one data set.
# loading test data set.
xtest <- read.table("/Users/hadoop/Desktop/CourseEraR/gettingAndCleaningData/Course\ Project/UCI\ HAR\ Dataset/test/X_test.txt", header=FALSE, sep="")
ytest <- read.table("/Users/hadoop/Desktop/CourseEraR/gettingAndCleaningData/Course\ Project/UCI\ HAR\ Dataset/test/y_test.txt")
subjectTest <- read.table("/Users/hadoop/Desktop/CourseEraR/gettingAndCleaningData/Course\ Project/UCI\ HAR\ Dataset/test/subject_test.txt")
consolidatedXTest <- cbind(xtest,ytest,subjectTest)

#loading train data set.
xtrain <- read.table("/Users/hadoop/Desktop/CourseEraR/gettingAndCleaningData/Course\ Project/UCI\ HAR\ Dataset/train/X_train.txt", header=FALSE,sep="")
ytrain <- read.table("/Users/hadoop/Desktop/CourseEraR/gettingAndCleaningData/Course\ Project/UCI\ HAR\ Dataset/train/y_train.txt")
subjectTrain <- read.table("/Users/hadoop/Desktop/CourseEraR/gettingAndCleaningData/Course\ Project/UCI\ HAR\ Dataset/train/subject_train.txt")
consolidatedXTrain <- cbind(xtrain,ytrain,subjectTrain)

# combining test and train observations.
trainTestData <- rbind(consolidatedXTest,consolidatedXTrain)
# adding features names as column names
features <- read.table("/Users/hadoop/Desktop/CourseEraR/gettingAndCleaningData/Course\ Project/UCI\ HAR\ Dataset/features.txt", header=FALSE, sep="")
names(trainTestData) <- as.character(features$V2)
names(trainTestData)[562:563] <- c("activity","subject")

# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 

#indices for mean() in feature vector
meanIndices <- grep("mean\\(\\)", features$V2)
#indices for std() in feature vector
stdIndices <- grep("std\\(\\)", features$V2)
#extract only those columns with mean() and std() for each measurement, also included activity and subject
trainTestDataWithMeanAndStd <- trainTestData[,c(meanIndices,stdIndices,562,563)]

#trainTestDataWithMeanAndStd has 60 columns(33 mean measurements , 33 std measurements, activity and subject).

# 3.Uses descriptive activity names to name the activities in the data set
# converting activity to factor and adding labels from activity_labels.txt
trainTestDataWithMeanAndStd$activity <- factor(trainTestDataWithMeanAndStd$activity, levels=c(1,2,3,4,5,6) ,labels=c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"))

#4 Appropriately labels the data set with descriptive variable names.
newColumnNames <- c()
for(variable in names(trainTestDataWithMeanAndStd)){
       
        if(length(grep("Acc",variable)) ==1 ){
                variable <- gsub("Acc","Acceleration",variable)
        }
        if(length(grep("Mag",variable)) ==1 ){
                variable <- gsub("Mag","Magnitude",variable)
        }
        if(length(grep("Gyro",variable)) ==1 ){
                variable <- gsub("Gyro","Gyroscope",variable)
        }
        if(length(grep("mean\\(\\)",variable)) ==1 ){
                variable <- gsub("mean\\(\\)","mean",variable)
        }else{
                if(length(grep("std\\(\\)", variable)) == 1){
                        variable <- gsub("std\\(\\)","standarddeviation", variable)
                }    
        }
        if(length(grep("-",variable)) ==1 ){
                variable <- gsub("-","",variable)
        }
        newColumnNames <- c(newColumnNames,variable)   
       
        names(trainTestDataWithMeanAndStd) <-  newColumnNames 
}



#5 Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
trainTestDataWithMeanAndStd <- data.table(trainTestDataWithMeanAndStd)
trainTestDataWithMeanAndStd$subject <- factor(trainTestDataWithMeanAndStd$subject)
Molten <- melt(trainTestDataWithMeanAndStd, id.vars = c("activity","subject"))
tidyData <- cast(data=Molten, fun=mean)

write.csv(tidyData, file="tidyData")
