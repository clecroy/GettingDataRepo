require(dplyr)
#Run_Analysis Script

#Read in data and labels
test_data <- read.table("C:/Users/Chase/Downloads/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
test_labels <- read.table("C:/Users/Chase/Downloads/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
test_subjects <- read.table("C:/Users/Chase/Downloads/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")

test_data <- cbind(test_data, test_labels, test_subjects)

train_data <- read.table("C:/Users/Chase/Downloads/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
train_labels <- read.table("C:/Users/Chase/Downloads/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
train_subjects <- read.table("C:/Users/Chase/Downloads/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")


train_data <- cbind(train_data, train_labels, train_subjects)

#Read in column names
features <- read.table("C:/Users/Chase/Downloads/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
features <- features[,2]

#Merge data
full_data <- rbind(test_data, train_data)


#Set names
names(full_data) <- c(features, "Key", "Subjects")

#Select only means and standard deviations
variable_index <- grep("mean|std",features)
full_data <- full_data[,c(variable_index,562,563)]

#Label activities
activity_labels <- read.table("C:/Users/Chase/Downloads/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
names(activity_labels) <- c("Key", "Activity")

#Merge labels and dataset
full_data <- as.tbl(full_data)
full_data <- left_join(full_data, activity_labels, by="Key") %>% select(-80)

#Create table of averages
avg_data <- full_data %>% group_by(Activity, Subjects) 
final_data <- avg_data %>% summarize_all(mean)


                                         