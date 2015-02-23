sub_test = read.table("UCI HAR Dataset/test/subject_test.txt")
X_test = read.table("UCI HAR Dataset/test/X_test.txt")
Y_test = read.table("UCI HAR Dataset/test/Y_test.txt")
sub_train = read.table("UCI HAR Dataset/train/subject_train.txt")
X_train = read.table("UCI HAR Dataset/train/X_train.txt")
Y_train = read.table("UCI HAR Dataset/train/Y_train.txt")

X_join <- rbind(X_test, X_train)
y_join <- rbind(Y_test, Y_train)
sub_join <- rbind(sub_train, sub_test)

features <- read.table("UCI HAR Dataset/features.txt", col.names=c("featId", "featLab"))
SelectFeat <- grep("-mean\\(\\)|-std\\(\\)", features$featLab)
X_join <- X_join[, SelectFeat]
names(X_join) <- gsub("\\(|\\)", "", features$featLab[SelectFeat])

activity <- read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("actId", "actLab"))
activity$actLab <- gsub("_", "", as.character(activity$actLab))
names(y_join) = "actId"
activity <- merge(y_join, activity, by = "actId")$actLab

TidyData1 <- cbind(sub_join, y_join, X_join)
write.table(TidyData1, "merged_data.txt")
