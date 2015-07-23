//
//  kNN.h
//  CaffeApp
//
//  Created by Efe Bozkir on 22/07/15.
//  Copyright (c) 2015 Takuya Matsuyama. All rights reserved.
//

#import "Difference.h"
#import "Result.h"
#import "DataModel.h"

class Knn {
public:
    void readTrainingDescriptorInformation(string descriptorFile);
    void setTrainingDescriptorsVect(vector<DataModel> vect) {
        trainingDescriptorsVect = vect;
    }
    vector<DataModel> getTrainingDescriptorsVect() {
        return trainingDescriptorsVect;
    }
    int knnClassify(vector<DataModel> trainDescriptorsData, vector<float> testDescriptor);
    //Knn();
    
  

protected:
    vector<DataModel> trainingDescriptorsVect;


};

