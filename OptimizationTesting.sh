#!/bin/bash
input="magnitudes2.txt"
for i in {1..100}
do
	echo "TEST NUMBER $i"
	./Examples/Stereo/stereo_kitti Vocabulary/ORBvoc.txt Examples/Stereo/AirSim.yaml /media/joe/5056599056597824/AirSimResults/PitchMagnitudeLongerRun/0.20420352248333656
	mv CameraTrajectory.txt "/media/joe/5056599056597824/ORBSlam3Recordings/OptimizationTesting/trajectory$i.txt"
	mv trackingStates.txt "/media/joe/5056599056597824/ORBSlam3Recordings/OptimizationTesting/states$i.txt"
	mv nTrackedPoints.txt "/media/joe/5056599056597824/ORBSlam3Recordings/OptimizationTesting/trackedPoints$i.txt"
	mv inlierRatios.txt "/media/joe/5056599056597824/ORBSlam3Recordings/OptimizationTesting/inlierRatios$i.txt"
	mv averageLoss.txt "/media/joe/5056599056597824/ORBSlam3Recordings/OptimizationTesting/averageChiSquared$i.txt"
done
