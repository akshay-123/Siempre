//
//  PasswordRecoveryViewController.h
//  SampleSlider
//
//  Created by Jayesh on 24/11/14.
//  Copyright (c) 2014 WhiteSnow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PasswordRecoveryViewController : UIViewController

@property (strong,nonatomic) NSDictionary *posts;
@property (strong,nonatomic) NSMutableArray *post;

@property (strong, nonatomic) UIActivityIndicatorView *mySpinner;

- (IBAction)sendResetInstructionsButtonClicked:(id)sender;
- (IBAction)backgroundGesture:(id)sender;


@end
