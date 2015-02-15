//
//  SendSmsViewController.h
//  SampleSlider
//
//  Created by Jayesh on 25/11/14.
//  Copyright (c) 2014 WhiteSnow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface SendSmsViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>

@property (strong,nonatomic) NSDictionary *posts;
@property (strong,nonatomic) NSMutableArray *post;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *creditRemaingSpinner;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *textUsedSpinner;
@property (weak, nonatomic) IBOutlet UIImageView *creditRemainigImg;
@property (weak, nonatomic) IBOutlet UIImageView *textUsedImg;



@property (weak, nonatomic) IBOutlet UITextField *senderNumber;
@property (weak, nonatomic) IBOutlet UITextField *sendSmsTextField;
- (IBAction)sendSmsButtonClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *countryCodeName;
- (IBAction)tapGestureSendSms:(id)sender;

@property (nonatomic,strong)NSArray *countryCodeData;
@property (weak, nonatomic) IBOutlet UIView *pickerViewContainer;
- (IBAction)showPickerBtn:(id)sender;
- (IBAction)hidePickerView:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *textRemaining;


@property (weak, nonatomic) IBOutlet UILabel *textUsed;

- (IBAction)contactBtn:(id)sender;
@property (nonatomic, retain) ABPeoplePickerNavigationController *contacts;


@end
