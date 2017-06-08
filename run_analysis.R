library(dplyr)

# get the train data
train1 <- read.table("C:/Users/hzarea/Desktop/Getting and Cleaning Data/UCI HAR Dataset/train/X_train.txt")
train2 <- read.table("C:/Users/hzarea/Desktop/Getting and Cleaning Data/UCI HAR Dataset/train/Y_train.txt")
SubTrain <- read.table("C:/Users/hzarea/Desktop/Getting and Cleaning Data/UCI HAR Dataset/train/subject_train.txt")

# get the test data
test1 <- read.table("C:/Users/hzarea/Desktop/Getting and Cleaning Data/UCI HAR Dataset/test/X_test.txt")
test2 <- read.table("C:/Users/hzarea/Desktop/Getting and Cleaning Data/UCI HAR Dataset/test/Y_test.txt")
SubTest <- read.table("C:/Users/hzarea/Desktop/Getting and Cleaning Data/UCI HAR Dataset/test/subject_test.txt")

# get the data description
variableNames <- read.table("C:/Users/hzarea/Desktop/Getting and Cleaning Data/UCI HAR Dataset/features.txt")

# get the activity labels
activityLabels <- read.table("C:/Users/hzarea/Desktop/Getting and Cleaning Data/UCI HAR Dataset/activity_labels.txt")

# 1. Merges the training and the test sets to create one data set.
total1 <- rbind(train1, test1)
total2 <- rbind(train2, test2)
SubTotal <- rbind(SubTrain, SubTest)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
selectedVariable <- variableNames[grep("mean\\(\\)|std\\(\\)",variableNames[,2]),]
total1 <- total1[,selected_variable[,1]]

# 3. Uses descriptive activity names to name the activities in the data set
colnames(total2) <- "activity"
total2$activitylabel <- factor(total2$activity, labels = as.character(activityLabels[,2]))
activitylabel <- total2[,-1]

# 4. Appropriately labels the data set with descriptive variable names.
colnames(total1) <- variableNames[selectedVariable[,1],2]

# 5. From the data set in step 4, creates a second, independent tidy data set with the average
# of each variable for each activity and each subject.
colnames(SubTotal) <- "subject"
total <- cbind(total1, activitylabel, SubTotal)
totalMean <- total %>% group_by(activitylabel, subject) %>% summarize_each(funs(mean))
write.table(totalMean, file = "C:/Users/hzarea/Desktop/Getting and Cleaning Data/UCI HAR Dataset/tidydata.txt", row.names = FALSE, col.names = TRUE)