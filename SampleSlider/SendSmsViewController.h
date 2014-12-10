//
//  SendSmsViewController.h
//  SampleSlider
//
//  Created by Jayesh on 25/11/14.
//  Copyright (c) 2014 WhiteSnow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendSmsViewController : UIViewController< UIPickerViewDataSource,UIPickerViewDelegate>

@property (strong,nonatomic) NSDictionary *posts;
@property (strong,nonatomic) NSMutableArray *post;

@property (strong, nonatomic) UIActivityIndicatorView *mySpinner;

@property (weak, nonatomic) IBOutlet UITextField *senderNumber;
@property (weak, nonatomic) IBOutlet UITextField *sendSmsTextField;
- (IBAction)sendSmsButtonClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *countryCodeName;
- (IBAction)tapGestureSendSms:(id)sender;

@property (nonatomic,strong)NSArray *countryCodeData;
@property (weak, nonatomic) IBOutlet UIView *pickerViewContainer;
- (IBAction)showPickerBtn:(id)sender;
- (IBAction)hidePickerView:(id)sender;



@end
