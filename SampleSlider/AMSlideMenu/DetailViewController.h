//
//  DetailViewController.h
//  SampleSlider
//
//  Created by Jayesh on 12/5/14.
//  Copyright (c) 2014 WhiteSnow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong,nonatomic)NSDictionary *detailsOfMSg;


@property (weak, nonatomic) IBOutlet UIButton *reply;
@property (weak, nonatomic) IBOutlet UIView *msgView;
@property (weak, nonatomic) IBOutlet UILabel *msgType;
@property (weak, nonatomic) IBOutlet UITextView *textView;


@end
