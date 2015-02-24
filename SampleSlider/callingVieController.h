//
//  callingVieController.h
//  SampleSlider
//
//  Created by Jayesh on 12/1/14.
//  Copyright (c) 2014 WhiteSnow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwilioClient.h"
int timerCount;
@interface callingVieController : UIViewController<TCDeviceDelegate,TCConnectionDelegate>{
    UITextField *calledNumber;
    NSTimer *timerNew;
}
@property (retain, nonatomic) IBOutlet UILabel *calledPhoneNumber;
@property (retain,nonatomic) IBOutlet UITextField *calledNumber;
@property (strong, nonatomic) IBOutlet UILabel *displayTimer;

- (IBAction)callEndBtn:(id)sender;
-(void)timer;

@end
