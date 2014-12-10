//
//  Packs.m
//  Paypal
//
//  Created by Jayesh Kitukale on 12/1/14.
//  Copyright (c) 2014 Tungsten. All rights reserved.
//

#import "Packs.h"

@implementation Packs
@synthesize packName = _packName;
@synthesize amount = _price;
@synthesize credits = _credits;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
