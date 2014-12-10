//
//  MessageBoxTableViewController.h
//  SampleSlider
//
//  Created by Jayesh on 12/5/14.
//  Copyright (c) 2014 WhiteSnow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageBoxTableViewController : UITableViewController <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *InboxAndSend;
- (IBAction)InboxAndSendSegmentBtn:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *myTableView;


@property NSArray *phone,*msg;

@end
