#implementation of the 'plyr' package

require(plyr)

#paste the necessary data sets with comma separated values into a respective reference variable

trainFileX<-paste('UCI HAR Dataset/train/X_train.txt', sep = " ")
trainFileY<-paste('UCI HAR Dataset/train/y_train.txt', sep = " ")

testFileX<-paste('UCI HAR Dataset/test/X_test.txt', sep = " ")
testFileY<-paste('UCI HAR Dataset/test/y_test.txt', sep = " ")


trainSubjectFile<-paste('UCI HAR Dataset/train/subject_train.txt', sep = " ")
testSubjectFile<-paste('UCI HAR Dataset/test/subject_test.txt', sep = " ")

activityLabelsFile<-paste('UCI HAR Dataset/activity_labels.txt', sep = " ")
featuresFile<-paste('UCI HAR Dataset/features.txt', sep = " ")

#reads file data into table format and assigns to a corresponding variable

features <- read.table(featuresFile, colClasses = c("character"))
activityLabels <- read.table(activityLabelsFile, col.names = c("ActivityId", "Activity"))
trainX <- read.table(trainFileX)
trainY <- read.table(trainFileY)
trainSubject <- read.table(trainSubjectFile)
testX <- read.table(testFileX)
testY <- read.table(testFileY)
testSubject <- read.table(testSubjectFile)

#combines the columns in train data

trainingSensorData <- cbind(cbind(trainX, trainSubject), trainY)

#combines the columns in test data

testSensorData <- cbind(cbind(testX, testSubject), testY)

#combines the rows of training and test data under one variable

sensorData <- rbind(trainingSensorData, testSensorData)


#Labels the columns under 'Subject' and 'ActivityId'

sensorLabels <- rbind(rbind(features, c(562, "Subject")), c(563, "ActivityId"))[,2]
names(sensorData) <- sensorLabels

#grepl returns a logical vector to return only the mean and standard deviation of the
#corresponding subject and ActivityId

sensorDataMeanStd <- sensorData[,grepl("mean|std|Subject|ActivityId", names(sensorData))]

#Activity Labels

sensorDataMeanStd <- join(sensorDataMeanStd, activityLabels, by = "ActivityId", match = "first")
sensorDataMeanStd <- sensorDataMeanStd[,-1]


#gsub() function replaces all matches of a string. Here it rids the data set 'sensorDataMeanStd' of numerous
#symbols for a cleaner look

names(sensorDataMeanStd) <- gsub('\\(|\\)',"",names(sensorDataMeanStd), perl = TRUE)

#make.names() makes syntactically valid names out of character vectors

names(sensorDataMeanStd) <- make.names(names(sensorDataMeanStd))


#Clarifies the names of the Sensor Data

names(sensorDataMeanStd) <- gsub('Acc',"Acceleration",names(sensorDataMeanStd))
names(sensorDataMeanStd) <- gsub('GyroJerk',"AngularAcceleration",names(sensorDataMeanStd))
names(sensorDataMeanStd) <- gsub('Gyro',"AngularSpeed",names(sensorDataMeanStd))
names(sensorDataMeanStd) <- gsub('Mag',"Magnitude",names(sensorDataMeanStd))
names(sensorDataMeanStd) <- gsub('^t',"TimeDomain.",names(sensorDataMeanStd))
names(sensorDataMeanStd) <- gsub('^f',"FrequencyDomain.",names(sensorDataMeanStd))
names(sensorDataMeanStd) <- gsub('\\.mean',".Mean",names(sensorDataMeanStd))
names(sensorDataMeanStd) <- gsub('\\.std',".StandardDeviation",names(sensorDataMeanStd))
names(sensorDataMeanStd) <- gsub('Freq\\.',"Frequency.",names(sensorDataMeanStd))
names(sensorDataMeanStd) <- gsub('Freq$',"Frequency",names(sensorDataMeanStd))

#extraction of the mean with a vector 'Subject' & 'Activity' from the sensorDataMeanStd; assigned a variable

TidyData = ddply(sensorDataMeanStd, c("Subject","Activity"), numcolwise(mean))

#writes the 'TidyData' in table format then exports to a text file within the working directory

write.table(TidyData, file = "TidyData.txt",row.name=FALSE)




