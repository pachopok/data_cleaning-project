rm(list = ls())
require("data.table")
require("plyr")
require("dplyr")
##################
### Download and unzip all compressed files in a common folder 
##################
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","fuci.zip")
unzip("fuci.zip", exdir = "fuci", junkpaths = TRUE)
setwd("fuci")

##################
### Retrieve features in a vector, append the corresponding files from the 
### train and test directory 
##################
#put features in a vector
names <- read.delim("features.txt",header = FALSE, sep="\n")
names <- as.vector(names[,1])
names <- read.table(text=names, sep=" ", fill=TRUE)[2]
names <- as.character(names[[1]])
names <- c("SubjectId",names,"LabelId")

#append test subject ids to train subject ids
subjects_train <- fread("subject_train.txt", sep="\n", header=FALSE)
subjects_test <- fread("subject_test.txt", sep="\n", header=FALSE)
subjects_all <- c(subjects_train[[1]],subjects_test[[1]])

#append test label ids to train label ids
labels_train <-fread("y_train.txt", sep="\n", header=FALSE)
labels_test <- fread("y_test.txt",sep="\n", header=FALSE)
labels_all <- c(labels_train[[1]],labels_test[[1]])

#append test measurements to train measurements
measurements_train <- fread("X_train.txt", sep2="\n", sep=" ", header=FALSE)
measurements_test <- fread("X_test.txt", sep2="\n", sep=" ",header=FALSE)
measurements_all <- rbind(measurements_train,measurements_test)

##################
### Put the data frame together- measurements, labels, object ids and and names.
### This is the merged train and test dataset in a single table -- TASK 1
##################
theTable <- cbind(subjects_all,measurements_all,labels_all)
names(theTable) <- names

##################
### Keep on the columns, which contain either standard deviation or 
### mean values in the table -- TASK 2
##################
targetVariables <- grep("mean\\(\\)$|std\\(\\)$",names)
targetVariables <- c(1,targetVariables,length(names))
theTable <- theTable[,targetVariables, with=FALSE]

##################
### Keep on the columns, which contain either standard deviation or 
### mean values in the table -- TASK 3
##################
activities <- read.csv("activity_labels.txt",sep = " ", header = FALSE)
names(activities) <- c("LabelId","Label")
theTable <- plyr::join(theTable, activities, by ="LabelId")
theTable$LabelId <- list(NULL)

##################
### Names for the variables (TASK 4) already assigned. Make them more readable
### and remove parentheses and dash, or else summarise will give errors
##################
names <- names(theTable)
names <- gsub("-mean\\(\\)","Mean",names)
names <- gsub("-std\\(\\)","Std",names)
names <- gsub("^t|^f","",names)
names <- gsub("BodyBody","Body",names)
names(theTable) <- names

##################
### TASK 5
##################
summarizedTable <- theTable %>% dplyr::group_by(SubjectId, Label) %>% dplyr::summarise_each(funs(mean)) %>% dplyr::arrange(SubjectId,Label)
names <- names(summarizedTable)
summarizedTable <- ungroup(summarizedTable)
setwd("..")
write.table(summarizedTable, file="summarizedTable.csv",row.names=FALSE)
