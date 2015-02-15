//
//  ChnagePasswordViewController.m
//  SampleSlider
//
//  Created by Jayesh on 12/3/14.
//  Copyright (c) 2014 WhiteSnow. All rights reserved.
//

#import "ChnagePasswordViewController.h"
#import "AFNetworking.h"
@interface ChnagePasswordViewController ()

@end

@implementation ChnagePasswordViewController
@synthesize currentpassword,newpassword,confirmPassword;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [[UINavigationBar appearance]setBackgroundColor:[UIColor grayColor]];
//    UIImageView* titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
//    [titleImage setImage:[UIImage imageNamed:@"logo-siempre-transparent.png"]];
//    self.navigationItem.titleView = titleImage;
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo-siempre-transparent.png"]];
    titleImageView.frame = CGRectMake(0, 0, 0, self.navigationController.navigationBar.frame.size.height); // Here I am passing
    titleImageView.contentMode=UIViewContentModeScaleAspectFit;
    self.navigationItem.titleView = titleImageView;
}

- (void)didReceiveMemoryWarning {
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

- (IBAction)changePasswordBtn:(id)sender {
    
    
    
    
    if ([currentpassword.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter the Current Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag =1;
        [alert show];
    } else if ([newpassword.text isEqualToString:@"" ]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter the New Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag =2;
        [alert show];
    }else if ([confirmPassword.text isEqualToString:@""]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter the Confirm Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 3;
        [alert show];
    }else if (![newpassword.text isEqualToString:confirmPassword.text]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Passwords do not match." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 4;
        [alert show];
    }else{

    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *userName = [defaults objectForKey:@"userName"];
    NSLog(@"username---->%@",userName);
    
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *serverAddress = [NSString stringWithFormat:@"http://54.174.166.2/changePassword?email_ID=%@&currentPassword=%@&newPassword=%@",userName,currentpassword.text,newpassword.text];
    
    
    [manager GET:serverAddress parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         self.posts = (NSDictionary *) responseObject;
         
         self.post = self.posts[@"PasswordCheck"][@"success"];
         NSString *value = self.posts[@"PasswordCheck"][@"success"];
         
//         NSLog(@"%@",self.post);
         
         if ([value isEqualToString:@"true"])
         {
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Password Changed Sucessfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             alert.tag = 5;
             [alert show];
             
         }else{
             
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Password Not Changed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             alert.tag = 6;
             [alert show];
         }
         
         //NSLog(@"JSON: %@", responseObject);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           NSLog(@"Error: %@", error);
          /*[mySpinner stopAnimating];*/
          UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error..!!" message:@"Error Connecting to Server...!!!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         [alert setTag:7];
          [alert show];
     }];
    
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 5)
    {
        NSLog(@"Alert Clicked");
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"navigationMainController"];
        [self presentViewController:vc animated:YES completion:nil ];

    }
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}



- (IBAction)tapGesture:(id)sender {
      [self.view endEditing:YES];
}
@end
