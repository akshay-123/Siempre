//
//  ViewController.m
//  SampleSlider
//
//  Created by Jayesh on 12/3/14.
//  Copyright (c) 2014 WhiteSnow. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+AFNetworking.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *restuarantNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *restuarantImageView;
@property (weak, nonatomic) IBOutlet UILabel *restuarantAddressLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.restuarantNameLabel.text = [self.restuarantDetail objectForKey:@"name"];
    [self.restuarantImageView setImageWithURL:[NSURL URLWithString:[self.restuarantDetail objectForKey:@"icon"]]];
    self.restuarantAddressLabel.text = [self.restuarantDetail objectForKey:@"formatted_address"];

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
