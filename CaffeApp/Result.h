//
//  Result.h
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


// Result class
class Result {
    
public:
    int classLabel;
    int frequency;
    Result(int pClassType, int pFreq) {
        classLabel = pClassType;
        frequency = pFreq;
    }
    void increaseFrequency() {
        frequency++;
    }
};
