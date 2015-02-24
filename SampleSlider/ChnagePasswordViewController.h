//
//  ChnagePasswordViewController.h
//  SampleSlider
//
//  Created by Jayesh on 12/3/14.
//  Copyright (c) 2014 WhiteSnow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface ChnagePasswordViewController : UIViewController<UIAlertViewDelegate,MBProgressHUDDelegate>
- (IBAction)changePasswordBtn:(id)sender;

@property (strong,nonatomic) NSDictionary *posts;
@property (strong,nonatomic) NSMutableArray *post;

@property (weak, nonatomic) IBOutlet UITextField *currentpassword;

@property (weak, nonatomic) IBOutlet UITextField *newpassword;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassword;

- (IBAction)tapGesture:(id)sender;


@end
