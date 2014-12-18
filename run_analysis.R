## Preparatory work: Loading data 
test <- read.table("data/test/X_test.txt")
subject_test <- read.table("data/test/subject_test.txt")
activity_test <- read.table("data/test/y_test.txt")
test <- cbind(subject_test, activity_test, test)

train <- read.table("data/train/X_train.txt")
subject_train <- read.table("data/train/subject_train.txt")
activity_train <- read.table("data/train/y_train.txt")
train <- cbind(subject_train, activity_train, train)

# Cleanup temp variables
rm(subject_test, activity_test, subject_train, activity_train)



## Step 1: Merge sets into one
data <- rbind(train, test)

# Cleanup from step 1
rm(train, test)



# Step 2: Extract only mean() and std() measurements
features <- read.table("data/features.txt",
                       colClasses=c("numeric", "character"))
# We want to make sure our added columns are included in the pattern match
features <- rbind(c(NA, "subjectID-not-std"),
                  c(NA, "activity-not-std"), 
                  features)

# Get column index of every mean or std measurement (plus our added cols)
# Note: Does NOT include *-meanFreq() or angle(X, gravityMean) columns
columnsToExtract <- grep("(mean|std)(?!F)", features$V2, perl=T)
data <- data[,columnsToExtract]


# Step 3 or something
activityLevels <- read.table("data/activity_labels.txt")



## Step 4?
names(data) <- c("subject", features$V2)


