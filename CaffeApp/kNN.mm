//
//  kNN.m
//  CaffeApp
//
//  Created by Efe Bozkir on 22/07/15.
//  Copyright (c) 2015 Takuya Matsuyama. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import "Knn.h"

vector<DataModel> trainingDescriptorsVect;


// Sort Difference vector
bool compare_by_dist(const Difference lhs, const Difference rhs) {
    return lhs.euclideanDist < rhs.euclideanDist;
}
// Sort Result vector
bool compare_by_freq(const Result lhs, const Result rhs) {
    return lhs.frequency > rhs.frequency;
}

int Knn::knnClassify(vector<DataModel> trainDescriptorsData, vector<float> testDescriptor) {
    
    vector<Difference> differenceVect;
    differenceVect.clear();
    
    for(int j=0; j<trainDescriptorsData.size(); j++) {
        float dist = 0;
        for(int z=0; z<testDescriptor.size(); z++) {
            float temp;
            temp = pow((testDescriptor.at(z)-trainDescriptorsData.at(j).getDescriptorVect().at(z)),2);
            dist = dist + temp;
        }
        dist = sqrt(dist);
        Difference *diffTemp = new Difference(trainDescriptorsData.at(j).getClassLabel(), trainDescriptorsData.at(j).getCurve(), trainDescriptorsData.at(j).getRot(), dist);
        differenceVect.push_back(*diffTemp);
    }
   
    std::sort(differenceVect.begin(), differenceVect.end(), compare_by_dist);
   
    vector<Result> resultVect;
    for(int h=0; h<5; h++) {
        Result *tempResult = new Result(h+1, 0);
        resultVect.push_back(*tempResult);
    }
    
    // k  is upper bound of the for loop
    for(int p=0; p<1; p++) {
        // update the frequencies according to k'th value
        if(differenceVect.at(p).classLabel == 1) {
            resultVect.at(1-1).increaseFrequency();
        }
        else if(differenceVect.at(p).classLabel == 2) {
            resultVect.at(2-1).increaseFrequency();
        }
        else if(differenceVect.at(p).classLabel == 3) {
            resultVect.at(3-1).increaseFrequency();
        }
        else if(differenceVect.at(p).classLabel == 4) {
            resultVect.at(4-1).increaseFrequency();
        }
        else if(differenceVect.at(p).classLabel == 5) {
            resultVect.at(5-1).increaseFrequency();
        }
    }
    
    // Sort resultVect which has the occurance frequencies of classes so the top elements would be the likely classes
    std::sort(resultVect.begin(), resultVect.end(), compare_by_freq);
    vector<int> likelyClasses;
    int max=0;
    for(int u=0; u<5; u++){
        if(resultVect.at(u).frequency>=max) {
            max = resultVect.at(u).frequency;
            likelyClasses.push_back(resultVect.at(u).classLabel);
        }
    }
    
    return likelyClasses.at(0);
    /*
    for(int o=0; o<likelyClasses.size; o++) {
        cout<<"Likely class: "<<likelyClasses.at(o)<<endl;
    }*/

};

// Read training data
void Knn::readTrainingDescriptorInformation(string descriptorFile) {
    
    string line;
    ifstream myReadFile;
    myReadFile.open(descriptorFile);
    int z = 1;
    int counter = 0;
    char output[250];
    if (myReadFile.is_open()) {
        string location;
        int classLabel;
        int curve;
        int rot;
        vector<float> descriptor;
        
        while (!myReadFile.eof()) {
            myReadFile >> output;
            
            if(z==21) {
                DataModel *temp = new DataModel(location, classLabel, curve, rot, descriptor);
                trainingDescriptorsVect.push_back(*temp);
                /*
                 cout<<"Location: "<<temp->getLocation()<<endl;
                 cout<<"Class Label: "<<temp->getClassLabel()<<endl;
                 cout<<"Curve: "<<temp->getCurve()<<endl;
                 cout<<"Rot: "<<temp->getRot()<<endl;
                 for(int t=0; t<descriptor.size(); t++)
                 cout<<"Descriptor element: "<<descriptor.at(t)<<endl;
                 */
                descriptor.clear();
                z=1;
            }
            
            if(myReadFile.eof())
                break;
            
            if(z == 1) {
                location = output;
                //cout<<"Location: "<<location<<endl;
                counter++;
            }
            else if(z == 2) {
                sscanf(output, "%d", &classLabel);
                //cout<<"ClassLabel: "<<classLabel<<endl;
            }
            else if(z == 3) {
                sscanf(output, "%d", &curve);
                //cout<<"Curve: "<<curve<<endl;
            }
            else if(z == 4) {
                sscanf(output, "%d", &rot);
                //cout<<"Rot: "<<rot<<endl;
            }
            else if (z>4 && z<21) {
                float temp;
                sscanf(output, "%f", &temp);
                //cout<<"Temp: "<<temp<<endl;
                descriptor.push_back(temp);
            }
            z++;
            //cout<<output<<endl<<endl;
        }
    }
    myReadFile.close();
    
    /*
     for(int y=0; y<trainingDescriptorsVect.size(); y++) {
	    cout<<"Location: "<<trainingDescriptorsVect.at(y).getLocation()<<endl;
	    cout<<"Class Label: "<<trainingDescriptorsVect.at(y).getClassLabel()<<endl;
	    cout<<"Curve: "<<trainingDescriptorsVect.at(y).getCurve()<<endl;
	    cout<<"Rot:"<<trainingDescriptorsVect.at(y).getRot()<<endl;
	    for(int r=0; r<trainingDescriptorsVect.at(y).getDescriptorVect().size(); r++) {
     cout<<"Descriptor Element: "<<trainingDescriptorsVect.at(y).getDescriptorVect().at(r)<<endl;
	    }
     }
     */
    
    //cout<<trainingDescriptorsVect.size()<<endl;
    
}