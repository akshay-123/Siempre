//
//  SignInViewController.h
//  SampleSlider
//
//  Created by Jayesh on 22/11/14.
//  Copyright (c) 2014 WhiteSnow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignInViewController : UIViewController
<UITextFieldDelegate>

{
    IBOutlet UITextField *userNameTextfield;
    IBOutlet UITextField *passwordTextfield;
}
- (IBAction)signInClicked:(id)sender;


@property (strong,nonatomic) NSDictionary *posts;
@property (strong,nonatomic) NSMutableArray *post;

@property (strong, nonatomic) UIActivityIndicatorView *mySpinner;

- (IBAction)forgotPasswordButtonClicked:(id)sender; 

- (IBAction)backgroundTap:(id)sender;



@end
