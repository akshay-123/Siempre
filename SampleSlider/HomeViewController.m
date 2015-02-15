//
//  HomeViewController.m
//  SampleSlider
//
//  Created by Jayesh on 21/01/15.
//  Copyright (c) 2015 WhiteSnow. All rights reserved.
//

#import "HomeViewController.h"
#import "AFNetworking.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"Hello World");
    /*[[UINavigationBar appearance]setBackgroundColor:[UIColor grayColor]];
    UIImageView* titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    [titleImage setImage:[UIImage imageNamed:@"logo-siempre-transparent.png"]];
    self.navigationItem.titleView = titleImage;*/
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo-siempre-transparent.png"]];
    titleImageView.frame = CGRectMake(0, 0, 0, self.navigationController.navigationBar.frame.size.height); // Here I am passing
    titleImageView.contentMode=UIViewContentModeScaleAspectFit;
    self.navigationItem.titleView = titleImageView;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *username = [defaults objectForKey:@"userName"];
    
    if([username length] == 0)
    {
//        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//        NSString  *serverAddress = [NSString stringWithFormat:@"http://54.174.166.2/getLoginStatus/?email_ID=%@",[username stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//        [manager GET:serverAddress parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
//         {
//             NSLog(@"Email ID Present-->%@",username);
//             
//         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//             NSLog(@"Login Status Request.....: %@", error);
//             
//         }];
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"SignInMainStoryBoard"];
        [self presentViewController:vc animated:YES completion:nil ];

    }
    
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

- (IBAction)homeTextView:(id)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"phNumber"];
}
@end
