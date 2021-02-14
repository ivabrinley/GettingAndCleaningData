##Find out what the working directory is
getwd()

##First, we will merge the training and test data sets to create one combined data set

##Set up the working directory to be the folder where the files are located
setwd("C:/Users/ivabr/Documents/UCI HAR Datasets")
list.files(getwd(),pattern=".*.txt")

##Create data frames Activities and Features for the respective files containing these elements

Activities <- read.table("activity_labels.txt", header = FALSE)
Features <- read.table ("features.txt", header = FALSE)

##Set new working directory to be the folder where the test data is located
##Check to see what the files are there and subsequently create vectors for each of
##the datasets

setwd("C:/Users/ivabr/Documents/UCI HAR Datasets/test")
list.files(getwd(),pattern=".*.txt")

subject_test <- read.table("subject_test.txt", header = FALSE)
X_test <- read.table("X_test.txt", header = FALSE)
y_test <- read.table("y_test.txt", header = FALSE)

##Set your new working directory to be the folder where the train data is located
##Check to see what the files are there and subsequently create vectors for each of
##the datasets

setwd("C:/Users/ivabr/Documents/UCI HAR Datasets/train")
list.files(getwd(),pattern=".*.txt")

subject_train <- read.table("subject_train.txt", header = FALSE)
X_train <- read.table("X_train.txt", header = FALSE)
y_train <- read.table("y_train.txt", header = FALSE)


##1. Merge training and test datasets using rbind

SubjectMerge <- rbind(subject_test, subject_train)
YMerge<- rbind(y_train, y_test)
XMerge<- rbind(X_train, X_test)

##set names to variables
names(SubjectMerge)<-c("subject")
names(YMerge)<- c("activity")
Xnames <- Features
names(XMerge)<- Xnames$V2

##Merge columns and create ALLData combining all the data
CombineAll <- cbind(SubjectMerge, YMerge)
ALLData <- cbind(XMerge, CombineAll)

##2.Now we are going to extract only the mean and standard deviation for each measurement
##using sapply as a function

SubjectMean<-sapply(SubjectMerge, mean, na.rm=TRUE)  
SubjectSD<-sapply(SubjectMerge, sd, na.rm=TRUE) 

XMean<-sapply(XMerge, mean, na.rm=TRUE)  
XStDev<-sapply(XMerge, sd, na.rm=TRUE)  

YMean<-sapply(YMerge, mean, na.rm=TRUE)  
YSDDev<-sapply(YMerge, sd, na.rm=TRUE) 



##3.Next, we are going to use descriptive activity names to name the activities
##in the dataset

head(Activities)

ALLData$activity[ALLData$activity==1] <- "WALKING"
ALLData$activity[ALLData$activity==2] <- "WALKING_UPSTAIRS"
ALLData$activity[ALLData$activity==3] <- "WALKING_DOWNSTAIRS"
ALLData$activity[ALLData$activity==4] <- "SITTING"
ALLData$activity[ALLData$activity==5] <- "STANDING"
ALLData$activity[ALLData$activity==6] <- "LAYING"

##4. Next, we need to appropriately label the dataset with descriptive variable names

##let's read the feature names from the features file
featurenames   <- read.table("./features.txt")
featurenames

##let's see the current names of the new dataset and then use gsub to fix

names(ALLData)

FixTime<-gsub("^t", "time", names(ALLData))
FixFrequency<-gsub("^f", "frequency", names(ALLData))
cleaner <- function(featurenames) {
  tolower(gsub("(\\(|\\)|\\-)","",featurenames))
}


##5. From the new dataset, we will now create a second, 
#independent tidy data set with the average of each variable for each activity and each subject.

library(dplyr)

NEWdata<-aggregate(. ~subject + activity, ALLData, mean)

NEWdata<-NEWdata[order(NEWdata$subject,NEWdata$activity),]

write.table(NEWdata, file = "NEWdata.txt",row.name=FALSE)

NEWdata
