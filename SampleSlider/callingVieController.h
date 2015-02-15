//
//  callingVieController.h
//  SampleSlider
//
//  Created by Jayesh on 12/1/14.
//  Copyright (c) 2014 WhiteSnow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwilioClient.h"

@interface callingVieController : UIViewController<TCDeviceDelegate,TCConnectionDelegate>{
    UITextField *calledNumber;
}
@property (retain, nonatomic) IBOutlet UILabel *calledPhoneNumber;
@property (retain,nonatomic) IBOutlet UITextField *calledNumber;
@property (weak, nonatomic) IBOutlet UILabel *displayTimer;

- (IBAction)callEndBtn:(id)sender;
-(void)timer;

@end
