filename <- "Coursera_DS3_Final.zip"

if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  

if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

#Assign data to variables

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

#To begin with, we have to get over view of data.
head(features);dim(features)
head(activities);dim(activities)
head(subject_test);dim(subject_test)
head(x_test);dim(x_test)
head(y_test);dim(y_test)
head(subject_train);dim(subject_train)
head(x_train);dim(x_train)
head(y_train);dim(y_train)

#1.Merges the training and the test sets to create one data set.
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject, Y, X)

#2Extracts only the measurements on the mean and standard deviation for each measurement. 
library(dplyr)

Tidydata <- select(Merged_Data,c(subject,code))
Tidydata <- cbind(Tidydata,Merged_Data[,grep("mean",names(Merged_Data))],Merged_Data[,grep("std",names(Merged_Data))])


#3Uses descriptive activity names to name the activities in the data set
Tidydata$code <- activities[Tidydata$code, 2]

#4Appropriately labels the data set with descriptive variable names. 
names(Tidydata)[2] = "activity"
names(Tidydata)<-gsub("Acc", "Accelerometer", names(Tidydata))
names(Tidydata)<-gsub("Gyro", "Gyroscope", names(Tidydata))
names(Tidydata)<-gsub("BodyBody", "Body", names(Tidydata))
names(Tidydata)<-gsub("Mag", "Magnitude", names(Tidydata))
names(Tidydata)<-gsub("^t", "Time", names(Tidydata))
names(Tidydata)<-gsub("^f", "Frequency", names(Tidydata))
names(Tidydata)<-gsub("tBody", "TimeBody", names(Tidydata))
names(Tidydata)<-gsub("-mean()", "Mean", names(Tidydata), ignore.case = TRUE)
names(Tidydata)<-gsub("-std()", "STD", names(Tidydata), ignore.case = TRUE)
names(Tidydata)<-gsub("-freq()", "Frequency", names(Tidydata), ignore.case = TRUE)
names(Tidydata)<-gsub("angle", "Angle", names(Tidydata))
names(Tidydata)<-gsub("gravity", "Gravity", names(Tidydata))


#5From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
#for each activity and each subject.

FinalData <- Tidydata %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(FinalData, "FinalData.txt", row.name=FALSE)



