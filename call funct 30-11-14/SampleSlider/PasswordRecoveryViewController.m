//
//  PasswordRecoveryViewController.m
//  SampleSlider
//
//  Created by Jayesh on 24/11/14.
//  Copyright (c) 2014 WhiteSnow. All rights reserved.
//

#import "PasswordRecoveryViewController.h"
#import "AFNetworking.h"

@interface PasswordRecoveryViewController ()

@end

@implementation PasswordRecoveryViewController

@synthesize mySpinner;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mySpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    mySpinner.center = CGPointMake(160, 300);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)sendResetInstructionsButtonClicked:(id)sender
{
    
    [mySpinner startAnimating];
    mySpinner.hidesWhenStopped = YES;
    [self.view addSubview:mySpinner];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:@"http://192.168.2.110:8000/recoverPassword?email_ID=g.bagul3%40gmail.com" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         self.posts = (NSDictionary *) responseObject;
         self.post = self.posts[@"mailSent"][@"success"];
         
         NSLog(@"%@",self.post);
         
         if (self.post)
         {
             [mySpinner stopAnimating];
             //[self performSegueWithIdentifier:@"SignInSegue" sender:self];
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email Sent" message:@"Mail Sent Successfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             [alert show];
         }
         else
         {
             NSLog(@"Unknown Error...........");
         }
         
         
         //NSLog(@"Unsuccessful");
         
         
         //NSLog(@"JSON: %@", responseObject);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         [mySpinner stopAnimating];
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error..!!" message:@"Error Connecting to Server...!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         [alert show];
     }];
    
    
}

- (IBAction)backgroundGesture:(id)sender {
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
