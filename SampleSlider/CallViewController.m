//
//  CallViewController.m
//  SampleSlider
//
//  Created by Jayesh on 26/11/14.
//  Copyright (c) 2014 WhiteSnow. All rights reserved.
//

#import "CallViewController.h"
#import "AppDelegate.h"
#import "MonkeyPhone.h"




@interface CallViewController ()
@end
//countryCodeData
@implementation CallViewController
@synthesize numberField,pickerViewContainer,countryCodeData,countryCodeTxtField,callingView;




- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Enter The Screen");
    numberField.layer.cornerRadius = 0;
    
   // self.view.backgroundColor = [UIColor redColor];
    

    pickerViewContainer.hidden = YES;
    NSString *path = [[NSBundle mainBundle]pathForResource:@"countryCode" ofType:@"plist"];
    
    countryCodeData = [[NSArray alloc]initWithContentsOfFile:path];
    
    countryCodeData = [countryCodeData sortedArrayUsingSelector:@selector(compare:)];
    
    
    //_dail2.layer.borderWidth = .5f;
   // _dail2.layer.borderColor = [[UIColor blackColor]CGColor];
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma marks -UIPickerView & Delegate Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;

}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [countryCodeData count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return countryCodeData[row];
}




- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSString *selectCountry = [countryCodeData objectAtIndex:row];
    countryCodeTxtField.text = selectCountry;
    
    switch (row) {
        case 0:
                numberField.text = @"+91";
            break;
        case 1:
            numberField.text = @"+92";
            break;
        case 2:
            numberField.text = @"+";
            break;
        case 3:
            numberField.text = @"+94";
            break;
        case 4:
            numberField.text = @"+95";
            break;
            
        default:
            break;
    }
    
}



- (IBAction)hidePicker:(id)sender {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    pickerViewContainer.frame = CGRectMake(0, 600, 320, 261);
    [UIView commitAnimations];
}

- (IBAction)tapGestureKeyboard:(id)sender {
    pickerViewContainer.hidden = YES;
    [self.view endEditing:YES];
}

- (IBAction)countryCodePicker:(id)sender {
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"countryCode" ofType:@"plist"];
    
    countryCodeData = [[NSArray alloc]initWithContentsOfFile:path];
    
    countryCodeData = [countryCodeData sortedArrayUsingSelector:@selector(compare:)];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    pickerViewContainer.hidden = NO;
    pickerViewContainer.frame = CGRectMake(0, 300, 320, 261);
    [UIView commitAnimations];

}

-(IBAction)dialButtonPressed:(id)sender
{
    NSLog(@"Call Button CLicked");
    /*AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    MonkeyPhone* phone = appDelegate.phone;
    NSLog(@"Connecting..");
    [phone connect:self.numberField.text];
    NSLog(@"Connection done...");*/
    
    
    
    AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    MonkeyPhone* phone = appDelegate.phone;
    NSLog(@"Number text --->%@",numberField.text);
    [phone connect:self.numberField.text];
    
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"callingScreenView"];
    
    /*callingView = [[callingVieController alloc] initWithNibName:@"callingViewController" bundle:nil];
    callingView.calledNumber  = numberField.text;
    
    [self.view addSubview: callingView.view];*/
    
    
   [self presentViewController:vc animated:YES completion:nil ];
   
    
    phoneNumber = numberField.text;
    NSLog(@"Phone Number--->%@",phoneNumber);
    
    
    
  
       
    
    
}

-(IBAction)hangupButtonPressed:(id)sender
{
    AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    MonkeyPhone* phone = appDelegate.phone;
    [phone disconnect];
    
}

- (IBAction)dialOne:(id)sender {
    
    pickerViewContainer.hidden = YES;
    numberField.text = [NSString stringWithFormat:@"%@1",numberField.text];
    
   
   
}



- (IBAction)dialtTWo:(id)sender {
    pickerViewContainer.hidden = YES;
    numberField.text = [NSString stringWithFormat:@"%@2",numberField.text];
}

- (IBAction)dialThree:(id)sender {
    pickerViewContainer.hidden = YES;
     numberField.text = [NSString stringWithFormat:@"%@3",numberField.text];
    
}

- (IBAction)dialFour:(id)sender {
    pickerViewContainer.hidden = YES;
     numberField.text = [NSString stringWithFormat:@"%@4",numberField.text];
}

- (IBAction)dialFive:(id)sender {
    pickerViewContainer.hidden = YES;
     numberField.text = [NSString stringWithFormat:@"%@5",numberField.text];
}

- (IBAction)dialSix:(id)sender {
    pickerViewContainer.hidden = YES;
     numberField.text = [NSString stringWithFormat:@"%@6",numberField.text];
}

- (IBAction)dialSeven:(id)sender {
    pickerViewContainer.hidden = YES;
     numberField.text = [NSString stringWithFormat:@"%@7",numberField.text];
}

- (IBAction)dialEight:(id)sender {
    pickerViewContainer.hidden = YES;
     numberField.text = [NSString stringWithFormat:@"%@8",numberField.text];
}

- (IBAction)dialNine:(id)sender {
    pickerViewContainer.hidden = YES;
     numberField.text = [NSString stringWithFormat:@"%@9",numberField.text];
}

- (IBAction)dialClear:(id)sender {
    pickerViewContainer.hidden = YES;
     numberField.text = @"";
}

- (IBAction)dialZero:(id)sender {
    pickerViewContainer.hidden = YES;
     numberField.text = [NSString stringWithFormat:@"%@0",numberField.text];
}

- (IBAction)dialbackspace:(id)sender{
    
    phoneNumber = numberField.text;
    
    if ([phoneNumber length] >0)
    {
        
        phoneNumber = [phoneNumber substringToIndex:[phoneNumber length] - 1];
        numberField.text = phoneNumber;
        
    } else {
        NSLog(@"Nocharacter.....");
    }
    
    
    
}


@end
