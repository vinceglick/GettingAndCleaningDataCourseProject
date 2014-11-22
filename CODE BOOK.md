<p><b>Data Set Information:</b></p>
<p>"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain."</p>
  <p><i>Data Source: <a href = "http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones">http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones </a></i></p>
  
<p><b>Dataset Files Required From Source:</b></p>
<ul style="list-style-type:square">
  <li>train/X_train.txt <i>(Training Data)</i></li>
  <li>train/y_train.txt <i>(Training Labels)</i></li>
  <li>test/X_test.txt <i>(Test Data)</i></li>
  <li>test/y_test.txt <i>(Test Labels)</i></li>
  <li>activity_labels.txt <i>(Connects the Class Labels with their corresponding Activity Names)</i></li>
  <li>features.txt <i>(Features List for the Dataset)</i></li>
  <li>features_info.txt <i>(Features Code Book)</i></li>
  <li>README.txt <i>(Information of the contents of each file and the dataset as a whole)</i></li>
</ul>

<p><b>Data Transformation:</b></p>

<ol type="1">

   <li><i>Packages Required:</i></li>
    <ol type="a">
      <li>'plyr' package</li>
    </ol>
    
  <li><i>Merging The Training and Test Data:</i></li>
    <ol type="a">
      <li>paste() necessary data sets with comma separated values into a respective reference variable</li>
      <li>read.table() reference variables of dataset files from the previous step and assign to a new reference variable</li>
      <li>cbind() columns in both the training and test data separately</li> 
      <li>rbind the sets from the cbind() in the previous step</li>
      <li>Label the columns under 'Subject' and 'ActivityId' using the 'features' <i>(UCI HAR Dataset/features.txt)</i>reference         variable</li>
    </ol>
  
  <li><i>Separate the Mean and Standard Deviation from the Dataset:</i></li>
    <ol type="a">
      <li>Use grepl() to return a logical vector to rextract only the mean and standard deviation of the
        corresponding Subject and ActivityId</li>
    </ol>
  
  <li><i>Apply Descriptive Activity Names to Dataset:</i></li>
    <ol type="a">
      <li>Add a column to the 'sensorDataMeanStd' dataset and use join() to match/insert the Activity Names by ActivityId</li>
    </ol>
  <li><i>Label Dataset with Descriptive Variables:</i></li>
  <ol type="a">
      <li>Use make.names() create syntactically valid names out of character vectors in the 'sensorDataMeanStd' dataset</li>
      <li>Use gsub() to clarify and repeated pattern from the reference( in this case it is 'names(sensorDataMeanStd)')</li>
    </ol>
  
  <li><i>Create Tidy Data Set (average of each variable for each activity and subject):</i></li>
   <ol type="a">
      <li>Tidy Data Reference Variable gets the extraction of the mean with a vector 'Subject' & 'Activity' from the sensorDataMeanStd (using 'numcolwise(mean)' within 'ddply()')</li>
      <li>use write.table() for 'TidyData' to convert into table format, then export to a text file within the working directory</li>
      <li>17 signals are directed to their corresponding reference Activity Nameswith '.XYZ' representing those values measured upon axes as follows:

     
<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;border-color:#999;}
.tg td{font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:0px;overflow:hidden;word-break:normal;border-color:#999;color:#444;background-color:#F7FDFA;border-top-width:1px;border-bottom-width:1px;}
.tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:0px;overflow:hidden;word-break:normal;border-color:#999;color:#fff;background-color:#26ADE4;border-top-width:1px;border-bottom-width:1px;}
.tg .tg-9wxn{font-weight:bold;font-size:16px;font-family:"Arial Black", Gadget, sans-serif !important;;background-color:#00b83e;color:#333333;text-align:center}
.tg .tg-fxxt{background-color:#a3caff;text-align:center}
.tg .tg-bmek{background-color:#ffcb2f;text-align:center}
.tg .tg-j4kc{background-color:#efefef;text-align:center}
</style>
<table class="tg">
  <tr>
    <th class="tg-9wxn">ACTIVITY NAME</th>
    <th class="tg-9wxn">TimeDomain</th>
    <th class="tg-9wxn">FrequencyDomain</th>
  </tr>
  <tr>
    <td class="tg-fxxt">Body Acceleration</td>
    <td class="tg-bmek">TimeDomain.BodyAcceleration.XYZ</td>
    <td class="tg-j4kc">FrequencyDomain.BodyAcceleration.XYZ</td>
  </tr>
  <tr>
    <td class="tg-fxxt">Gravity Acceleration</td>
    <td class="tg-bmek">TimeDomain.GravityAcceleration.XYZ</td>
    <td class="tg-j4kc"></td>
  </tr>
  <tr>
    <td class="tg-fxxt">Body Acceleration Jerk</td>
    <td class="tg-bmek">TimeDomain.BodyAccelerationJerk.XYZ</td>
    <td class="tg-j4kc">FrequencyDomain.BodyAccelerationJerk.XYZ</td>
  </tr>
  <tr>
    <td class="tg-fxxt">Body Angular Speed</td>
    <td class="tg-bmek">TimeDomain.BodyAngularSpeed.XYZ</td>
    <td class="tg-j4kc">FrequencyDomain.BodyAngularSpeed.XYZ</td>
  </tr>
  <tr>
    <td class="tg-fxxt">Body Angular Acceleration</td>
    <td class="tg-bmek">TimeDomain.BodyAngularAcceleration.XYZ</td>
    <td class="tg-j4kc"></td>
  </tr>
  <tr>
    <td class="tg-fxxt">Body Acceleration Magnitude</td>
    <td class="tg-bmek">TimeDomain.BodyAccelerationMagnitude</td>
    <td class="tg-j4kc">FrequencyDomain.BodyAccelerationMagnitude</td>
  </tr>
  <tr>
    <td class="tg-fxxt">Gravity Acceleration Magnitude</td>
    <td class="tg-bmek">TimeDomain.GravityAccelerationMagnitude</td>
    <td class="tg-j4kc"></td>
  </tr>
  <tr>
    <td class="tg-fxxt">Body Acceleration Jerk Magnitude</td>
    <td class="tg-bmek">TimeDomain.BodyAccelerationJerkMagnitude</td>
    <td class="tg-j4kc">FrequencyDomain.BodyAccelerationJerkMagnitude</td>
  </tr>
  <tr>
    <td class="tg-fxxt">Body Angular Speed Magnitude</td>
    <td class="tg-bmek">TimeDomain.BodyAngularSpeedMagnitude</td>
    <td class="tg-j4kc">FrequencyDomain.BodyAngularSpeedMagnitude</td>
  </tr>
  <tr>
    <td class="tg-fxxt">Body Angular Acceleration Magnitude</td>
    <td class="tg-bmek">TimeDomain.BodyAngularAccelerationMagnitude</td>
    <td class="tg-j4kc">FrequencyDomain.BodyAngularAccelerationMagnitude</td>
  </tr>
</table>

    </ol>
    

</ol>

