# reading subject_test file #
subjectTestFile <- read.table("subject_test.txt")
# reading x_test file #
xTestFile <- read.table("X_test.txt")
# reading y_test file #
yTestFile <- read.table("y_test.txt")

#combining three file by column#
combineTestFile<- cbind(subjectTestFile,xTestFile,yTestFile)

# removing subject_test file #
remove(subjectTestFile)
# removing x_test file #
remove(xTestFile)
# removing y_test file #
remove(yTestFile)

# reading subject_train file #
subjectTrainFile <- read.table("subject_train.txt")
# reading x_train file #
xTrainFile <- read.table("X_train.txt")
# reading y_train file #
yTrainFile <- read.table("y_train.txt")

#combining three file by column#
combineTrainFile<- cbind(subjectTrainFile,xTrainFile,yTrainFile)

# removing subject_train file #
remove(subjectTrainFile)
# removing x_train file #
remove(xTrainFile)
# removing y_train file #
remove(yTrainFile)

# row binding test and train file #
testTrainFile<- rbind(combineTestFile,combineTrainFile)

# remove extra files #
remove(combineTestFile)
remove(combineTrainFile)

#reading feature file which contain heading for file#
feactureFile<- read.table("features.txt")

# seperating title names from file#
xHeadings<- as.vector(feactureFile[2])

#remove features.txt from memory# 
remove(feactureFile)

# creating title for subject and Class Label column #
subjectHeading<- c("subject")
yHeading<- c("ClassLabel")

# converting vector in to data frame#
subjectHeadingFrame<- data.frame(subjectHeading)

#removing extra vector#
remove(subjectHeading)

# converting vector into data frame #
yHeadingFrame<- data.frame(yHeading)

#removing vector #
remove(yHeading)

# giving column name to data frame #
colnames(subjectHeadingFrame)<- c("V2")
colnames(yHeadingFrame)<- c("V2")

# combing in same order as coming column in data frame testTrainFile#
finalHeading<-rbind(subjectHeadingFrame,xHeadings,yHeadingFrame)

# removing extra data frame #
remove(subjectHeadingFrame)
remove(xHeadings)
remove(yHeadingFrame)

#create xx and yy for loop #
Loop<-1
maximumLoop<-nrow(finalHeading)

# for loop to give titles to the table
for (Loop in 1:maximumLoop){
    #colnames(i)[xx] where i is data frame and xx is column number
    # paste is used to transfer complete name rather than character or number
    colnames(testTrainFile)[Loop]<- paste(finalHeading$V2[Loop])
    
    Loop = Loop+1
}

# removing xx and yy from memory 
remove(Loop)
remove(maximumLoop)

# writing file for project
write.table(testTrainFile,"./project.txt", row.names = F)
# testTrainFile1<- data.frame(testTrainFile)

Loop<-1
maximumLoop<-nrow(testTrainFile)

# for loop to give switching activity
for (Loop in 1:maximumLoop){
    if (testTrainFile[Loop,563] == 1){
        testTrainFile[Loop,563]<- c("Walking")
    }
    else if (testTrainFile[Loop,563] == 2){
        testTrainFile[Loop,563]<- c("Walking Upstairs")
    }
    else if (testTrainFile[Loop,563] == 3){
        testTrainFile[Loop,563]<- c("Walking Downstairs")
    }
    else if (testTrainFile[Loop,563] == 4){
        testTrainFile[Loop,563]<- c("Sitting")
    }
    else if (testTrainFile[Loop,563] == 5){
        testTrainFile[Loop,563]<- c("Standing")
    }
    else if (testTrainFile[Loop,563] == 6){
        testTrainFile[Loop,563]<- c("Laying")
    }
    Loop = Loop +1
}

# removing xx and yy from memory 
remove(Loop)
remove(maximumLoop)


# writing file for project
write.table(testTrainFile,"./project1.txt", row.names = F)

#creating file for summary of file
dataFrameForAverage<-data.frame(testTrainFile)[1,]



Loop<-1
maximumLoop<-nrow(finalHeading)-1

# for loop for calcuating Mean and SD
for (Loop in 1:maximumLoop){
    dataFrameForAverage[1,Loop]<-mean(testTrainFile[,Loop][1:10299])
        dataFrameForAverage[2,Loop]<-sd(testTrainFile[,Loop][1:10299])
    Loop = Loop +1
}

# writing file for project summary
write.table(dataFrameForAverage,"./projectsummary.txt", row.names = F)

# removing xx and yy from memory 
remove(Loop)
remove(maximumLoop)

# creating loop to calcuate average for each activity
Loop<-1
maximumLoop<-nrow(finalHeading)-1

for (Loop in 1:maximumLoop){
    meanClassLable<-tapply(testTrainFile[,Loop],testTrainFile$ClassLabel,mean)
    
    Loop1<-1
    
    Position1<- 3 
    maximumLoop1<-nrow(meanClassLable)
    for(Loop1 in 1:maximumLoop1){
        dataFrameForAverage[Position1,Loop]<-meanClassLable[Loop1]
        Position1 = Position1  +1
        Loop1 = Loop1 +1
    }
    remove(Loop1)
    remove(Position1)
    remove(maximumLoop1)
    remove(meanClassLable)
    Loop = Loop +1
}
remove(Loop)
remove(maximumLoop)

# creating loop to calcuate avereage for each subject
Loop<-1
maximumLoop<-nrow(finalHeading)-1

for (Loop in 1:maximumLoop){
    meanClassLable<-tapply(testTrainFile[,Loop],testTrainFile$subject,mean)
    
    Loop1<-1
    
    Position1<- 9 
    maximumLoop1<-nrow(meanClassLable)
    for(Loop1 in 1:maximumLoop1){
        dataFrameForAverage[Position1,Loop]<-meanClassLable[Loop1]
        Position1 = Position1  +1
        Loop1 = Loop1 +1
    }
    remove(Loop1)
    remove(Position1)
    remove(maximumLoop1)
    remove(meanClassLable)
    Loop = Loop +1
}
remove(Loop)
remove(maximumLoop)
remove(finalHeading)


# creating loop to calcuate average for each subject and Activity combination
UniqueSuject<-1
maximumLoop<-max(as.numeric(sort(unique(testTrainFile$subject))))


for (UniqueSuject in 1:maximumLoop){
    
    temperaryDataSet<-subset(testTrainFile, subject == UniqueSuject)
    
    ColNum<-1
    maximumLoop1<-ncol(testTrainFile)-1
    Position1<- rep(nrow(dataFrameForAverage)+1, times= ncol(dataFrameForAverage))
    
    
    for (ColNum in 1:maximumLoop1){
        
        
        meanClassLable<-tapply(temperaryDataSet[,ColNum],temperaryDataSet$ClassLabel,mean)
       
        
        MeanClassRowNumber<-1
        
        
        maximumLoop2<-nrow(meanClassLable)
        for(MeanClassRowNumber in 1:maximumLoop2){
            dataFrameForAverage[Position1[ColNum],ColNum]<-meanClassLable[MeanClassRowNumber]
            Position1[ColNum] = Position1[ColNum]  +1
            MeanClassRowNumber = MeanClassRowNumber +1
        }
        remove(MeanClassRowNumber)
        remove(maximumLoop2)
        
        
    }
    remove(ColNum)
    remove(maximumLoop1)

    remove(temperaryDataSet)

    UniqueSuject <- UniqueSuject + 1
}
remove(UniqueSuject)
remove(maximumLoop)
remove(testTrainFile)
remove(Position1)
remove(meanClassLable)

headingOfClassActivity<-c("Laying","Sitting", "Standing", "Walking","Walking Downstairs", "Walking Upstairs")
halfCompleteListOfHeadingOfClassActivity<-rep(headingOfClassActivity,times=30)
headingForFirst<- c("-", "-","Laying","Sitting", "Standing", "Walking","Walking Downstairs", "Walking Upstairs")
headinForSubject<- rep("-", times =30)      
completeListOfHeadingOfClassActivity<- c(headingForFirst,headinForSubject,halfCompleteListOfHeadingOfClassActivity)
remove(headingOfClassActivity)
remove(halfCompleteListOfHeadingOfClassActivity)
remove(headingForFirst)
remove(headinForSubject)

numberOfrow<- 1
maximumNumberOfRow<- nrow(dataFrameForAverage)
for(numberOfrow in 1:maximumNumberOfRow ){
    dataFrameForAverage[numberOfrow,563]<- completeListOfHeadingOfClassActivity[numberOfrow]
    numberOfrow = numberOfrow +1
}
    
remove(numberOfrow)
remove(maximumNumberOfRow)
remove(completeListOfHeadingOfClassActivity)


# writing file for project summary
write.table(dataFrameForAverage,"./projectsummary1.txt", row.names = F)