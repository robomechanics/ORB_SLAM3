/**
* This file is part of ORB-SLAM3
*
* Copyright (C) 2017-2020 Carlos Campos, Richard Elvira, Juan J. Gómez Rodríguez, José M.M. Montiel and Juan D. Tardós, University of Zaragoza.
* Copyright (C) 2014-2016 Raúl Mur-Artal, José M.M. Montiel and Juan D. Tardós, University of Zaragoza.
*
* ORB-SLAM3 is free software: you can redistribute it and/or modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* ORB-SLAM3 is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even
* the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License along with ORB-SLAM3.
* If not, see <http://www.gnu.org/licenses/>.
*/

#include<iostream>
#include<algorithm>
#include<fstream>
#include<iomanip>
#include<chrono>

#include<opencv2/core/core.hpp>

#include<System.h>

using namespace std;

void LoadImages(const string &strPathToSequence, vector<string> &vstrImageLeft,
                vector<string> &vstrImageRight, vector<double> &vTimestamps);

int main(int argc, char **argv)
{
    if(argc != 4)
    {
        cerr << endl << "Usage: ./stereo_kitti path_to_vocabulary path_to_settings path_to_sequence" << endl;
        return 1;
    }

    // Retrieve paths to images
    vector<string> vstrImageLeft;
    vector<string> vstrImageRight;
    vector<double> vTimestamps;
    LoadImages(string(argv[3]), vstrImageLeft, vstrImageRight, vTimestamps);

    const int nImages = vstrImageLeft.size();

    // Create SLAM system. It initializes all system threads and gets ready to process frames.
    ORB_SLAM3::System SLAM(argv[1],argv[2],ORB_SLAM3::System::STEREO,false);

    // Vector for tracking time statistics
    vector<float> vTimesTrack;
    vTimesTrack.resize(nImages);

    // JOE MODIFICATION: TRACKING STATE AND # FEATURES TRACKED:
    vector<int> numPointsTracked;
    numPointsTracked.resize(nImages);

    vector<int> systemStates;
    systemStates.resize(nImages);

    vector<double> inlierRatios;
    inlierRatios.resize(nImages);

    vector<double> averageLoss;
    averageLoss.resize(nImages);

    vector<long unsigned int> nMapPoints;
    nMapPoints.resize(nImages);

    vector<int> nStereoPoints;
    nStereoPoints.resize(nImages);
    vector<int> nCloseStereoPoints;
    nCloseStereoPoints.resize(nImages);

    // Adding info about the image coordinates of features by frame:
    vector<float> featuresXCoords;
    vector<float> featuresYCoords;
    vector<float> featuresZCoords;

    // Covisibility Graph Tracking:
    std::vector<std::vector<int>> covisibility(nImages,std::vector<int>(nImages));


    cout << endl << "-------" << endl;
    cout << "Start processing sequence ..." << endl;
    cout << "Images in the sequence: " << nImages << endl << endl;   

    // Main loop
    cv::Mat imLeft, imRight;
    for(int ni=0; ni<nImages; ni++)
    {
        // Read left and right images from file
        imLeft = cv::imread(vstrImageLeft[ni],cv::IMREAD_UNCHANGED);
        imRight = cv::imread(vstrImageRight[ni],cv::IMREAD_UNCHANGED);
        double tframe = vTimestamps[ni];

        if(imLeft.empty())
        {
            cerr << endl << "Failed to load image at: "
                 << string(vstrImageLeft[ni]) << endl;
            return 1;
        }

#ifdef COMPILEDWITHC11
        std::chrono::steady_clock::time_point t1 = std::chrono::steady_clock::now();
#else
        std::chrono::monotonic_clock::time_point t1 = std::chrono::monotonic_clock::now();
#endif

        // Pass the images to the SLAM system
        SLAM.TrackStereo(imLeft,imRight,tframe);

#ifdef COMPILEDWITHC11
        std::chrono::steady_clock::time_point t2 = std::chrono::steady_clock::now();
#else
        std::chrono::monotonic_clock::time_point t2 = std::chrono::monotonic_clock::now();
#endif

        double ttrack= std::chrono::duration_cast<std::chrono::duration<double> >(t2 - t1).count();

        vTimesTrack[ni]=ttrack;

        // Wait to load the next frame
        double T=0;
        if(ni<nImages-1)
            T = vTimestamps[ni+1]-tframe;
        else if(ni>0)
            T = tframe-vTimestamps[ni-1];

        if(ttrack<T)
            usleep((T-ttrack)*1e6);

        //modifications for additional data:
        int currentState = SLAM.GetTrackingState();
        systemStates[ni] = currentState;

        numPointsTracked[ni] = SLAM.GetTrackedPointsOpt();
        inlierRatios[ni] = SLAM.GetInlierRatio();
        averageLoss[ni] = SLAM.GetAverageLoss();
        nMapPoints[ni] = SLAM.MapPointsInMap();
        nCloseStereoPoints[ni] = SLAM.GetNCloseStereoPoints();
        nStereoPoints[ni] = SLAM.GetNStereoPoints();
        covisibility[ni] = SLAM.GetCovisibility(nImages);
        if(ni>0){
            // GET X/Y Coords for the current step:
            featuresXCoords = SLAM.GetXCoords();
            featuresYCoords = SLAM.GetYCoords();
            featuresZCoords = SLAM.GetZCoords();

            // Output the current x/y coords
            // ofstream statfile;
            // statfile.open("featureLocations" + to_string(ni) + ".txt");
            // for(int ii=0;ii<featuresXCoords.size();ii++){
            //     statfile << featuresXCoords[ii] << "," << featuresYCoords[ii] << "," << featuresZCoords[ii] << endl;
            // }
            // statfile.close();
        }
    }

    // Stop all threads
    SLAM.Shutdown();

    // Tracking time statistics
    sort(vTimesTrack.begin(),vTimesTrack.end());
    float totaltime = 0;
    for(int ni=0; ni<nImages; ni++)
    {
        totaltime+=vTimesTrack[ni];
    }
    cout << "-------" << endl << endl;
    cout << "median tracking time: " << vTimesTrack[nImages/2] << endl;
    cout << "mean tracking time: " << totaltime/nImages << endl;

    // Save camera trajectory
    SLAM.SaveTrajectoryKITTI("CameraTrajectory.txt");

    //Save other metrics:
    ofstream statfile;
    statfile.open("nTrackedPoints.txt");
    for(int ii=0;ii<nImages;ii++){
        statfile << numPointsTracked[ii] << endl;
    }
    statfile.close();
    statfile.open("trackingStates.txt");
    for(int ii=0;ii<nImages;ii++){
        statfile << systemStates[ii] << endl;
    }
    statfile.close();

    statfile.open("inlierRatios.txt");
    for(int ii=0;ii<nImages;ii++){
        statfile << inlierRatios[ii] << endl;
    }
    statfile.close();

    statfile.open("averageLoss.txt");
    for(int ii=0;ii<nImages;ii++){
        statfile << averageLoss[ii] << endl;
    }
    statfile.close();

    statfile.open("nMapPoints.txt");
    for(int ii=0;ii<nImages;ii++){
        statfile << nMapPoints[ii] << endl;
    }
    statfile.close();

    statfile.open("nStereoPoints.txt");
    for(int ii=0;ii<nImages;ii++){
        statfile << nStereoPoints[ii] << endl;
    }
    statfile.close();

    statfile.open("nCloseStereoPoints.txt");
    for(int ii=0;ii<nImages;ii++){
        statfile << nCloseStereoPoints[ii] << endl;
    }
    statfile.close();

    // Covisibility Graph Stuff:
    // std::vector<std::vector<int>> covisibility = SLAM.GetCovisibility();
    statfile.open("covisibility.txt");
    for(int ii=0;ii<covisibility.size();ii++){
        for(int jj=0;jj<covisibility.size();jj++){
            statfile << covisibility[ii][jj] <<",";
        }
        statfile << endl;
    }
    statfile.close();

    return 0;
}

void LoadImages(const string &strPathToSequence, vector<string> &vstrImageLeft,
                vector<string> &vstrImageRight, vector<double> &vTimestamps)
{
    ifstream fTimes;
    string strPathTimeFile = strPathToSequence + "/times.txt";
    fTimes.open(strPathTimeFile.c_str());
    while(!fTimes.eof())
    {
        string s;
        getline(fTimes,s);
        if(!s.empty())
        {
            stringstream ss;
            ss << s;
            double t;
            ss >> t;
            vTimestamps.push_back(t);
        }
    }

    string strPrefixLeft = strPathToSequence + "/image_0/";
    string strPrefixRight = strPathToSequence + "/image_1/";

    const int nTimes = vTimestamps.size();
    vstrImageLeft.resize(nTimes);
    vstrImageRight.resize(nTimes);

    for(int i=0; i<nTimes; i++)
    {
        stringstream ss;
        ss << setfill('0') << setw(6) << i;
        vstrImageLeft[i] = strPrefixLeft + ss.str() + ".png";
        vstrImageRight[i] = strPrefixRight + ss.str() + ".png";
    }
}
