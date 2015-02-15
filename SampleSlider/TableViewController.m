//
//  TableViewController.m
//  SampleSlider
//
//  Created by Jayesh on 12/2/14.
//  Copyright (c) 2014 WhiteSnow. All rights reserved.
//

#import "TableViewController.h"
#import "ViewController.h"
#import "AFNetworking.h"
#import "DateAndTimeTableViewCell.h"
#import "MBProgressHUD.h"
#import "CallViewController.h"

@interface TableViewController ()<MBProgressHUDDelegate>{
    
    MBProgressHUD *HUD;
}

@property (strong, nonatomic) NSArray *googlePlacesArrayFromAFNetworking;


@property (strong, nonatomic) NSArray *missedCallArray;



@end

@implementation TableViewController

@synthesize InboxAndSendSegmentedControll,filteredTableData,dateArray,timeArray,callerIDArray;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [[UINavigationBar appearance]setBackgroundColor:[UIColor grayColor]];
//    UIImageView* titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
//    [titleImage setImage:[UIImage imageNamed:@"logo-siempre-transparent.png"]];
//    self.navigationItem.titleView = titleImage;
    
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo-siempre-transparent.png"]];
    titleImageView.frame = CGRectMake(0, 0, 0, self.navigationController.navigationBar.frame.size.height); // Here I am passing
    titleImageView.contentMode=UIViewContentModeScaleAspectFit;
    self.navigationItem.titleView = titleImageView;

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *userName = [defaults objectForKey:@"userName"];
    NSString *password = [defaults objectForKey:@"password"];
    int flag = [defaults integerForKey:@"flag"];
    
    NSLog(@"Inherited Values userName ----->%@",userName);
    NSLog(@"Inherited Values Password ----->%@",password);
    NSLog(@"Inherited Values flag----->%d",flag);

    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    dateArray = [[NSMutableArray alloc] init];
    timeArray = [[NSMutableArray alloc] init];
    callerIDArray = [[NSMutableArray alloc]init];
    
    [self callLogs];
    
    UIView *headerview = [[UIView alloc] initWithFrame:CGRectMake(0,0, 100, 80)];
    headerview.backgroundColor = [UIColor colorWithRed:(39/255.0) green:(48/255.0) blue:(56/255.0) alpha:alphaStage];
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc]initWithItems:@[@"ALL",@"MISSED"]];
   // [segmentControl setSegmentedControlStyle:UISegmentedControlStyleBar];
    [segmentControl addTarget:self action:@selector(segmentedControlValueDidChange:) forControlEvents:UIControlEventValueChanged];
    [segmentControl setSelectedSegmentIndex:0];
    segmentControl.frame = CGRectMake(30, 30, 250, 30);
    [headerview addSubview:segmentControl];
    segmentControl.tintColor = [UIColor orangeColor];
    segmentControl.layer.cornerRadius = 4;
    segmentControl.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = headerview;
    }

-(void)spinner{
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    HUD.dimBackground = YES;
    
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    
    // Show the HUD while the provided method executes in a new thread
    //[HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
   // [HUD show:YES];
}

-(void)myTask{
    sleep(2);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)callLogs//127.0.0.1:8000/missedCall?email_ID=g.bagul3%40gmail.com
{
    /* NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
     
     NSString *userName = [defaults objectForKey:@"userName"];
     NSLog(@"username---->%@",userName);
     
     NSString *newString = [userName  stringByReplacingOccurrencesOfString:@"@" withString:@"%40"];
     
     NSLog(@"newString---->%@",newString);
     NSString *baseUrl =[NSString stringWithFormat:@"http://192.168.2.106:8000/callLogs?email_ID=%@",newString];
     
     NSURL *url = [NSURL URLWithString:baseUrl];*/
            
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *userName = [defaults objectForKey:@"userName"];
    NSLog(@"username---->%@",userName);
    
    
    NSString  *serverAddress = [NSString stringWithFormat:@"http://54.174.166.2/callLogs?email_ID=%@",userName];
    
    NSURL *url = [NSURL URLWithString:serverAddress];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //AFNetworking asynchronous url request
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        HUD.hidden =YES;
        
        self.googlePlacesArrayFromAFNetworking = [responseObject objectForKey:@"callLogArray"];
        
        
        NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
        [DateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateString = [DateFormatter stringFromDate:[NSDate date]];
        NSLog(@"Date--->%@",dateString);
        
        NSDateComponents *components = [[NSDateComponents alloc] init] ;
        [components setDay:-1];
        
        NSDate *yesterday = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:[NSDate date] options:0];
        NSString *yesterdayDateStr = [DateFormatter stringFromDate:yesterday];
        
        NSLog(@"Yesterday--->%@",[DateFormatter stringFromDate:yesterday]);
        
        for (NSDictionary *datAndTime in self.googlePlacesArrayFromAFNetworking) {
            
            NSString *dict = [[datAndTime valueForKey:@"fields"]valueForKey:@"time"];
            NSString *callerID = [[datAndTime valueForKey:@"fields"]valueForKey:@"callerid"];
            NSArray* timestampStr = [dict componentsSeparatedByString: @" "];
            NSString* day = [timestampStr objectAtIndex: 0];
            NSString* time = [timestampStr objectAtIndex: 1];
            
            if([dateString isEqualToString:day]){
                [dateArray addObject:@"Today"];
            }else if([day isEqualToString:yesterdayDateStr]){
                [dateArray addObject:@"Yesterday"];
            }else{
                [dateArray addObject:day];
            }
            [timeArray addObject:time];
            [callerIDArray addObject:callerID];
            
        }
        
        
        
        //NSLog(@"dateArray---->%@",dateArray);
        //NSLog(@"newDateArray---->%@",newDateArray);
        
        
        
       // NSLog(@"The Array: %@",self.googlePlacesArrayFromAFNetworking);
        
        
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Request Failed: %@, %@", error, error.userInfo);
        
    }];
    
    [operation start];
    HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    HUD.delegate = self;
    
    
}

-(void)missedCalls
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *userName = [defaults objectForKey:@"userName"];
    
    NSString  *serverAddress = [NSString stringWithFormat:@"http://54.174.166.2/missedCallLogs?email_ID=%@",userName];
    
    NSURL *url = [NSURL URLWithString:serverAddress];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //AFNetworking asynchronous url request
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [HUD hide:YES];
        
         self.googlePlacesArrayFromAFNetworking =[[self.googlePlacesArrayFromAFNetworking reverseObjectEnumerator]allObjects];
        
        self.googlePlacesArrayFromAFNetworking = [responseObject objectForKey:@"callLogArray"];
        
       
        
        NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
        [DateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateString = [DateFormatter stringFromDate:[NSDate date]];
        
        NSDateComponents *components = [[NSDateComponents alloc] init] ;
        [components setDay:-1];
        
        NSDate *yesterday = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:[NSDate date] options:0];
        NSString *yesterdayDateStr = [DateFormatter stringFromDate:yesterday];
        
        for (NSDictionary *datAndTime in self.googlePlacesArrayFromAFNetworking) {
            
            NSString *dict = [[datAndTime valueForKey:@"fields"]valueForKey:@"time"];
            NSString *callerID = [[datAndTime valueForKey:@"fields"]valueForKey:@"callerid"];
            NSArray* timestampStr = [dict componentsSeparatedByString: @" "];
            NSString* day = [timestampStr objectAtIndex: 0];
            NSString* time = [timestampStr objectAtIndex: 1];
        
            
           
            if([dateString isEqualToString:day]){
                [dateArray addObject:@"Today"];
            }else if([day isEqualToString:yesterdayDateStr]){
                [dateArray addObject:@"Yesterday"];
            }else{
                [dateArray addObject:day];
            }
            [timeArray addObject:time];

            [callerIDArray addObject:callerID];
            
        }
        
        NSLog(@"CallerId----->%@",callerIDArray);	
        
        NSLog(@"The Array: %@",self.googlePlacesArrayFromAFNetworking);
        
        for (NSDictionary *call in self.googlePlacesArrayFromAFNetworking) {
            
            NSDictionary *dict = [call valueForKey:@"fields"];
            NSLog(@"Dictionary---->%@",dict);
            
        }
        
        [self.tableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Request Failed: %@, %@", error, error.userInfo);
        
    }];
    
    [operation start];

    HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    HUD.delegate = self;
    //HUD.mode = MBProgressHUDModeDeterminate;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    //return 1;
    return [self.googlePlacesArrayFromAFNetworking count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    /* UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath] ;*/
    DateAndTimeTableViewCell *mycell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSDictionary *tempDictionary= [self.googlePlacesArrayFromAFNetworking objectAtIndex:indexPath.row];
    
    UIImage * outgoing = [UIImage imageNamed:@"outgoingCall.png"];
    UIImage * incoming = [UIImage imageNamed:@""];
    UIImage * missed = [UIImage imageNamed:@"incomingCall.png"];
    
    /*switch (indexPath.row) {
     case 0:
     cell.imageView.image = missed;
     break;
     
     case 1:
     cell.imageView.image = called;
     break;
     default:
     cell.imageView.image = missed;
     break;
     }*/
    
    /* NSArray *str =[tempDictionary ];
     int count = [str count];
     NSDictionary  *tmp;
     for (int i= 0; i<; i++) {
     if ([[[tempDictionary objectForKey:@"fields"]valueForKey:@"type"]isEqualToString:@"missed"]) {
     tmp = [[tempDictionary objectForKey:@"fields"]valueForKey:@"caller_ID"];
     
     }
     
     NSLog(@" ARRRRAYYYYYYY------->%@",tmp);
     }*/
    
    NSString *str = [[tempDictionary objectForKey:@"fields"]valueForKey:@"type"];
    
    if([str isEqualToString:@"missed"])
    {
        mycell.callerImage.image = missed;
    }
    if( [str isEqualToString:@"received"])
    {
        mycell.callerImage.image = incoming;
    }
    if([str isEqualToString:@"dialed"])
    {
        mycell.callerImage.image = outgoing;
    }
    
    /*NSArray *dateArrayNew = [[dateArray reverseObjectEnumerator]allObjects];
    NSArray *timeArrayNew = [[timeArray reverseObjectEnumerator]allObjects];
    NSArray *callerIDArrayNew = [[callerIDArray reverseObjectEnumerator]allObjects];
    //cell.textLabel.text = ;
    mycell.date.text = dateArrayNew[indexPath.row];
    mycell.time.text = timeArrayNew[indexPath.row];
    //mycell.callerID.text = [[tempDictionary objectForKey:@"fields"]valueForKey:@"caller_ID"];
    mycell.callerID.text = callerIDArrayNew[indexPath.row];*/
    
    mycell.date.text = dateArray[indexPath.row];
    mycell.time.text = timeArray[indexPath.row];
    //mycell.callerID.text = [[tempDictionary objectForKey:@"fields"]valueForKey:@"caller_ID"];
    mycell.callerID.text = callerIDArray[indexPath.row];
    
    return mycell;
}

#pragma mark - Prepare For Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    CallViewController *callViewController = (CallViewController*)segue.destinationViewController;
  //  callViewController.detailsOfCallLogs = [[[self.googlePlacesArrayFromAFNetworking reverseObjectEnumerator]allObjects]objectAtIndex:indexPath.row] ;
    callViewController.detailsOfCallLogs = [self.googlePlacesArrayFromAFNetworking objectAtIndex:indexPath.row];
    
    
}

-(void) segmentedControlValueDidChange:(UISegmentedControl *)segment{
    if (segment.selectedSegmentIndex == 0) {
        NSLog(@"All Clicked");
       [self callLogs];
        
    } else {
        NSLog(@"Missed Clicked");
        [self missedCalls];
        
    }

}




- (IBAction)segmetedControllBtn:(id)sender {
    if (InboxAndSendSegmentedControll.selectedSegmentIndex == 0) {
        NSLog(@"All Clicked");
        [self callLogs];
        
    } else {
        NSLog(@"Missed Clicked");
        [self missedCalls];
        
    }
    
}
@end
