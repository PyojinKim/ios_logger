## iOS Logger ##

Application for logging camera images, accelerometer and gyroscope data, gps and heading data, motion data and magnet data.
This application was made for logging camera images and ARKit pose data on Apple devices (iPhone/iPad).

![iOS Logger](https://github.com/PyojinKim/ios_logger/blob/master/screenshot.png)

For more details, see the ARKit documentation [here](https://developer.apple.com/documentation/arkit).


## Build and Run ##

1. Open ios_logger.xcodeproj in Xcode.
2. In project properties -> General set your team signing and make sure that signing certificate was successfully created.
3. Connect your device (you may have to wait for the debugger to be set up), select it (Product -> Destination) and run application (Product -> Run).


## Collect Datasets ##

To start collecting dataset:
* set required image resolution in upper-left corner (ARKit is recommended).
* **if you check ARKit segment - app will use ARKit to get camera images (with ARKit native resolution - depends on the device) + app will _logging ARKit poses of the device_ (with origin in place where "START" button was pressed)**
* set switches with required sensors to be logged.
* _you can set AutoFocus on/off with "AF" button._
* _with off AutoFocus you can set camera focal length by slider in bottom-right corner._
* press "START" button.
* when you want to stop collecting dataset press "STOP" :-)

Each dataset will be saved in separate folder on the device.


## Get Saved Datasets ##

After you have collected datasets, connect your device to PC and run iTunes.
In iTunes go to device -> File Sharing -> ios-logger, in right table check folders with datasets you needed and save it on your PC.
In last versions of macOS, you should use finder to access the device and get File Sharing.


## Dataset Output Format ##

* Accel.txt: `time(s(from 1970)), ax(g-units), ay(g-units), az(g-units)`
* ARposes.txt: `time(s), ARKit.translation.x(m), ARKit.translation.y(m), ARKit.translation.z(m), ARKit.quaternion.w, ARKit.quaternion.x, ARKit.quaternion.y, ARKit.quaternion.z`
* Frames.m4v: frames compressed in video
* Frames.txt: `time(s), frameNumber, focalLengthX, focalLengthY, principalPointX, principalPointY`
* GPS.txt: `time(s), latitude(deg), longitude(deg), horizontalAccuracy(m), altitude(m), verticalAccuracy(m), floorLevel, course(dgr), speed(m/s)`
* Gyro.txt: `time(s), gx(rad/s), gy(rad/s), gz(rad/s)`  
* Head.txt: `time(s), trueHeading(dgr), magneticHeading(dgr), headingAccuracy(dgr)`
* Magnet.txt: `time(s), magneticField.x(microteslas), magneticField.y(microteslas), magneticField.z(microteslas)`
* MotARH.txt: `time(s), rotationRate.x(rad/s), rotationRate.y(rad/s), rotationRate.z(rad/s), gravity.x(g-units), gravity.y(g-units), gravity.z(g-units), userAccel.x(g-units), userAccel.y(g-units), userAccel.z(g-units), motionHeading(dgr)`
* Motion.txt: `time(s), attitude.quaternion.w, attitude.quaternion.x, attitude.quaternion.y, attitude.quaternion.z`
* MotMagnFull.txt: `time(s), calibratedMagnField.x(microteslas), calibratedMagnField.y(microteslas), calibratedMagnField.z(microteslas), magnFieldAccuracy`


## Tested Environments and Devices ##

* Environments: Xcode Version 12.5.1 (12E507)
* Devices: iPhone XS (iOS 14.4.2), iPad Pro 4th Generation (iPadOS 14.6), etc....


## Offline MATLAB Visualization ##

I have included an example script that you can use to parse and visualize the data that comes from iOS Logger.
Look under the Visualization directory to check it out.
You can run the script by typing the following in your terminal:
