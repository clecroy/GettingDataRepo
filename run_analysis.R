require(dplyr)
#Run_Analysis Script

#Read in data and labels
test_data <- read.table("test/X_test.txt")
test_labels <- read.table("test/y_test.txt")
test_subjects <- read.table("test/subject_test.txt")

test_data <- cbind(test_data, test_labels, test_subjects)

train_data <- read.table("train/X_train.txt")
train_labels <- read.table("train/y_train.txt")
train_subjects <- read.table("train/subject_train.txt")


train_data <- cbind(train_data, train_labels, train_subjects)
#Merge data
full_data <- rbind(test_data, train_data)

#Read in column names
features <- read.table("features.txt", stringsAsFactors = FALSE)
features <- features[,2]

#Set names
names(full_data) <- c(features, "Key", "Subjects")

#Select only means and standard deviations
variable_index <- grep("mean|std",features)
full_data <- full_data[,c(variable_index,562,563)]

#Label activities
activity_labels <- read.table("Cactivity_labels.txt")
names(activity_labels) <- c("Key", "Activity")

#Merge labels and dataset
full_data <- as.tbl(full_data)
full_data <- left_join(full_data, activity_labels, by="Key") %>% select(-80)

#Create table of averages
avg_data <- full_data %>% group_by(Activity, Subjects) 
final_data <- avg_data %>% summarize_all(mean)


                                         