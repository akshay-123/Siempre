//
//  SendSmsViewController.m
//  SampleSlider
//
//  Created by Jayesh on 25/11/14.
//  Copyright (c) 2014 WhiteSnow. All rights reserved.
//

#import "SendSmsViewController.h"
#import "AFNetworking.h"

@interface SendSmsViewController ()

@end




@implementation SendSmsViewController
@synthesize sendSmsTextField,senderNumber,mySpinner,countryCodeData,countryCodeName,pickerViewContainer;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"Enter The Text Screen");
    self.mySpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    pickerViewContainer.hidden = YES;
    mySpinner.center = CGPointMake(160, 250);
    NSString *path = [[NSBundle mainBundle]pathForResource:@"countryCode" ofType:@"plist"];
    
    countryCodeData = [[NSArray alloc]initWithContentsOfFile:path];
    
    countryCodeData = [countryCodeData sortedArrayUsingSelector:@selector(compare:)];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//http://192.168.0.120:8000/SendSms/?username=g.bagul3%40gmail.com&password=gaurav

- (IBAction)sendSmsButtonClicked:(id)sender
{
    [mySpinner startAnimating];
    mySpinner.hidesWhenStopped = YES;
    [self.view addSubview:mySpinner];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString* body = sendSmsTextField.text;
    //NSString* sender_no = senderNumber.text;
    
    NSString *url1 = @"http://192.168.2.104:8080/SendSms/?sender=%2B12099894494&receiver=%2B917843072543&body=";
    NSString *url2 = [url1 stringByAppendingString:body];

    
    NSLog(@"%@",url2);
    
    NSString *url3 = [url2 stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    [manager GET:url3 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         self.posts = (NSDictionary *) responseObject;
         self.post = self.posts[@"SendSms"][@"success"];
         NSLog(@"%@",self.post);
         
         if (self.post)
         {
             //[self performSegueWithIdentifier:@"SignInSegue" sender:self];
             [mySpinner stopAnimating];
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message Sent" message:@"Message Delivered Successfully..." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             [alert show];
             
         }

     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         [mySpinner stopAnimating]; 
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error..!!" message:@"Error Connecting to Server...!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         [alert show];
     }];
    
}



#pragma mark _UIPickerView Datasource & Delegate Methods
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
    countryCodeName.text = selectCountry;
    
    switch (row) {
        case 0:
            senderNumber.text = @"+91";
            break;
        case 1:
            senderNumber.text = @"+92";
            break;
        case 2:
            senderNumber.text = @"+";
            break;
        case 3:
            senderNumber.text = @"+94";
            break;
        case 4:
            senderNumber.text = @"+95";
            break;
            
        default:
            break;
    }
    
}


- (IBAction)tapGestureSendSms:(id)sender {
    pickerViewContainer.hidden = YES;
    [self.view endEditing:YES];
}
- (IBAction)showPickerBtn:(id)sender {
    NSString *path = [[NSBundle mainBundle]pathForResource:@"countryCode" ofType:@"plist"];
    
    countryCodeData = [[NSArray alloc]initWithContentsOfFile:path];
    
    countryCodeData = [countryCodeData sortedArrayUsingSelector:@selector(compare:)];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    pickerViewContainer.hidden = NO;
    pickerViewContainer.frame = CGRectMake(0, 300, 320, 261);
    [UIView commitAnimations];

}

- (IBAction)hidePickerView:(id)sender {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    pickerViewContainer.frame = CGRectMake(0, 600, 320, 261);
    [UIView commitAnimations];
}
@end
