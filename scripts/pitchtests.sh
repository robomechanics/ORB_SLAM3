#!/bin/bash
input="../magnitudes2.txt"
for i in {1..100}
do
	while read line
	do
		echo "$i test $line"
		./../Examples/Stereo/stereo_kitti ../Vocabulary/ORBvoc.txt ../Examples/Stereo/AirSim.yaml /media/joe/5056599056597824/AirSimResults/PitchMagnitudeLongerRun/$line
		mv CameraTrajectory.txt "/media/joe/5056599056597824/ORBSlam3Recordings/PitchRange/$line/trajectory$i.txt"
	done < ../magnitudes2.txt
done
