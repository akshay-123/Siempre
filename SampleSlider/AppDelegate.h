//
//  AppDelegate.h
//  SampleSlider
//
//  Created by Jayesh on 11/18/14.
//  Copyright (c) 2014 WhiteSnow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwilioClient.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
@class MonkeyPhone;
@class Reachability;

@interface AppDelegate : NSObject <UIApplicationDelegate>

{
    UIWindow* _window;
    Reachability *internetReachability;
    SystemSoundID mySound;
}

-(void)registrationForTwilio;
-(void)outGoingCall;

@property (nonatomic, retain) IBOutlet UIWindow* window;
@property (nonatomic, strong)  TCDevice* phone;
@property (nonatomic, strong)  TCConnection* phConnection;

@end

