//
//  SignInViewController.m
//  SampleSlider
//
//  Created by Jayesh on 22/11/14.
//  Copyright (c) 2014 WhiteSnow. All rights reserved.
//

#import "SignInViewController.h"
#import "AFNetworking.h"
#import "Reachability.h"
#import "AppDelegate.h"
#import <AddressBook/AddressBook.h>
#import "MBProgressHUD.h"
#import "HomeViewController.h"
#import <unistd.h>


#define SCREENSHOT_MODE 0



#ifndef kCFCoreFoundationVersionNumber_iOS_8_0
#define kCFCoreFoundationVersionNumber_iOS_7_0 847.20
#endif



@interface SignInViewController ()<MBProgressHUDDelegate,UITextFieldDelegate>{
   
    Reachability* reachability;
    MBProgressHUD *HUD;
    long long expectedLength;
    long long currentLength;
}

@end

@implementation SignInViewController

@synthesize myspinner,userNameTextfield,passwordTextfield;

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //UIView *content = self.view;
    //[content.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //((UIScrollView *)self.view).contentSize = content.bounds.size;
    
    /*self.myspinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
     self.myspinner.center = CGPointMake(160, 300);*/
    [userNameTextfield setBorderStyle:UITextBorderStyleNone];
    userNameTextfield.backgroundColor = [UIColor whiteColor];
    
    [passwordTextfield setBorderStyle:UITextBorderStyleNone];
    passwordTextfield.backgroundColor = [UIColor whiteColor];
   // self.myspinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [UIDevice currentDevice].proximityMonitoringEnabled = YES;
    self.userNameTextfield.delegate = self;
    self.passwordTextfield.delegate = self;

}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signInClicked:(id)sender
{
  //  [self.myspinner startAnimating];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
    hud.delegate = self;
    hud.labelText = @"Authenticating";
    
//   [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
    //[hud show:NO];
    
    //NSLog(@"...Button Clicked...");
    /*self.myspinner.hidden=NO;
    [self.myspinner startAnimating];
    self.myspinner.hidesWhenStopped = YES;
    [self.view addSubview:myspinner];*/

    
//    NSURL *baseURL = [NSURL URLWithString:@"http://192.168.0.120:8000/Home/?username=g.bagul3%40gmail.com&password=gaurav"];
//    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];

    //NSLog(@"%@",self.post);
    
    
    
    //NSString *serverAddress = @"http://192.168.2.140:8000/appLogin";
//    NSString *getUrl =[NSString stringWithFormat:%@?email_ID=%@&password=%@",serverAddress,];

                       
       /* NSDictionary *params = @{@"email_ID":userNameTextfield,
                                 @"password":passwordTextfield};*/
        
    //    NSURL *baseUrl =[NSURL URLWithString:@"http://192.168.0.120:8000/Home/" ];
//        NSLog(@"user NAem--->%@",);
        NSLog(@"user Name--->%@",passwordTextfield.text);
    
       
 
//       NSString  *serverAddress = [NSString stringWithFormat:@"http://54.174.166.2/appLogin?email_ID=%@&password=%@",userNameTextfield.text,passwordTextfield.text];
    
    
    
    NSString  *serverAddress = [URL_LINk stringByAppendingString:[NSString stringWithFormat:@"appLogin?email_ID=%@&password=%@",userNameTextfield.text,passwordTextfield.text]];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSLog(@"Server Address--->%@",serverAddress);
    if([userNameTextfield.text isEqualToString:@" "]){
       
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please Enter the Email Id or Password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        

        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [manager GET:serverAddress parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
            {
             self.posts = (NSDictionary *) responseObject;
                
             NSString *value = self.posts[@"loginCheck"][@"success"];
             
                
             if ([value isEqualToString:@"true"])
             {
                 
                
                 NSString *userName = [userNameTextfield text];
                 NSString *password = [passwordTextfield text];
                 NSInteger flag = true;
                 
                 
                 
                 [defaults setObject:userName forKey:@"userName"];
                 [defaults setObject:password forKey:@"password"];
                 [defaults setInteger:flag forKey:@"flag"];
                 
                 [defaults synchronize];
                 
                
                AppDelegate *delegate = [UIApplication sharedApplication].delegate;
                [delegate registrationForTwilio];
                 
                
                 
                 [self dismissViewControllerAnimated:YES completion:nil];
                 [self.myspinner startAnimating];
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
            
             }else if ([value isEqualToString:@"inactive"]) {
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"This user is inactive. Please contact administrator" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 [alert show];
                 
             }else{
                                  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter the Correct Email Id or Password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [alert show];
                 
             }
              
                NSString *deviceToken = [defaults objectForKey:@"deviceTokenStr"];
                UILocalNotification* localNotification = [[UILocalNotification alloc] init];
                localNotification.alertBody = @"Your alert message";
                
                AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                NSString  *serverAddress = [URL_LINk stringByAppendingString:[NSString stringWithFormat:@"updateApnsRegId?email_ID=%@&regId=%@&device_type=iphone",[userNameTextfield.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[deviceToken stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
                [manager GET:serverAddress parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
                 {
                     NSLog(@"Saved");
                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     NSLog(@"Not Saved.....: %@", error);
                     
                 }];
                
        //NSLog(@"JSON: %@", responseObject);
             
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       NSLog(@"Error: %@", error);
        
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Error Connecting server. Please contact adminstrator." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [alert show];
    }];
    
}


    
    
    // Create strings and integer to store the text info
    
  /*  NSString *userName = [userNameTextfield text];
    NSString *password = [passwordTextfield text];
    NSInteger flag = true;
    
    //Store User Name & Password.
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:userName forKey:@"userName"];
    [defaults setObject:password forKey:@"password"];
    [defaults setInteger:flag forKey:@"flag"];
    
    [defaults synchronize];
    
    NSLog(@"Data saved");
    
    // Get the stored data before the view loads
    
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
     
     NSString *userName = [defaults objectForKey:@"userName"];
     NSString *password = [defaults objectForKey:@"password"];
     int flag = [defaults integerForKey:@"flag"];
     
     NSLog(@"USER NAME : %@\nPASSWORD : %@\nFLAG : %d",userName,password,flag);
     */
}

- (void)myTask {
    // Do something usefull in here instead of sleeping ...
    sleep(1);
}
- (IBAction)forgotPasswordButtonClicked:(id)sender
{
    [self performSegueWithIdentifier:@"forgotPasswordSegue" sender:self];
}

//Make keyboard move down using gesture
- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == self.userNameTextfield){
        [textField setReturnKeyType:UIReturnKeyDone];
        [textField resignFirstResponder];
    }else{
        [textField setReturnKeyType:UIReturnKeyDone];
        [textField resignFirstResponder];
    }
         return NO;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [HUD show:NO];
}


-(void)spinner{
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    HUD.dimBackground = YES;
    
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    
    // Show the HUD while the provided method executes in a new thread
    //[HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
     [HUD show:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
     NSLog(@"TxtEditing");
    if(textField == self.userNameTextfield){
       
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.view.frame = CGRectMake(self.view.frame.origin.x, (self.view.frame.origin.y - 25), self.view.frame.size.width,self.view.frame.size.height);
        [UIView commitAnimations];
    }else if(textField == self.passwordTextfield){
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.view.frame = CGRectMake(self.view.frame.origin.x, (self.view.frame.origin.y - 50), self.view.frame.size.width,self.view.frame.size.height);
        [UIView commitAnimations];
    }

}

- (void)textFieldDidEndEditing:(UITextField *)textfield{
    if(textfield == self.userNameTextfield){
         NSLog(@"TxtEditing");
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.view.frame = CGRectMake(self.view.frame.origin.x, (self.view.frame.origin.y + 25), self.view.frame.size.width,self.view.frame.size.height);
        [UIView commitAnimations];
    }else if(textfield == self.passwordTextfield){
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.view.frame = CGRectMake(self.view.frame.origin.x, (self.view.frame.origin.y + 50), self.view.frame.size.width,self.view.frame.size.height);
        [UIView commitAnimations];
    }


   }

@end
