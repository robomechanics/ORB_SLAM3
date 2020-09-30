#!/bin/bash
input="magnitudes2.txt"
for i in {1..100}
do
	for j in {1..25}
	do
		echo "$i test $j"
		./Examples/Stereo/stereo_kitti Vocabulary/ORBvoc.txt Examples/Stereo/AirSim.yaml /media/joe/5056599056597824/AirSimResults/PitchMagnitudeSmooth/$j
		mv CameraTrajectory.txt "/media/joe/5056599056597824/ORBSlam3Recordings/SmoothCases/$j/trajectory$i.txt"
	done
done
