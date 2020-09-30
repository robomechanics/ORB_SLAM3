#!/bin/bash
input="magnitudes2.txt"
while read mag
do
	for i in {1..100}
	do
	
		while read numPoints
		do
			echo "magnitude: $mag test #: $i # points: $numPoints"
			./Examples/Stereo/stereo_kitti Vocabulary/ORBvoc.txt Examples/Stereo/AirSim.yaml /media/joe/5056599056597824/AirSimResults/PitchTriangularRange/$mag/$numPoints
			mv CameraTrajectory.txt "/media/joe/5056599056597824/ORBSlam3Recordings/PitchTriangularRange/$mag/$numPoints/trajectory$i.txt"
		done < freqs.txt
	
	done
done < mags.txt