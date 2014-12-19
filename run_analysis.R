## Preparatory work: Loading data 
test <- read.table("data/test/X_test.txt")
subject_test <- read.table("data/test/subject_test.txt", col.names = "subjectID")
activity_test <- read.table("data/test/y_test.txt", col.names = "activity")
test <- cbind(subject_test, activity_test, test)

train <- read.table("data/train/X_train.txt")
subject_train <- read.table("data/train/subject_train.txt", col.names = "subjectID")
activity_train <- read.table("data/train/y_train.txt", col.names = "activity")
train <- cbind(subject_train, activity_train, train)

# Cleanup temp variables
rm(subject_test, activity_test, subject_train, activity_train)



## Step 1: Merge sets into one
data <- rbind(train, test)
dataNames <- names(data)
data <- data[order(data$subjectID),]

# Cleanup from step 1
rm(train, test)



# Step 2: Extract only mean() and std() measurements
features <- read.table("data/features.txt",
                       colClasses=c("numeric", "character"))
# We want to make sure our added columns are included in the pattern match
features <- rbind(c(NA, "subjectID"),
                  c(NA, "activity"), 
                  features)

# Get column index of every mean or std measurement (plus our added cols)
# Note: Does NOT include *-meanFreq() or angle(X, gravityMean) columns
columnsToExtract <- grep("(mean|std|subject|activity)(?!F)", features$V2, perl=T)
data <- data[,columnsToExtract]


# Step 3
activityLevels <- read.table("data/activity_labels.txt")

data$activity <- factor(data$activity)
levels(data$activity) <- activityLevels$V2

rm(activityLevels)

## Step 4
cleanedNames <- features$V2[columnsToExtract]
cleanedNames <- gsub("^t", "time", cleanedNames)
cleanedNames <- gsub("^f", "freq", cleanedNames)
cleanedNames <- gsub("\\(\\)", "", cleanedNames)
names(data) <- cleanedNames


## Step 5
tidyData <- aggregate(x=data[,3:68], by=list(data$subjectID, data$activity), FUN = mean)