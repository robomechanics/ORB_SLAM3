#!/bin/bash

### This script is meant to run ORB SLAM 3 on the "longer run" dataset multiple 
### times and collect a variety of output from it into the designated folders.
### The version of the RML ORB SLAM fork that should be used with this is xxxxxx
input="../magnitudesRetrialVsExtraFeatures.txt"
for i in {1..1000}
do
	while read line
	do
		# This is simply for feedback to know how far into the script we are
		echo "$i test $line"
		# Calling ORB-SLAM-3 On the desired dataset
		./../Examples/Stereo/stereo_kitti ../Vocabulary/ORBvoc.txt ../Examples/Stereo/AirSim5xFeatures.yaml /media/joe/5056599056597824/AirSimResults/PitchMagnitudeLongerRun/$line
		# Moving the output files to the appropriate location (Make sure to back them up to box)
		#Trajectories
		mkdir --parents /media/joe/5056599056597824/ORBSlam3Recordings/retrial-vs-extra-features/5x-features/$line/trajectories/
		mv CameraTrajectory.txt "/media/joe/5056599056597824/ORBSlam3Recordings/retrial-vs-extra-features/5x-features/$line/trajectories/trajectory$i.txt"
		#number of tracked points
		mkdir --parents /media/joe/5056599056597824/ORBSlam3Recordings/retrial-vs-extra-features/5x-features/$line/nTrackedPoints/
		mv nTrackedPoints.txt "/media/joe/5056599056597824/ORBSlam3Recordings/retrial-vs-extra-features/5x-features/$line/nTrackedPoints/nTrackedPoints$i.txt"
		#Tracking States
		mkdir --parents /media/joe/5056599056597824/ORBSlam3Recordings/retrial-vs-extra-features/5x-features/$line/trackingStates/
		mv trackingStates.txt "/media/joe/5056599056597824/ORBSlam3Recordings/retrial-vs-extra-features/5x-features/$line/trackingStates/trackingStates$i.txt"
		#inlier ratios
		mkdir --parents /media/joe/5056599056597824/ORBSlam3Recordings/retrial-vs-extra-features/5x-features/$line/inlierRatios/
		mv inlierRatios.txt "/media/joe/5056599056597824/ORBSlam3Recordings/retrial-vs-extra-features/5x-features/$line/inlierRatios/inlierRatios$i.txt"
		#average loss
		mkdir --parents /media/joe/5056599056597824/ORBSlam3Recordings/retrial-vs-extra-features/5x-features/$line/averageLoss/
		mv averageLoss.txt "/media/joe/5056599056597824/ORBSlam3Recordings/retrial-vs-extra-features/5x-features/$line/averageLoss/averageLoss$i.txt"

		#Covisibility Graphs
		mkdir --parents /media/joe/5056599056597824/ORBSlam3Recordings/retrial-vs-extra-features/5x-features/$line/covisibility/
		mv covisibility.txt "/media/joe/5056599056597824/ORBSlam3Recordings/retrial-vs-extra-features/5x-features/$line/covisibility/covisibility$i.txt"

		#Number of Map Points
		mkdir --parents /media/joe/5056599056597824/ORBSlam3Recordings/retrial-vs-extra-features/5x-features/$line/nMapPoints/
		mv nMapPoints.txt "/media/joe/5056599056597824/ORBSlam3Recordings/retrial-vs-extra-features/5x-features/$line/nMapPoints/nMapPoints$i.txt"
		#% of Keypoints considered close
		mkdir --parents /media/joe/5056599056597824/ORBSlam3Recordings/retrial-vs-extra-features/5x-features/$line/nStereoPoints/
		mv nStereoPoints.txt "/media/joe/5056599056597824/ORBSlam3Recordings/retrial-vs-extra-features/5x-features/$line/nStereoPoints/nStereoPoints$i.txt"

		mkdir --parents /media/joe/5056599056597824/ORBSlam3Recordings/retrial-vs-extra-features/5x-features/$line/nCloseStereoPoints/
		mv nCloseStereoPoints.txt "/media/joe/5056599056597824/ORBSlam3Recordings/retrial-vs-extra-features/5x-features/$line/nCloseStereoPoints/nCloseStereoPoints$i.txt"

		# Number of re-extractions to successfully complete ORB estimation
		mkdir --parents /media/joe/5056599056597824/ORBSlam3Recordings/retrial-vs-extra-features/5x-features/$line/nReExtractions/
		mv reExtractions.txt "/media/joe/5056599056597824/ORBSlam3Recordings/retrial-vs-extra-features/5x-features/$line/nReExtractions/nReExtractions$i.txt"


	done < ../magnitudesRetrialVsExtraFeatures.txt
done
