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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:@"http://192.168.2.104:8080/Home/?username=g.bagul3%40gmail.com&password=gb" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         self.posts = (NSDictionary *) responseObject;
         
         self.post = self.posts[@"loginCheck"][@"success"];
         
         NSLog(@"%@",self.post);
         
         
         
         if (self.post)
         {
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error..!!" message:@"Password changed Sucessfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             [alert show];
           
         }
         
         
         NSLog(@"successful");
         
         
         //NSLog(@"JSON: %@", responseObject);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           NSLog(@"Error: %@", error);
          /*[mySpinner stopAnimating];*/
          UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error..!!" message:@"Error Connecting to Server...!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
          [alert show];
     }];
    
    
}


@end
