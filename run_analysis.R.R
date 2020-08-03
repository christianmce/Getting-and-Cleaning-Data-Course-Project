# *** PROYECT *** #
library(dplyr)

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

X_data <- rbind(x_train, x_test)
Y_data <- rbind(y_train, y_test)
SubjectT <- rbind(subject_train, subject_test)


# 1. Merges the training and the test sets to create one data set ---------

# M_Data is a data set that contains the training and the test sets
M_Data <- cbind(SubjectT, Y_data, X_data)




# 2. Extracts only the measurements on the mean and standard devia --------

# T_Data contains a tidy data set whit only the measurements on the mean and standard deviation for each measurement
T_data <- M_Data %>% select(subject,code,contains("mean"),contains("std"))


# 3. Uses descriptive activity names to name the activities in the --------

T_data$code <- activities[T_data$code, 2]


# 4. Appropriately labels the data set with descriptive variable names --------

names(T_data)<-gsub("^t", "time", names(T_data))
names(T_data)<-gsub("^f", "frequency", names(T_data))
names(T_data)<-gsub("Acc", "Accelerometer", names(T_data))
names(T_data)<-gsub("Gyro", "Gyroscope", names(T_data))
names(T_data)<-gsub("Mag", "Magnitude", names(T_data))
names(T_data)<-gsub("BodyBody", "Body", names(T_data))
names(T_data)


# 5. From the data set in step 4, creates a second, independent ti --------

library(plyr)
final <- aggregate(.~subject+code,T_data,mean) # aggregate: Splits the data into subsets, computes summary statistics for each, and returns the result in a convenient form.
str(final)
write.table(file = "FinalData.txt",row.names = F,x=final)



