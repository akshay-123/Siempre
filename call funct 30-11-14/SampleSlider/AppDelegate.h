//
//  AppDelegate.h
//  SampleSlider
//
//  Created by Jayesh on 11/18/14.
//  Copyright (c) 2014 WhiteSnow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MonkeyPhone;

@interface AppDelegate : NSObject <UIApplicationDelegate>

//@property (strong, nonatomic) UIWindow *window;

{
    UIWindow* _window;
    MonkeyPhone* _phone;
}

@property (nonatomic, retain) MonkeyPhone* phone;
@property (nonatomic, retain) IBOutlet UIWindow* window;

@end

