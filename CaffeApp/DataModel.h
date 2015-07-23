//
//  kNN.h
//  CaffeApp
//
//  Created by Efe Bozkir on 21/07/15.
//  Copyright (c) 2015 Takuya Matsuyama. All rights reserved.
//

#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <algorithm>
#include <vector>
#include <ctime>
#include <fstream>
#include <cmath>


using namespace std;

// DataModel class
class DataModel {
    
private:
    string location;
    int classLabel;
    int curve;
    int rot;
    vector<float> descriptorVect;
    
public:
    DataModel(string sLocation, int sClassLabel, int sCurve, int sRot, vector<float> sDescriptorVect) {
        location = sLocation;
        classLabel = sClassLabel;
        curve = sCurve;
        rot = sRot;
        descriptorVect = sDescriptorVect;
    }
    DataModel() {
    }
    void setLocation(string sLocation) {
        this->location = sLocation;
    }
    string getLocation() {
        return this->location;
    }
    
    void setClassLabel(int sClassLabel) {
        this->classLabel = sClassLabel;
    }
    int getClassLabel() {
        return this->classLabel;
    }
    
    void setCurve(int sCurve) {
        this->curve = sCurve;
    }
    int getCurve() {
        return this->curve;
    }
    
    void setRot(int sRot) {
        this->rot = sRot;
    }
    int getRot() {
        return this->rot;
    }
    
    void setDescriptorVect(vector<float> sVect) {
        this->descriptorVect = sVect;
    }
    vector<float> getDescriptorVect() {
        return this->descriptorVect;
    }
    
};





