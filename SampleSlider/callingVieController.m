//
//  callingVieController.m
//  SampleSlider
//
//  Created by Jayesh on 12/1/14.
//  Copyright (c) 2014 WhiteSnow. All rights reserved.
//

#import "callingVieController.h"
#import "AppDelegate.h"
#import "MonkeyPhone.h"
@interface callingVieController ()

@end

@implementation callingVieController
@synthesize calledPhoneNumber,calledNumber;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.jjjsw37e1`
    
  }

- (void)didReceiveMemoryWarning {
    calledPhoneNumber.text = calledNumber.text;
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




- (IBAction)callEndBtn:(id)sender {
    AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    MonkeyPhone* phone = appDelegate.phone;
    [phone disconnect];
    
    //UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //UIViewController *vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"navigationMainController"];
    [self dismissViewControllerAnimated:true completion:nil];
    
    
}
@end
