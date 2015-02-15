//
//  CallViewController.h
//  SampleSlider
//
//  Created by Jayesh on 26/11/14.
//  Copyright (c) 2014 WhiteSnow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCDevice.h"
#import "callingVieController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface CallViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,ABPeoplePickerNavigationControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,TCDeviceDelegate,TCConnectionDelegate>
{
    UITextField* textFields;

    NSString* phoneNumber;
    callingVieController *callingView;
    
  
}
- (IBAction)phoneContact:(id)sender;
- (IBAction)additionSign:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *creditSpinner;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *minuteUsedSpinner;
@property (weak, nonatomic) IBOutlet UIImageView *creditImg;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *creditUsedImg;
@property (nonatomic, retain) ABPeoplePickerNavigationController *contacts;
/*@property (weak, nonatomic) IBOutlet UIButton *dail2;


@property (weak, nonatomic) IBOutlet UIButton *dail3;

@property (weak, nonatomic) IBOutlet UIButton *dail4;

@property (weak, nonatomic) IBOutlet UIButton *dail5;


@property (weak, nonatomic) IBOutlet UIButton *dail6;


@property (weak, nonatomic) IBOutlet UIButton *dail7;
@property (weak, nonatomic) IBOutlet UIButton *dail8;

@property (weak, nonatomic) IBOutlet UIButton *dail9;

@property (weak, nonatomic) IBOutlet UIButton *dail0;

@property (weak, nonatomic) IBOutlet UIButton *deleteNumber;*/


@property (nonatomic) callingVieController *callingView;

@property (retain, nonatomic) IBOutlet UITextField *numberField;
@property (nonatomic,strong)NSArray *countryCodeData;

@property (weak, nonatomic) IBOutlet UITextField *countryCodeTxtField;

@property (weak, nonatomic) IBOutlet UIPickerView *picker;

@property(strong, retain)IBOutlet TCDevice* phone;
@property(strong, retain)IBOutlet TCConnection* phConnection;

- (IBAction)tapGestureKeyboard:(id)sender;

- (IBAction)countryCodePicker:(id)sender;

-(IBAction)dialButtonPressed:(id)sender;
-(IBAction)hangupButtonPressed:(id)sender;



- (IBAction)dialOne:(id)sender;
- (IBAction)dialtTWo:(id)sender;
- (IBAction)dialThree:(id)sender;
- (IBAction)dialFour:(id)sender;
- (IBAction)dialFive:(id)sender;
- (IBAction)dialSix:(id)sender;
- (IBAction)dialSeven:(id)sender;
- (IBAction)dialEight:(id)sender;
- (IBAction)dialNine:(id)sender;

- (IBAction)dialClear:(id)sender;
- (IBAction)dialZero:(id)sender;
- (IBAction)dialbackspace:(id)sender;

- (IBAction)hidePickerView:(id)sender;


@property (strong,nonatomic)NSDictionary *detailsOfCallLogs;

@property (weak, nonatomic) IBOutlet UIView *pickerViewContainer;

@property (weak, nonatomic) IBOutlet UILabel *creditsBalance;

@property (weak, nonatomic) IBOutlet UILabel *callCreditsUsed;

@property(nonatomic,assign) id<TCConnectionDelegate> delegate;

@end
