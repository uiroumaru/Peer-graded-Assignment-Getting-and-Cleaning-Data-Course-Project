## Before first step
 - Download all files from cousera website
 - Assign data to variable
 - Use "head()" and "dim()" to get overview of data
## 1st. Merges the training and the test sets to create one data set.
 - Cleate "X" that contain x_train and x_test by using rbind, which mean bind them for row direction.
 - Cleate "Y" that contain y_train and y_test by using rbind
 - Cleate "Subject" that cantains subject by using rbind
 - Merge them by using cbind, which mean bind them for colmn direction. This data is containd in "Merged_Data".
## 2nd. Extracts only the measurements on the mean and standard deviation for each measurement. 
 - Import "dplyr" package to manipulate data
 - "Tidydata" is cleated by subsetting "Merged_Data".
 - "Tidydata" only contains row that contain "mean" or "std".
## 3rd. Uses descriptive activity names to name the activities in the data set
 - "Tidydata"'s second colomn is just code.
 - To make them undestandable, I replace code with activeti's name.
## 4th. Appropriately labels the data set with descriptive variable names. 
 - Abbreviated code is used in colmn name, so it is difficult to understand.
 - To make them understandable, replace them unabbreviated
## 5th. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
- Summarized data is containd in "Final data"
- To export "Final data" at the end
