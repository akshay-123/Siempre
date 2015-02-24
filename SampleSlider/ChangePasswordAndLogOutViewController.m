//
//  ChangePasswordAndLogOutViewController.m
//  SampleSlider
//
//  Created by Jayesh on 12/12/14.
//  Copyright (c) 2014 WhiteSnow. All rights reserved.
//

#import "ChangePasswordAndLogOutViewController.h"
#import "AFNetworking.h"
#import "HomeViewController.h"

@interface ChangePasswordAndLogOutViewController ()

@end

@implementation ChangePasswordAndLogOutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [[UINavigationBar appearance]setBackgroundColor:[UIColor grayColor]];
//    UIImageView* titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
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

- (IBAction)logoutButton:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Are you sure you want to logout?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alert show];
    

}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // the user clicked one of the OK/Cancel buttons
    if (buttonIndex == 1)
    {
        NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
        NSString *userName = [defs objectForKey:@"userName"];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSString  *serverAddress = [URL_LINk stringByAppendingString:[NSString stringWithFormat:@"appLogout?email_ID=%@",[userName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        [manager GET:serverAddress parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
              NSLog(@"Logout");
             UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
             UIViewController *vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"SignInMainStoryBoard"];
             [self presentViewController:vc animated:YES completion:nil ];
             
            
             NSDictionary * dict = [defs dictionaryRepresentation];
             NSLog(@"Dictionary ----%@",dict);
             
                 [defs removeObjectForKey:@"userName"];
                 [defs removeObjectForKey:@"password"];
                 [defs removeObjectForKey:@"flag"];

             
             [defs synchronize];
             

         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"LogOut Saved.....: %@", error);
             
         }];

        
        
        

        
    }
   }
@end
