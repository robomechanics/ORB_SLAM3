#!/bin/bash
input="magnitudes2.txt"
for i in {1..1000}
do
	echo "$i"
	./Examples/Stereo/stereo_kitti Vocabulary/ORBvoc.txt Examples/Stereo/AirSim.yaml /media/joe/5056599056597824/AirSimResults/PitchMagnitudeLongerRun/0.20420352248333656
	mv CameraTrajectory.txt "/media/joe/5056599056597824/ORBSlam3Recordings/ORB3Default/trajectory$i.txt"
done


