//
//  CallViewController.h
//  SampleSlider
//
//  Created by Jayesh on 26/11/14.
//  Copyright (c) 2014 WhiteSnow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCDevice.h"

@interface CallViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UITextField* _numberField;
    NSString* phoneNumber;
    
  
}



@property (weak, nonatomic) IBOutlet UITextField *numberField;
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
