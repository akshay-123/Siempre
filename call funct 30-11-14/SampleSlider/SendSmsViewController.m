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
@synthesize sendSmsTextField,senderNumber,mySpinner;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mySpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    mySpinner.center = CGPointMake(160, 250);
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
    
    NSString *url1 = @"http://192.168.2.110:8000/SendSms/?sender=%2B12099894494&receiver=%2B917843072543&body=";
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
@end
