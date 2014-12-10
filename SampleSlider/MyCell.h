//
//  MyCell.h
//  SampleSlider
//
//  Created by Jayesh on 12/5/14.
//  Copyright (c) 2014 WhiteSnow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCell : UITableViewCell

@property (weak,nonatomic)IBOutlet UIImageView *cellImage;
@property (weak,nonatomic)IBOutlet UILabel *phoneLabel;
@property (weak,nonatomic)IBOutlet UILabel *msgBody;

@end
