#!/bin/bash
input="magnitudes2.txt"
for i in {1..1000}
do
	echo "$i"
	./Examples/Stereo/stereo_kitti Vocabulary/ORBvoc.txt Examples/Stereo/AirSim.yaml /media/joe/5056599056597824/AirSimResults/PitchMagnitudeLongerRun/0.0
	mv CameraTrajectory.txt "/media/joe/5056599056597824/ORBSlam3Recordings/ORB30.0/trajectory$i.txt"
done

for i in {1..1000}
do
	echo "$i"
	./Examples/Stereo/stereo_kitti Vocabulary/ORBvoc.txt Examples/Stereo/AirSim.yaml /media/joe/5056599056597824/AirSimResults/PitchMagnitudeLongerRun/0.0471238898038469
	mv CameraTrajectory.txt "/media/joe/5056599056597824/ORBSlam3Recordings/ORB30.0471238898038469/trajectory$i.txt"
done

for i in {1..1000}
do
	echo "$i"
	./Examples/Stereo/stereo_kitti Vocabulary/ORBvoc.txt Examples/Stereo/AirSim.yaml /media/joe/5056599056597824/AirSimResults/PitchMagnitudeLongerRun/0.12566370614359174
	mv CameraTrajectory.txt "/media/joe/5056599056597824/ORBSlam3Recordings/ORB30.12566370614359174/trajectory$i.txt"
done

