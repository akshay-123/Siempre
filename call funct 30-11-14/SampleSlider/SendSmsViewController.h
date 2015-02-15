//
//  SendSmsViewController.h
//  SampleSlider
//
//  Created by Jayesh on 25/11/14.
//  Copyright (c) 2014 WhiteSnow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendSmsViewController : UIViewController

@property (strong,nonatomic) NSDictionary *posts;
@property (strong,nonatomic) NSMutableArray *post;

@property (strong, nonatomic) UIActivityIndicatorView *mySpinner;

@property (weak, nonatomic) IBOutlet UITextField *senderNumber;
@property (weak, nonatomic) IBOutlet UITextField *sendSmsTextField;
- (IBAction)sendSmsButtonClicked:(id)sender;


@end
