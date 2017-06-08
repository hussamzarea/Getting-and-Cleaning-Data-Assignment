### Download the data using he URL provided with the assignment 
### Read the following data:
* X_test.txt
1.test1 <- read.table("C:/Users/hzarea/Desktop/Getting and Cleaning Data/UCI HAR Dataset/test/X_test.txt")
* Y_test.txt
test2 <- read.table("C:/Users/hzarea/Desktop/Getting and Cleaning Data/UCI HAR Dataset/test/Y_test.txt")
* Subject_test.txt
SubTest <- read.table("C:/Users/hzarea/Desktop/Getting and Cleaning Data/UCI HAR Dataset/test/subject_test.txt")
* X_train.txt
train1 <- read.table("C:/Users/hzarea/Desktop/Getting and Cleaning Data/UCI HAR Dataset/train/X_train.txt")
* Y_train.txt
train2 <- read.table("C:/Users/hzarea/Desktop/Getting and Cleaning Data/UCI HAR Dataset/train/Y_train.txt")
* Subject_train.txt
SubTrain <- read.table("C:/Users/hzarea/Desktop/Getting and Cleaning Data/UCI HAR Dataset/train/subject_train.txt")

### Read the data description from the features.txt data
variableNames <- read.table("C:/Users/hzarea/Desktop/Getting and Cleaning Data/UCI HAR Dataset/features.txt")
### Read the activity labels from activity_label.txt data
activityLabels <- read.table("C:/Users/hzarea/Desktop/Getting and Cleaning Data/UCI HAR Dataset/activity_labels.txt")
### Merged the training and the test set to create one data set
total1 <- rbind(train1, test1)
total2 <- rbind(train2, test2)
SubTotal <- rbind(SubTrain, SubTest)

### Extracted only the measurements on the mean and the standard deviation for each measurement
selectedVariable <- variableNames[grep("mean\\(\\)|std\\(\\)",variableNames[,2]),]
total1 <- total1[,selected_variable[,1]]

### Used the descriptive activity names to name the activities in the data set
colnames(total2) <- "activity"
total2$activitylabel <- factor(total2$activity, labels = as.character(activityLabels[,2]))
activitylabel <- total2[,-1]

### Appropriately labeled the data set with the descriptive variables names
colnames(total1) <- variableNames[selectedVariable[,1],2]

### From the data set in the appropriately labels crated a second independent tidy data set with the average of each variable for each activity and each subject
colnames(SubTotal) <- "subject"
total <- cbind(total1, activitylabel, SubTotal)
totalMean <- total %>% group_by(activitylabel, subject) %>% summarize_each(funs(mean))
write.table(totalMean, file = "C:/Users/hzarea/Desktop/Getting and Cleaning Data/UCI HAR Dataset/tidydata.txt", row.names = FALSE, col.names = TRUE)

