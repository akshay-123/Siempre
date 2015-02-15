//
//  ZZMainViewController.h
//  PayPal-iOS-SDK-Sample-App
//
//  Copyright (c) 2014, PayPal
//  All rights reserved.
//

#import "PayPalMobile.h"


@interface ZZMainViewController : UIViewController <PayPalPaymentDelegate, UIPopoverControllerDelegate>

@property(nonatomic, strong, readwrite) NSString *environment;
@property(nonatomic, assign, readwrite) BOOL acceptCreditCards;
@property(nonatomic, strong, readwrite) NSString *resultText;
@property(nonatomic, strong, readwrite) NSString *pn;
@property(nonatomic, strong, readwrite) NSString *pp;
@property(nonatomic, strong, readwrite) NSString *pc;
@property (strong,nonatomic)NSArray * packsPaypal;



@property (nonatomic, retain) NSMutableArray *packagepay;
@property (nonatomic, retain) NSMutableArray *creditspay;
@property (nonatomic, retain) NSMutableArray *amountspay;

- (IBAction)buyCredits:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end
