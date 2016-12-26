---
title: "README"
author: "Chase LeCroy"
date: "December 25, 2016"
output: html_document
---

The script "run_analysis.R" analyzes the data described in the CodeBook. First, activity labels, subject numbers, and data are loaded into R. Each of these is bound with cbind() together to form a complete set of test data and traingin data, respectively. These two sets are then merged with rbind().

Variable labels are then read into R and assigned to the data set with the addition of the activity label "Key" name and the "Subjects" column name.

grep() is then used to find variables containing "mean" or "std". This index is used to select the variables of interest.

A left_join() was used to replace the activity labels ("Key") with the activity names.

Then, group_by() and summarize_all() were used to calculate means and standard deviations for all subjects and all activities.

A final data set produced by the code is found in "final_data.csv".

