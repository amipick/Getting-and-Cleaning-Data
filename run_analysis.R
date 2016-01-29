setwd("~/R_programming/data cleaning/ASS/UCI HAR Dataset")
# load data
library(data.table)
x_train <- read.table("./train/X_train.txt",header=FALSE)
x_test <- read.table("./test/X_test.txt",header=FALSE)
y_train <- read.table("./train/y_train.txt",header=FALSE)
y_test <- read.table("./test/y_test.txt",header=FALSE)
sbj_train <- read.table("./train/subject_train.txt",header=FALSE)
sbj_test <- read.table("./test/subject_test.txt",header=FALSE)
features <- read.table("./features.txt", header =FALSE)
activity_name <- read.table("./activity_labels.txt", header = FALSE)
colnames(x_train)<-features$V2
colnames(x_test)<-features$V2
colnames(y_train)<-"activity"
colnames(y_test)<-"activity"
colnames(sbj_train)<-"subject"
colnames(sbj_test)<-"subject"
colnames(activity_name) <- c("activity", "activityName")
# 1. Merges the training and the test sets to create one data set.
test_data <- cbind(x_test,y_test,sbj_test)
train_data <-cbind(x_train,y_train,sbj_train)
data <- rbind(test_data,train_data)
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
library(dplyr)
data <- data[, !duplicated(colnames(data))]
data <- select(data, subject,activity,contains("mean()"), contains("std()"))
# 3. Uses descriptive activity names to name the activities in the data set
library(plyr)
data <- arrange(join(activity_name,data), activity)
data$activityName <- as.character(data$activityName)
# 4. Appropriately labels the data set with descriptive variable names
names(data)<-gsub("std()", "SD", names(data))
names(data)<-gsub("mean()", "MEAN", names(data))
names(data)<-gsub("^t", "time", names(data))
names(data)<-gsub("^f", "frequency", names(data))
names(data)<-gsub("Acc", "Accelerometer", names(data))
names(data)<-gsub("Gyro", "Gyroscope", names(data))
names(data)<-gsub("Mag", "Magnitude", names(data))
names(data)<-gsub("BodyBody", "Body", names(data))
# 5. From the data set in step 4, 
# creates a second, independent tidy data set with the average of each variable for each activity and each subject.
TidyData <-  aggregate(. ~ subject - activityName, data = data, mean)
#write file to directory
write.table(TidyData, "TidyData.txt", row.name=FALSE)




