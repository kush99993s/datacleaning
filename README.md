First 6 lines read the files related to test. File name is given to variables for ease of reading and understanding. 
In line 9, all test files are merged. In line 11-16, all extra files are removed from memory. 

Same process is done for train files. Once train files are combined, testTrainFile data frame is created using rbind command. Extra files are removed from memory. 

In line 43, feature file is converted to data set. Once data set is created, heading are extracted in xHeading data frame. Extra files are removed from memory. Heading for subject and Class activity is created, and merge all three files to create finalHeading data frame. Extra files are removed from memory. 

In lines 80-94, loop is created to provide heading to testTrainFile data frame. Extra files are removed from memory. 

Once testTrainFile has heading, line 97 file is written. 

In line 100-124, using if command, activity names put in place of the activities number in the data set

In line 132, new file is written with description of activity name.

New data frame is created for average of each column and file. 

In line 138-154, using loop command, mean and standard deviation of each column is created and put in first and second row dataFrameForAverage data frame. In addition, project summary file is also written which contain just overall mean, and standard deviation of data.

In line 157-180, using for loop command, calculated average of each variable for each activity and put proper location and order (3-8 rows, alphabetical order of activity.) in dataFrameForAverage data frame

Similarly, in line 182-205, using for loop command, calculated average of each variable for each subject, and put proper location and order (9-38 rows, ascending order of subject.) in dataFrameForAverage data frame.

In 208- 253 lines, using multiple for loop and if command,calcuated average of each variable for each subject and activity, and put proper location and order(39-218 rows, ascending order of subject and alphabetical order of activity .) in dataFrameForAverage data frame. Subject is outer loop, activity is inner loop of subject.

In 255-274, proper row information for activity in dataFrameForAvereage added

In 278 final tidy dataset with overall mean, standard deviation, average of each variable for each activity, average of each variable for each subject, and average of each variable for combination of average of each variable for each activity and subject it.
