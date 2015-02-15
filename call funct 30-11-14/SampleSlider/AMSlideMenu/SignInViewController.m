//
//  SignInViewController.m
//  SampleSlider
//
//  Created by Jayesh on 22/11/14.
//  Copyright (c) 2014 WhiteSnow. All rights reserved.
//

#import "SignInViewController.h"
#import "AFNetworking.h"

@interface SignInViewController ()

@end

@implementation SignInViewController

@synthesize mySpinner;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mySpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    mySpinner.center = CGPointMake(160, 300);
    
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)signInClicked:(id)sender
{
    
    //NSLog(@"...Button Clicked...");
    
    [mySpinner startAnimating];
    mySpinner.hidesWhenStopped = YES;
    [self.view addSubview:mySpinner];

    
//    NSURL *baseURL = [NSURL URLWithString:@"http://192.168.0.120:8000/Home/?username=g.bagul3%40gmail.com&password=gaurav"];
//    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];

    //NSLog(@"%@",self.post);
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        [manager GET:@"http://192.168.2.110:8000/Home/?username=g.bagul3%40gmail.com&password=gb" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
            {
             self.posts = (NSDictionary *) responseObject;
                
             self.post = self.posts[@"loginCheck"][@"success"];

             NSLog(@"%@",self.post);

             if (self.post)
             {
                 [self performSegueWithIdentifier:@"SignInSegue" sender:self];
            
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
    
    // Create strings and integer to store the text info
    
    NSString *userName = [userNameTextfield text];
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
    /*
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
     
     NSString *userName = [defaults objectForKey:@"userName"];
     NSString *password = [defaults objectForKey:@"password"];
     int flag = [defaults integerForKey:@"flag"];
     
     NSLog(@"USER NAME : %@\nPASSWORD : %@\nFLAG : %d",userName,password,flag);
     */
}
- (IBAction)forgotPasswordButtonClicked:(id)sender
{
    [self performSegueWithIdentifier:@"forgotPasswordSegue" sender:self];
}

//Make keyboard move down using gesture
- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
    
}
@end
