//
//  TableViewController.h
//  SampleSlider
//
//  Created by Jayesh on 12/2/14.
//  Copyright (c) 2014 WhiteSnow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController


@property (weak, nonatomic) IBOutlet UISegmentedControl *InboxAndSendSegmentedControll;
- (IBAction)segmetedControllBtn:(id)sender;
@property (strong, nonatomic) NSMutableArray* filteredTableData;

@property (nonatomic, retain) NSMutableArray *dateArray;
@property (nonatomic, retain) NSMutableArray *timeArray;
@property (nonatomic, retain) NSMutableArray *callerIDArray;

@property(strong,nonatomic)NSArray *dateArrayNew;
@property(strong,nonatomic)NSArray *timeArrayNew;
@property(strong,nonatomic)NSArray *callerIdArrayNew;

@end
	