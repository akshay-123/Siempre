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

@synthesize mySpinner,EmailIDTxt;

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
    
    
    
    
    if ([EmailIDTxt.text isEqualToString:@""]) {
        [mySpinner stopAnimating];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter the Email" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        NSString *serverAddress =[NSString stringWithFormat:@"http://54.174.166.2/recoverPassword?email_ID=%@",EmailIDTxt.text];
        [manager GET:serverAddress parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             self.posts = (NSDictionary *) responseObject;
             NSString *response = self.posts[@"mailSent"][@"success"];
             
             NSLog(@"%@",self.post);
             
             
             if ([response isEqualToString:@"true"])
             {
                 [mySpinner stopAnimating];
                 //[self performSegueWithIdentifier:@"SignInSegue" sender:self];
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message Sent" message:@"Reset Instructions are sent to your email" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [alert show];
             }
             else
             {
                 [mySpinner stopAnimating];
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Invalid Email ID" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [alert show];
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

- (IBAction)cancel:(id)sender {
    
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"navigationMainController"];
//    [self presentViewController:vc animated:YES completion:nil ];
    [self dismissViewControllerAnimated:true completion:nil];

    
    
}
@end
