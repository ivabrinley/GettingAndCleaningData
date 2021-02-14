This code book intends to go into further details on the work done, describing the variables, the data, and any transformations or work
that was done to clean up the data in the run_analysis.R script.

##1. Merging the training and the test sets into one data set
  
We begin by setting the work directory using setwd() to the location where we save the
unzipped files. Then we subsequently list the files located in the UCI HAR Datasets folder.

The files listed return "activity_labels.txt", "features.txt", "features_info.txt" and "README.txt"

We use the activity_labels.txt and features.txt saved as new data frames to be used later.

Then we set our new working directory to be the folder where the test data is located using setwd()
We want to see all the files there as well, and assign respective data frames the same way as earlier.

We repeat for the train data, and finally merge all of the files together using rbind for the subject, the Y and the X data.
We assign readable names to variable, and subsequently merge the columns to get the data frame ALLData for all the data.


##2. Extracting only the measurements on the mean and standard deviation for each measurement.

Using sapply as a function to all the merged files, getting the mean and standard deviations for 
each measurement. The subject mean resulted in 16.15; The subject standard deviation resulted in
8.68. The X mean and standard deviation showed for 561 rows. The Y activity mean resulted in 3.62, and the standard deviation in 1.74


##3. Uses descriptive activity names to name the activities in the data set and 
#appropriately labels the data set with descriptive variable names.

The code looks at the Activities data frame as a cross-walk to build the respective lables. The Activity labels in the merged dataset are respectively
changed to match from their numeric values to descriptive. 

##4. Next, we need to appropriately label the dataset with descriptive variable names
The code looks into the current names and respectively labels are fixed using gsub function.


##5. From the new dataset, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The NEWdata data frame is created from the new dataset, using average for each activity and each subject



