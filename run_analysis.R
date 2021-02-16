##First, we will merge the training and test data sets to create one combined data set

##Set up the working directory to be the folder where the files are located
setwd("C:/Users/ivabr/Documents/UCI HAR Datasets")
list.files(getwd(),pattern=".*.txt") ##Checking to see what files are located in the path


##Create data frames "Activities" and "Features" for the respective files containing these elements in the path
Activities <- read.table("activity_labels.txt", header = FALSE)
Features <- read.table ("features.txt", header = FALSE)


##Set new working directory to be the folder where the test data is located
setwd("C:/Users/ivabr/Documents/UCI HAR Datasets/test")
list.files(getwd(),pattern=".*.txt") ##Checking to see what files are located in the path

##Create data frames for each of the respective files that we will need the data elements from
subject_test <- read.table("subject_test.txt", header = FALSE) ##Data frame for subject_test data
X_test <- read.table("X_test.txt", header = FALSE) ##Data frame for X_test data
y_test <- read.table("y_test.txt", header = FALSE) ##Data frame for y_test data

##Set your new working directory to be the folder where the train data is located
setwd("C:/Users/ivabr/Documents/UCI HAR Datasets/train")
list.files(getwd(),pattern=".*.txt") ##Checking to see what files are located in the path

##Create data frames for each of the respective files that we will need the data elements from
subject_train <- read.table("subject_train.txt", header = FALSE) ##Data frame for subject_train data
X_train <- read.table("X_train.txt", header = FALSE) ##Data frame for X_train data
y_train <- read.table("y_train.txt", header = FALSE) ##Data frame for y_train data


##1. Merge training and test datasets using rbind
SubjectMerge <- rbind(subject_test, subject_train) ##merging the subject_test and subject_train datasets
YMerge<- rbind(y_test, y_train) ##Merging the y_test and y_train datasets
XMerge<- rbind(X_test, X_train) ##Merging the x_test and x_train datasets

##Set names for the elements in each merged dataset
names(SubjectMerge)<-c("subject") ##setting name "subject" for the field of the merged subject train and test merged datasets
names(YMerge)<- c("activity") ##assigning name "activity" for column in y_test and y_train merged datasets
names(XMerge)<- Features$V2 ##using second column of data frame for Features to assign names for the x_test and x_train merged datasets


##Final merge of all columns and datasets
CombineAll <- cbind(SubjectMerge, YMerge) ##combine "subject" merged datasets with activities datasets
ALLData <- cbind(XMerge, CombineAll) ##combine features and activities 


##2.Now we are going to extract only the mean and standard deviation for each measurement using sapply as a function

XMean<-sapply(XMerge, mean, na.rm=TRUE) ##Mean for the features 
XStDev<-sapply(XMerge, sd, na.rm=TRUE)  ##St. Dev for the features



##3.Next, we are going to use descriptive activity names to name the activities in the dataset

head(Activities)

ALLData$activity[ALLData$activity==1] <- "WALKING"
ALLData$activity[ALLData$activity==2] <- "WALKING_UPSTAIRS"
ALLData$activity[ALLData$activity==3] <- "WALKING_DOWNSTAIRS"
ALLData$activity[ALLData$activity==4] <- "SITTING"
ALLData$activity[ALLData$activity==5] <- "STANDING"
ALLData$activity[ALLData$activity==6] <- "LAYING"

##4. Next, we need to appropriately label the dataset with descriptive variable names

##let's see the current names of the new dataset and then use gsub to fix

names(ALLData)

##Remove all the brackets and "-" characters to clean the names of the columns with gsub function
names(ALLData) <- gsub("(\\(|\\)|\\-)","", names(ALLData)) 


##5. From the new dataset, we will now create a second, 
##independent tidy data set with the average of each variable for each activity and each subject.

library(dplyr)

##taking the average for each activity and each subject
NEWdata<-aggregate(. ~subject + activity, ALLData, mean) 

write.table(NEWdata, file = "NEWdata.txt",row.name=FALSE)
