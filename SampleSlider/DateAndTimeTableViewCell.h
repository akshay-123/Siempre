//
//  DateAndTimeTableViewCell.h
//  SampleSlider
//
//  Created by Jayesh on 19/12/14.
//  Copyright (c) 2014 WhiteSnow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateAndTimeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIImageView *callerImage;
@property (weak, nonatomic) IBOutlet UILabel *callerID;

@end
