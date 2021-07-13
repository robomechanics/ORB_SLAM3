#!/bin/bash

### This script is meant to run ORB SLAM 3 on the "longer run" dataset multiple 
### times and collect a variety of output from it into the designated folders.
### The version of the RML ORB SLAM fork that should be used with this is xxxxxx
input="../magnitudesLow.txt"
for i in {1..100}
do
	for j in {0..500..50}
	do
		# This is simply for feedback to know how far into the script we are
		echo "$i test $j"
		# Calling ORB-SLAM-3 On the desired dataset
		./../Examples/Stereo/stereo_kitti ../Vocabulary/ORBvoc.txt ../Examples/Stereo/AirSim$j.yaml /media/joe/5056599056597824/AirSimResults/PitchMagnitudeLongerRun/0.2356194490192345

		# Moving the output files to the appropriate location (Make sure to back them up to box)
		#Trajectories
		mkdir --parents /media/joe/5056599056597824/ORBSlam3Recordings/lowerOverlapTest_RemovedAfterExtraction/$j/trajectories/
		mv CameraTrajectory.txt "/media/joe/5056599056597824/ORBSlam3Recordings/lowerOverlapTest_RemovedAfterExtraction/$j/trajectories/trajectory$i.txt"
		#number of tracked points
		mkdir --parents /media/joe/5056599056597824/ORBSlam3Recordings/lowerOverlapTest_RemovedAfterExtraction/$j/nTrackedPoints/
		mv nTrackedPoints.txt "/media/joe/5056599056597824/ORBSlam3Recordings/lowerOverlapTest_RemovedAfterExtraction/$j/nTrackedPoints/nTrackedPoints$i.txt"
		#Tracking States
		mkdir --parents /media/joe/5056599056597824/ORBSlam3Recordings/lowerOverlapTest_RemovedAfterExtraction/$j/trackingStates/
		mv trackingStates.txt "/media/joe/5056599056597824/ORBSlam3Recordings/lowerOverlapTest_RemovedAfterExtraction/$j/trackingStates/trackingStates$i.txt"
		#inlier ratios
		mkdir --parents /media/joe/5056599056597824/ORBSlam3Recordings/lowerOverlapTest_RemovedAfterExtraction/$j/inlierRatios/
		mv inlierRatios.txt "/media/joe/5056599056597824/ORBSlam3Recordings/lowerOverlapTest_RemovedAfterExtraction/$j/inlierRatios/inlierRatios$i.txt"
		#average loss
		mkdir --parents /media/joe/5056599056597824/ORBSlam3Recordings/lowerOverlapTest_RemovedAfterExtraction/$j/averageLoss/
		mv averageLoss.txt "/media/joe/5056599056597824/ORBSlam3Recordings/lowerOverlapTest_RemovedAfterExtraction/$j/averageLoss/averageLoss$i.txt"

		#Covisibility Graphs
		mkdir --parents /media/joe/5056599056597824/ORBSlam3Recordings/lowerOverlapTest_RemovedAfterExtraction/$j/covisibility/
		mv covisibility.txt "/media/joe/5056599056597824/ORBSlam3Recordings/lowerOverlapTest_RemovedAfterExtraction/$j/covisibility/covisibility$i.txt"

		#Number of Map Points
		mkdir --parents /media/joe/5056599056597824/ORBSlam3Recordings/lowerOverlapTest_RemovedAfterExtraction/$j/nMapPoints/
		mv nMapPoints.txt "/media/joe/5056599056597824/ORBSlam3Recordings/lowerOverlapTest_RemovedAfterExtraction/$j/nMapPoints/nMapPoints$i.txt"
		#% of Keypoints considered close
		mkdir --parents /media/joe/5056599056597824/ORBSlam3Recordings/lowerOverlapTest_RemovedAfterExtraction/$j/nStereoPoints/
		mv nStereoPoints.txt "/media/joe/5056599056597824/ORBSlam3Recordings/lowerOverlapTest_RemovedAfterExtraction/$j/nStereoPoints/nStereoPoints$i.txt"

		mkdir --parents /media/joe/5056599056597824/ORBSlam3Recordings/lowerOverlapTest_RemovedAfterExtraction/$j/nCloseStereoPoints/
		mv nCloseStereoPoints.txt "/media/joe/5056599056597824/ORBSlam3Recordings/lowerOverlapTest_RemovedAfterExtraction/$j/nCloseStereoPoints/nCloseStereoPoints$i.txt"

		# Number of re-extractions to successfully complete ORB estimation
		mkdir --parents /media/joe/5056599056597824/ORBSlam3Recordings/lowerOverlapTest_RemovedAfterExtraction/$j/nReExtractions/
		mv reExtractions.txt "/media/joe/5056599056597824/ORBSlam3Recordings/lowerOverlapTest_RemovedAfterExtraction/$j/nReExtractions/nReExtractions$i.txt"

		mkdir --parents /media/joe/5056599056597824/ORBSlam3Recordings/lowerOverlapTest_RemovedAfterExtraction/$j/orbMatchedPoints/
		mv orbMatchedPoints.txt "/media/joe/5056599056597824/ORBSlam3Recordings/lowerOverlapTest_RemovedAfterExtraction/$j/orbMatchedPoints/orbMatchedPoints$i.txt"

		mkdir --parents /media/joe/5056599056597824/ORBSlam3Recordings/lowerOverlapTest_RemovedAfterExtraction/$j/usedVelocity/
		mv usedVelocity.txt "/media/joe/5056599056597824/ORBSlam3Recordings/lowerOverlapTest_RemovedAfterExtraction/$j/usedVelocity/usedVelocity$i.txt"



	done
done
