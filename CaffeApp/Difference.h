//
//  Difference.h
//  CaffeApp
//
//  Created by Efe Bozkir on 22/07/15.
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

// Model class for difference
class Difference {
public:
    int classLabel;
    int curve;
    int rot;
    float euclideanDist;
    Difference(int pClassLabel, int pCurve, int pRot, float pEDistance) {
        classLabel = pClassLabel;
        curve = pCurve;
        rot = pRot;
        euclideanDist = pEDistance;
    }
};