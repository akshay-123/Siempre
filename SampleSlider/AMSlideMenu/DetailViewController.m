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

@synthesize reply,msgView,msgType,textView;
- (void)viewDidLoad {
    
    // Do any additional setup after loading the view.
    reply.hidden = NO;
    reply.layer.cornerRadius = 4;
    msgView.layer.cornerRadius = 4;
    [_msgBody sizeToFit];
    
//    UIImageView* titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
//    [titleImage setImage:[UIImage imageNamed:@"logo-siempre-transparent.png"]];
//    self.navigationItem.titleView = titleImage;
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo-siempre-transparent.png"]];
    titleImageView.frame = CGRectMake(0, 0, 0, self.navigationController.navigationBar.frame.size.height); // Here I am passing
    titleImageView.contentMode=UIViewContentModeScaleAspectFit;
    self.navigationItem.titleView = titleImageView;
    
    NSLog(@"Detaisls ----->%@",self.detailsOfMSg);
    
    self.phoneNumber.text = [[self.detailsOfMSg objectForKey:@"fields"]valueForKey:@"caller_ID"];
    
    self.textView.text = [[self.detailsOfMSg objectForKey:@"fields"]valueForKey:@"body"];
    
    NSArray *time = [[[self.detailsOfMSg objectForKey:@"fields"]valueForKey:@"time"] componentsSeparatedByString:@" "];
    
    
    self.time.text = [time objectAtIndex:0];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[[self.detailsOfMSg objectForKey:@"fields"]valueForKey:@"callerid"] forKey:@"phNumber"];
    if([[defaults objectForKey:@"msgType"]isEqualToString:@"sent"]){
            self.msgType.text = @"Sent:";
    }else{
            self.msgType.text = @"Received:";
    }
    [super viewDidLoad];
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
