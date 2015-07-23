//
//  ViewController.m
//  CaffeApp
//
//  Created by Takuya Matsuyama on 7/11/15.
//  Copyright (c) 2015 Takuya Matsuyama. All rights reserved.
//

#import "ViewController.h"
#import "Classifier.h"
#import "Knn.h"

@interface ViewController () {
    UIImage* classificationImage;
    int initialFlag;
    vector<DataModel> trainingDescVect;
}

@end

@implementation ViewController

- (IBAction)takePhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (IBAction)selectPhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    
}

- (IBAction)classify:(id)sender {
    
    [self predict:classificationImage];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    classificationImage = chosenImage;
    
    NSLog(@"HERE");
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  //[self predict];
  NSLog(@"VIEW DID LOAD");
  NSString* trainingDescriptorFile = [NSBundle.mainBundle pathForResource:@"descriptors" ofType:@"txt" inDirectory:@"model"];
  string training_desc_file_str = std::string([trainingDescriptorFile UTF8String]);
  Knn *myKnn = new Knn();
  myKnn->readTrainingDescriptorInformation(training_desc_file_str);
    for(int i=0; i<myKnn->getTrainingDescriptorsVect().size(); i++) {
        trainingDescVect.push_back(myKnn->getTrainingDescriptorsVect().at(i));
    }
    /*
    for(int y=0; y<trainingDescVect.size(); y++) {
        cout<<"Location: "<<trainingDescVect.at(y).getLocation()<<endl;
        cout<<"Class Label: "<<trainingDescVect.at(y).getClassLabel()<<endl;
        cout<<"Curve: "<<trainingDescVect.at(y).getCurve()<<endl;
        cout<<"Rot:"<<trainingDescVect.at(y).getRot()<<endl;
        for(int r=0; r<trainingDescVect.at(y).getDescriptorVect().size(); r++) {
            cout<<"Descriptor Element: "<<trainingDescVect.at(y).getDescriptorVect().at(r)<<endl;
        }
    }*/
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)predict:(UIImage*) classificationImg;
{
  NSString* model_file = [NSBundle.mainBundle pathForResource:@"deploy" ofType:@"prototxt" inDirectory:@"model"];
  NSString* label_file = [NSBundle.mainBundle pathForResource:@"labels" ofType:@"txt" inDirectory:@"model"];
  NSString* mean_file = [NSBundle.mainBundle pathForResource:@"mean" ofType:@"binaryproto" inDirectory:@"model"];
  NSString* trained_file = [NSBundle.mainBundle pathForResource:@"caffenet_train_iter_500" ofType:@"caffemodel" inDirectory:@"model"];
  
  string model_file_str = std::string([model_file UTF8String]);
  string label_file_str = std::string([label_file UTF8String]);
  string trained_file_str = std::string([trained_file UTF8String]);
  string mean_file_str = std::string([mean_file UTF8String]);
  
  
  //UIImage* example = [UIImage imageNamed:@"image_0002.jpg"];
  
  cv::Mat src_img;
  UIImageToMat(classificationImage, src_img);
    
  Classifier classifier = Classifier(model_file_str, trained_file_str, mean_file_str, label_file_str);
  std::vector<float> predictionVect = classifier.Classify(src_img);
    for(int i=0; i<16; i++) {
        float vectorElement = predictionVect[i];
        NSLog(@"%f", vectorElement);
    }
    Knn *myKnn = new Knn();
    int result = myKnn->knnClassify(trainingDescVect, predictionVect);
    _recogObject.text = [NSString stringWithFormat:@"%d", result];
    cout<<"Result: "<<result<<endl;

}
@end

