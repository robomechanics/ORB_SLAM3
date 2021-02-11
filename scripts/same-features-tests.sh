#!/bin/bash

### This script is meant to run ORB SLAM 3 on the "longer run" dataset multiple 
### times and collect a variety of output from it into the designated folders.
### The version of the RML ORB SLAM fork that should be used with this is xxxxxx
input="../magnitudesRetrialVsExtraFeatures.txt"
for i in {1..10}
do
	while read line
	do
		# This is simply for feedback to know how far into the script we are
		echo "$i test $line"
		# Calling ORB-SLAM-3 On the desired dataset
		./../Examples/Stereo/stereo_kitti ../Vocabulary/ORBvoc.txt ../Examples/Stereo/AirSim.yaml /media/joe/5056599056597824/AirSimResults/PitchMagnitudeLongerRun/$line
		for j in {1..100}
		do
			# Moving the output files to the appropriate location (Make sure to back them up to box)
			#Trajectories
			mkdir --parents /media/joe/5056599056597824/ORBSlam3Recordings/Same-Features-Test/$line/$i/trajectories/
			mv CameraTrajectory$j.txt "/media/joe/5056599056597824/ORBSlam3Recordings/Same-Features-Test/$line/$i/trajectories/trajectory$j.txt"
			#number of tracked points
			mkdir --parents /media/joe/5056599056597824/ORBSlam3Recordings/Same-Features-Test/$line/$i/nTrackedPoints/
			mv nTrackedPoints$j.txt "/media/joe/5056599056597824/ORBSlam3Recordings/Same-Features-Test/$line/$i/nTrackedPoints/nTrackedPoints$j.txt"
			#Tracking States
			mkdir --parents /media/joe/5056599056597824/ORBSlam3Recordings/Same-Features-Test/$line/$i/trackingStates/
			mv trackingStates$j.txt "/media/joe/5056599056597824/ORBSlam3Recordings/Same-Features-Test/$line/$i/trackingStates/trackingStates$j.txt"
			#inlier ratios
			mkdir --parents /media/joe/5056599056597824/ORBSlam3Recordings/Same-Features-Test/$line/$i/inlierRatios/
			mv inlierRatios$j.txt "/media/joe/5056599056597824/ORBSlam3Recordings/Same-Features-Test/$line/$i/inlierRatios/inlierRatios$j.txt"
			#average loss
			mkdir --parents /media/joe/5056599056597824/ORBSlam3Recordings/Same-Features-Test/$line/$i/averageLoss/
			mv averageLoss$j.txt "/media/joe/5056599056597824/ORBSlam3Recordings/Same-Features-Test/$line/$i/averageLoss/averageLoss$j.txt"

			#Covisibility Graphs
			mkdir --parents /media/joe/5056599056597824/ORBSlam3Recordings/Same-Features-Test/$line/$i/covisibility/
			mv covisibility$j.txt "/media/joe/5056599056597824/ORBSlam3Recordings/Same-Features-Test/$line/$i/covisibility/covisibility$j.txt"

			#Number of Map Points
			mkdir --parents /media/joe/5056599056597824/ORBSlam3Recordings/Same-Features-Test/$line/$i/nMapPoints/
			mv nMapPoints$j.txt "/media/joe/5056599056597824/ORBSlam3Recordings/Same-Features-Test/$line/$i/nMapPoints/nMapPoints$j.txt"
			#% of Keypoints considered close
			mkdir --parents /media/joe/5056599056597824/ORBSlam3Recordings/Same-Features-Test/$line/$i/nStereoPoints/
			mv nStereoPoints$j.txt "/media/joe/5056599056597824/ORBSlam3Recordings/Same-Features-Test/$line/$i/nStereoPoints/nStereoPoints$j.txt"

			mkdir --parents /media/joe/5056599056597824/ORBSlam3Recordings/Same-Features-Test/$line/$i/nCloseStereoPoints/
			mv nCloseStereoPoints$j.txt "/media/joe/5056599056597824/ORBSlam3Recordings/Same-Features-Test/$line/$i/nCloseStereoPoints/nCloseStereoPoints$j.txt"

			# # Number of re-extractions to successfully complete ORB estimation
			# mkdir --parents /media/joe/5056599056597824/ORBSlam3Recordings/Same-Features-Test/$line/$i/nReExtractions/
			# mv reExtractions$j.txt "/media/joe/5056599056597824/ORBSlam3Recordings/Same-Features-Test/$line/$i/nReExtractions/nReExtractions$j.txt"
		done

	done < ../magnitudesRetrialVsExtraFeatures.txt
done
