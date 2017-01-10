
# if file doesn't exist in WD then download it
myURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists("getdata_projectfiles_UCI HAR Dataset.zip")) {
  download.file(myURL, "getdata_projectfiles_UCI HAR Dataset.zip")}

# get list of files in the zip archiev
filelist.of.archiev <- c(unzip("getdata_projectfiles_UCI HAR Dataset.zip", list = T)[, 1])

# choose files for the future dataset
zipfiles.for.dataset <- filelist.of.archiev[c(16, 17, 18, 30, 31, 32)]

# get col. names for X_train and X_test and descriptive activity names
labes.for.dataset <- read.table(unz("getdata_projectfiles_UCI HAR Dataset.zip", filelist.of.archiev[2]))[,2]

activity.names <- read.table(unz("getdata_projectfiles_UCI HAR Dataset.zip", filelist.of.archiev[1]))
names(activity.names) <- c("activity_N", "activity_Name")

# read txt files to certain variables
subject_test    <- read.table(unz("getdata_projectfiles_UCI HAR Dataset.zip", zipfiles.for.dataset[1]))
X_test          <- read.table(unz("getdata_projectfiles_UCI HAR Dataset.zip", zipfiles.for.dataset[2]))
y_test          <- read.table(unz("getdata_projectfiles_UCI HAR Dataset.zip", zipfiles.for.dataset[3]))
subject_train   <- read.table(unz("getdata_projectfiles_UCI HAR Dataset.zip", zipfiles.for.dataset[4]))
X_train         <- read.table(unz("getdata_projectfiles_UCI HAR Dataset.zip", zipfiles.for.dataset[5]))
y_train         <- read.table(unz("getdata_projectfiles_UCI HAR Dataset.zip", zipfiles.for.dataset[6]))

# add labesl to X_train and X_test
names(X_test) <- labes.for.dataset
names(X_train) <- labes.for.dataset

# choose needed columns (mean and std)
mean_and_std_col <- grepl("Mean|Std|[Mm]ean()|[Ss]td", names(X_train))

X_train <- X_train[, mean_and_std_col]
X_test <- X_test[, mean_and_std_col]

# merge all datasets in one main
main_database <- rbind(cbind(y_train, subject_train, X_train), cbind(y_test, subject_test, X_test))

# change names for col-s from "subject" and "y" datasets
names(main_database)[1:2] <- c("activity_N", "person_N")

# add descriptive activity_Names to y_test and y_train
main_database <- merge(main_database, activity.names, by = "activity_N", sort = F)

# reshape dataset (move activity.name to the front and remove activity_N)
main_database <- main_database[, c(ncol(main_database), 2:(ncol(main_database)-1))]

# make summary dataset with dplyr

library(dplyr)
main_database_mean_by_group <- main_database %>% group_by(activity_Name, person_N) %>% summarise_each(funs(mean))
write.table(main_database_mean_by_group, "tidy_data.txt", row.names = FALSE)
