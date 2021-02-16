This code book intends to go into further details on the work done, describing the variables, the data, and any transformations or work that was done to clean up the data in the run_analysis.R script.

##1. Merging the training and the test sets into one data set
  
We begin by setting the work directory using setwd() to the location where we save theunzipped files. 
Then we subsequently list the files located in the UCI HAR Datasets folder.

The files listed return "activity_labels.txt", "features.txt", "features_info.txt" and "README.txt"



We assign new data frames for the datasets "activity_labels.txt" and "features.txt" as "Activities" and "Features" respectively.
Activities contains 6 observations of 2 variables. Features contains 561 observations of 2 variables.



Then we set our new working directory to be the folder where the test data is located using setwd()
We want to see all the files there as well, and assign respective data frames for the subjects, activities (Y), and features (X) for the test datasets.
There are 2947 observations in the test data frames. 

We do the same for the train data - we set our new working directory to be the folder where the train data is located using setwd()
We want to see all the files there as well, and assign respective data frames for the subjects, activities (Y), and features (X) for the train datasets.
There are 7352 observations in the test data frames. 


We assign readable names to the variables (subject, activity, and features - the latter using second column of data frame for Features to assign names for the x_test and x_train merged datasets), 
and subsequently merge the variables and data to get the data frame ALLData for all the datasets combined. ALLData contains 10299 observations of 563 variables.


##2. Extracting only the measurements on the mean and standard deviation for each measurement.

Using sapply as a function to get the XMean and XStDev for the means and standard deviations for all the features in the combined X datasets.



##3. Using descriptive activity names to name the activities in the data set and appropriately labels the data set with descriptive variable names.

The code looks at the Activities data frame as a cross-walk to build the respective lables. The Activity labels in the merged dataset are respectively
changed to match from their numeric values to descriptive. 


##4. Next, we need to appropriately label the dataset with descriptive variable names

At this point, we use the gsub function to remove all brackets and characters from the names in the combined ALLData dataset and clean the columns.



##5. From the new dataset, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The NEWdata data frame is created from the new dataset, using average for each activity and each subject

