//
//  MainVCViewController.m
//  SampleSlider
//
//  Created by Jayesh on 11/18/14.
//  Copyright (c) 2014 WhiteSnow. All rights reserved.
//

#import "MainVCViewController.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "Reachability.h"
#import "HomeViewController.h"


@interface MainVCViewController ()

@end

@implementation MainVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //Back Color Button
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(presentView) name:@"receivePresentCallScreen" object:nil];
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"password.png"] forBarMetrics:UIBarMetricsDefault];
 //   [[UINavigationBar appearance] setBarTintColor:[UIColor  0x92A6B3]];

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
   [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x90A5B2)];
 //   [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"header.png"] forBarMetrics:UIBarMetricsDefault];

    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleNotification) name:@"handleNotification" object:nil];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [defaults objectForKey:@"userName"];
    
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        NSLog(@"There IS NO internet connection");
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please check Internet Connection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    } else {
        NSLog(@"There IS internet connection");
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSString *url = [URL_LINk stringByAppendingString:[NSString stringWithFormat:@"getLoginStatus?email_ID=%@",userName]];
        
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             
             if((userName == nil)&&[[[responseObject objectForKey:@"loginStatus"]valueForKey:@"login"]isEqualToString:@"false"]){
                 
                 UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                 UIViewController *vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"SignInMainStoryBoard"];
                 [self presentViewController:vc animated:YES completion:nil ];
             }else{
                 NSLog(@"Logged IN In Seeion User");
                 AppDelegate *delegate = [UIApplication sharedApplication].delegate;
                 [delegate registrationForTwilio];
             }
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
         }];

    }
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    
}
-(NSString *)segueIdentifierForIndexPathInLeftMenu:(NSIndexPath *)indexPath
{
    NSString *identifier;
    
     NSLog(@"Row--->%ld",(long)indexPath.row);
    switch (indexPath.row) {
           
        case 0:
            identifier = @"home";
            
            break;
        
        case 1:
            identifier = @"call";
            break;
        case  2:
            identifier = @"text";
            break;
            
        case  3:
            identifier = @"apps";
            break;
            
        case 4:
            identifier = @"setting";
            break;
        
                   }
    return identifier;
}

-(void)handleNotification{
    [self openContentViewControllerForMenu:AMSlideMenuLeft atIndexPath: [NSIndexPath indexPathForRow:2 inSection:0]];
}


-(CGFloat)leftMenuWidth

{
    return 250;
}

-(void)configureLeftMenuButton:(UIButton *)button
{
    
    CGRect frame = button.frame;
    frame.origin = (CGPoint) {0,0};
    frame.size = (CGSize){25,25};
    button.frame = frame;
    [button setImage:[UIImage imageNamed:@"togglebtnSlider.png"] forState:UIControlStateNormal];
    
}
-(void)presentView{
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"ReceivingCall"];
    
    [self presentViewController:vc animated:YES completion:nil ];

    
}

@end
