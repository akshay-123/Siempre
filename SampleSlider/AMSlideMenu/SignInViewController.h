//
//  SignInViewController.h
//  SampleSlider
//
//  Created by Jayesh on 22/11/14.
//  Copyright (c) 2014 WhiteSnow. All rights reserved.
//

#import <UIKit/UIKit.h>

#define URL_STRING @"http://54.174.166.2/"
@interface SignInViewController : UIViewController
<UITextFieldDelegate,UIApplicationDelegate>

- (IBAction)signInClicked:(id)sender;
	

@property (strong,nonatomic) NSDictionary *posts;
@property (strong,nonatomic) NSMutableArray *post;


@property (weak, nonatomic) IBOutlet UITextField *userNameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;

@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *myspinner;
- (IBAction)forgotPasswordButtonClicked:(id)sender; 

- (IBAction)backgroundTap:(id)sender;



@end
