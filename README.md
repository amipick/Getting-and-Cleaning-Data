# Getting-and-Cleaning-Data
The code assume you have dowloaded the data, unziped it and set you working directory to the unziped folder "UCI HAR Dataset".
First we read the data into differnt data frames. and adding some columns names so it will be easy to read.
to merge the data I used Cbind on the test tables (i.e. x,y,subjuct) as well as on the train tables. then I used Rbind to union both.
to be able to select only columns that contains "mean" or "std" I had to make sure I don't have duplicate columns once this was done I've selected the columns I needed.
changed the names on the mesurments columns so they will be readable using gsub function.
and Finally I've created the summarized data set with average data per subject per activity.

Originaly I had 10299 rows by 68 columns after the tidy process I was left with 180 rows and 69 columns (adding the description of the activity).
the output of this code will be writen to your working directory as "TidyData.txt"
