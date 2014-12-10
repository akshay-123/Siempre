//
//  MainVCViewController.m
//  SampleSlider
//
//  Created by Jayesh on 11/18/14.
//  Copyright (c) 2014 WhiteSnow. All rights reserved.
//

#import "MainVCViewController.h"

@interface MainVCViewController ()

@end

@implementation MainVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // [[UINavigationBar appearance] setTintColor:[UIColor redColor]];
  //   [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"back_btn.png"]];
    //[[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"back_btn.png"]];
     //[[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"siempre.png"]];
   // [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"siempre.png"] forBarPosition: barMetrics:<#(UIBarMetrics)#>];
    
 //   [[UINavigationBar appearance] setBarTintColor:[UIColor  0x92A6B3]];

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
   //[[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x092A6B3)];
    
   // self.navigationController.title = @"Siempre";
   
    
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


-(CGFloat)leftMenuWidth

{
    return 250;
}

-(void)configureLeftMenuButton:(UIButton *)button
{
    
    [button setImage:[UIImage imageNamed:@"siempre.png"] forState:UIControlStateNormal];
}
@end
