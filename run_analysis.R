
# STEP 1 - Preparing the environment and downloading the data


options(warn = -1)  
library(data.table)
options(warn = 0)

# Downloading and unzipping the dataset
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "mydata.zip", method = "curl")
unzip("mydata.zip")
setwd("./UCI HAR Dataset")



# STEP 2 - Loading and labeling the datasets


# Loading subject data for training and test sets
subject_train <- read.table("./train/subject_train.txt", header = FALSE)
names(subject_train) <- "subjectID"
subject_test <- read.table("./test/subject_test.txt", header = FALSE)
names(subject_test) <- "subjectID"

# Loading activity data for training and test sets
y_train <- read.table("./train/y_train.txt", header = FALSE)
names(y_train) <- "activity"
y_test <- read.table("./test/y_test.txt", header = FALSE)
names(y_test) <- "activity"

# Loading feature names
FeatureNames <- read.table("features.txt")

# Loading feature data for training and test sets
X_train <- read.table("./train/X_train.txt", header = FALSE)
names(X_train) <- FeatureNames$V2
X_test <- read.table("./test/X_test.txt", header = FALSE)
names(X_test) <- FeatureNames$V2



# STEP 3 - Combining training and test datasets


# Merging subject, activity, and feature data
train <- cbind(subject_train, y_train, X_train)
test <- cbind(subject_test, y_test, X_test)
alldata <- rbind(train, test)

# Extracting only the columns related to mean and standard deviation
meancol <- alldata[, grep('mean()', names(alldata), fixed = TRUE)]
stdcol <- alldata[, grep('std()', names(alldata), fixed = TRUE)]
keycol <- alldata[, 1:2]
meanstd_data <- cbind(keycol, meancol, stdcol)

# Loading activity labels and encoding activity data
actlbl <- read.table("activity_labels.txt")
alldata$activity <- factor(alldata$activity, labels = actlbl$V2)



# STEP 4 - Renaming variables with descriptive names


# Replacing shorthand with descriptive labels
names(alldata) <- gsub("tBody", "TimeDomainBody", names(alldata), fixed = TRUE)
names(alldata) <- gsub("tGravity", "TimeDomainGravity", names(alldata), fixed = TRUE)
names(alldata) <- gsub("fBody", "FrequencyDomainBody", names(alldata), fixed = TRUE)
names(alldata) <- gsub("Acc", "Acceleration", names(alldata), fixed = TRUE)
names(alldata) <- gsub("Gyro", "AngularVelocity", names(alldata), fixed = TRUE)
names(alldata) <- gsub("-XYZ", "3AxialSignals", names(alldata), fixed = TRUE)
names(alldata) <- gsub("-X", "XAxis", names(alldata), fixed = TRUE)
names(alldata) <- gsub("-Y", "YAxis", names(alldata), fixed = TRUE)
names(alldata) <- gsub("-Z", "ZAxis", names(alldata), fixed = TRUE)
names(alldata) <- gsub("Mag", "MagnitudeSignals", names(alldata), fixed = TRUE)
names(alldata) <- gsub("-mean()", "MeanValue", names(alldata), fixed = TRUE)
names(alldata) <- gsub("-std()", "StandardDeviation", names(alldata), fixed = TRUE)
names(alldata) <- gsub("-mad()", "MedianAbsoluteDeviation", names(alldata), fixed = TRUE)
names(alldata) <- gsub("-max()", "LargestValueInArray", names(alldata), fixed = TRUE)
names(alldata) <- gsub("-min()", "SmallestValueInArray", names(alldata), fixed = TRUE)
names(alldata) <- gsub("-sma()", "SignalMagnitudeArea", names(alldata), fixed = TRUE)
names(alldata) <- gsub("-energy()", "EnergyMeasure", names(alldata), fixed = TRUE)
names(alldata) <- gsub("-iqr()", "InterquartileRange", names(alldata), fixed = TRUE)
names(alldata) <- gsub("-entropy()", "SignalEntropy", names(alldata), fixed = TRUE)
names(alldata) <- gsub("-arCoeff()", "AutoRegressionCoefficientsWithBurgOrderEqualTo4", names(alldata), fixed = TRUE)
names(alldata) <- gsub("-correlation()", "CorrelationCoefficient", names(alldata), fixed = TRUE)
names(alldata) <- gsub("-maxInds()", "IndexOfFrequencyComponentWithLargestMagnitude", names(alldata), fixed = TRUE)
names(alldata) <- gsub("-meanFreq()", "WeightedAverageOfFrequencyComponentsForMeanFrequency", names(alldata), fixed = TRUE)
names(alldata) <- gsub("-skewness()", "Skewness", names(alldata), fixed = TRUE)
names(alldata) <- gsub("-kurtosis()", "Kurtosis", names(alldata), fixed = TRUE)
names(alldata) <- gsub("-bandsEnergy()", "EnergyOfFrequencyInterval", names(alldata), fixed = TRUE)



# STEP 5 - Creating and saving the tidy dataset

# Calculating mean for each combination of activity and subject
DT <- data.table(alldata)
tidy <- DT[, lapply(.SD, mean), by = "activity,subjectID"]

# Saving the tidy dataset to a file
write.table(tidy, file = "TidyData.txt", row.name = FALSE, col.names = TRUE)

# Cleanup
print("The script 'run_analysis.R' was executed successfully. The file 'TidyData.txt' has been saved in the working directory, inside the folder 'UCI HAR Dataset'.")
rm(list = ls())
