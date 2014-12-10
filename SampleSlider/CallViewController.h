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

@interface CallViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UITextField* _numberField;
    NSString* phoneNumber;
    callingVieController *callingView;
    
  
}

/*@property (strong, nonatomic) IBOutlet UIButton *dailone;

@property (weak, nonatomic) IBOutlet UIButton *dail2;


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

- (IBAction)hidePicker:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *pickerViewContainer;

@end
