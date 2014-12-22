getdata-course-project
======================

Course project for the Coursera class Getting and Cleaning Data

##run_analysis.R

####Preparatory work

This section handles loading the training and test datasets into R.  After loading each dataset into R, we also attach the respective subject and activity files as the first and second columns.

Note that the https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip dataset must be in a directory named "data".

####Step 1 -- Merge the training and the test sets to create one data set.

The two datasets are combined by appending the test dataset to the larger train set, and then reordered based on the subjectID.

####Step 2 -- Extract only the measurements on the mean and standard deviation for each measurement. 

In order to extract the mean and std columns for each measurement, we first must read in the feature names.  Since we added two columns at the beginning of the dataset back in the Preparatory section, we need to do the same to the feature names set.  After that, we can get a list of column indices that match our requirements.  

There are multiple different occurrances of the word "mean" in the names set.  We are only interested in those that occur in the same pattern as the std features.  Thus, we want to ignore matches of "Mean" (as in 
angle(Z,gravityMean)) and "meanF" (as in fBodyAcc-meanFreq()-X) since neither of these columns represent a pure mean calculation of the underlying measurement.

####Step 3 -- Use descriptive activity names to name the activities in the data set

To replace the numerical representation of activities with more descriptive names, we first read in the activity_labels dataset.  Next we simply convert the activity column into a factor and rename the levels to the respective names within our activity_labels set.

####Step 4 -- Appropriately label the data set with descriptive variable names. 

Before we assign descriptive names to our dataset's columns, we need to do a little cleanup on the provided feature names dataset.  After subsetting out the columns we want to keep, we replace the 'f' and 't' prefixes with 'freq' and 'time', remove the illegal parenthesis characters, replace the illegal hyphens with periods, and correct the "BodyBody" typo.  The last step is to assign our cleaned up names to the main dataset's columns.

####Step 5 -- From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

The aggregate() function allows us to apply a funciton across each column of a provided dataset, grouped by a seperate provided list.  To create the tidy data set, we exclude the subjectID and activity from the calculation, provide those two columns as the grouping/subsetting columns, and pass in the mean() function.  Next we append the characters ".ave" to each column to reflect the new data's meaning.  We also reset the first two columns to their original names, as they are not averaged.

Lastly, we write out the tidy data set to the "tidyData.txt" file.

#####What next?

If you wish to read in the tidyData.txt file and examine it in R, use the following code:

`data <- read.table("tidyData.txt", header=T); View(data)`