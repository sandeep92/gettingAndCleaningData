This repo contains R code for the Coursera - Getting and Cleaning Data's projcet. The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. It also contains a CodeBook for the created tidy dataset.

The data for this project represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The run_analysis.R does the following:
1 - Merges the training and the test sets to create one data set.
2 - Extracts only the measurements on the mean and standard deviation for each measurement.
3 - Uses descriptive activity names to name the activities in the data set
4 - Appropriately labels the data set with descriptive variable names.
5 - Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Obtaining the project's dataset:

The data can be downloaded automatically from within the run_analysis.R, or manually from the link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Required R packages:

The script run_analysis.R requires to packages: data.table and reshape2. These can be installed directly from CRAN by executing:

install.packages("data.table")
install.packages("reshape2")

Runing the R Script:

1 - In RStudio (or any other editor) set your working directory (the folder where the R script run_analysis.R file is saved).
2 - Execute the first lines of code to download the dataset and unzip it automatically. Please note you need to have the programe WinRAR. Alternatively, you can skip these lines, and download the dataset and unzip it manually in your working directory using your program of choice.
3 - Execute the remaining lines of code to perform the required tasks.

The output of R Script:

Running the script run_analysis.R produces a tab-delimited text file tidy_data.txt, which contains a second, independent tidy data set with the average of each variable for each activity and each subject. Complete discription of the tidy dataset is provided in the CodeBook.md file.
