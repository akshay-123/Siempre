//
//  DetailViewController.m
//  SampleSlider
//
//  Created by Jayesh on 12/5/14.
//  Copyright (c) 2014 WhiteSnow. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *msgBody;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"Detaisls ----->%@",self.detailsOfMSg);
    
    self.phoneNumber.text = [[self.detailsOfMSg objectForKey:@"fields"]valueForKey:@"caller_ID"];
    
    self.msgBody.text = [[self.detailsOfMSg objectForKey:@"fields"]valueForKey:@"body"];
    
    self.time.text = [[self.detailsOfMSg objectForKey:@"fields"]valueForKey:@"time"];
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

@end
