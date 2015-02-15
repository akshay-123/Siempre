//
//  MessageBoxTableViewController.m
//  SampleSlider
//
//  Created by Jayesh on 12/5/14.
//  Copyright (c) 2014 WhiteSnow. All rights reserved.
//

#import "MessageBoxTableViewController.h"
#import "AFNetworking.h"
#import "DetailViewController.h"
#import "MyCell.h"
#import "MBProgressHUD.h"


@interface MessageBoxTableViewController ()<MBProgressHUDDelegate>{
    
    NSMutableArray *phoneArray;
    NSMutableArray *bodyArray;
    NSArray *messages;
    NSMutableArray *dateArray;
    NSMutableArray *timeArray;
    MBProgressHUD *HUD;
}

@property (strong,nonatomic)NSArray * messsages;

@end

@implementation MessageBoxTableViewController

@synthesize InboxAndSend,myTableView;


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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//    [[UINavigationBar appearance]setBackgroundColor:[UIColor grayColor]];
//    UIImageView* titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
//    [titleImage setImage:[UIImage imageNamed:@"logo-siempre-transparent.png"]];
//    self.navigationItem.titleView = titleImage;
    
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo-siempre-transparent.png"]];
    titleImageView.frame = CGRectMake(0, 0, 0, self.navigationController.navigationBar.frame.size.height); // Here I am passing
    titleImageView.contentMode=UIViewContentModeScaleAspectFit;
    self.navigationItem.titleView = titleImageView;
    
     //[[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    phoneArray =[NSMutableArray new];
    bodyArray = [NSMutableArray new];
    dateArray = [[NSMutableArray alloc] init];
    timeArray = [[NSMutableArray alloc] init];
    UIView *headerview = [[UIView alloc] initWithFrame:CGRectMake(0,0, 100, 80)];
    headerview.backgroundColor =  [UIColor colorWithRed:(39/255.0) green:(48/255.0) blue:(56/255.0) alpha:alphaStage];
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc]initWithItems:@[@"INBOX",@"SENT"]];
    // [segmentControl setSegmentedControlStyle:UISegmentedControlStyleBar];
    [segmentControl addTarget:self action:@selector(segmentedControlValueDidChange:) forControlEvents:UIControlEventValueChanged];
    [segmentControl setSelectedSegmentIndex:0];
    segmentControl.frame = CGRectMake(30, 30, 250, 30);
    [headerview addSubview:segmentControl];
    NSLog(@"Header View Size----%f",headerview.layer.frame.size.width);
    self.tableView.tableHeaderView = headerview;
    segmentControl.tintColor = [UIColor orangeColor];
    segmentControl.layer.cornerRadius = 4;
    segmentControl.backgroundColor = [UIColor whiteColor];

    [self inboxMessages];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)hudAssignment{
    HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    HUD.delegate = self;
}

-(void)inboxMessages
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *userName = [defaults objectForKey:@"userName"];
    
    NSLog(@"username---->%@",userName);
    
    
    NSString  *serverAddress = [NSString stringWithFormat:@"http://54.174.166.2/inboxMessageLogs?email_ID=%@",userName];
    
    NSURL *url = [NSURL URLWithString:serverAddress];
   
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //AFNetworking asynchronous url request
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        HUD.hidden =YES;
        self.messsages = [[[responseObject objectForKey:@"messageLogArray"]reverseObjectEnumerator]allObjects];
        
        /*phoneArray = [[responseObject objectForKey:@"fields"]valueForKey:@"caller_ID"];
        bodyArray = [[responseObject objectForKey:@"fields"]valueForKey:@"body"];*/
        
       
        
        NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
        [DateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateString = [DateFormatter stringFromDate:[NSDate date]];
        
        NSDateComponents *components = [[NSDateComponents alloc] init] ;
        [components setDay:-1];
        
        NSDate *yesterday = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:[NSDate date] options:0];
        NSString *yesterdayDateStr = [DateFormatter stringFromDate:yesterday];

        
        
        
        for (NSDictionary *inbox in self.messsages) {
            
            NSDictionary *dict = [inbox valueForKey:@"fields"];
            
            
            NSLog(@"Inside The LOOP---->%@",dict[@"callerid"]);
            
            NSString *callerid = [[inbox objectForKey:@"fields"]valueForKey:@"callerid"];
            NSString* myNewString = [NSString stringWithFormat:@"%@", callerid];
                [phoneArray addObject:myNewString];
                [bodyArray addObject:dict[@"body"]];
            NSString *dictVal = [[inbox objectForKey:@"fields"]valueForKey:@"time"];
            NSArray* timestampStr = [dictVal componentsSeparatedByString: @" "];
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
            
        }
                NSLog(@"Phone Array---->%@",dateArray);
                NSLog(@"Body Array---->%@",timeArray);

        
        
        
        NSLog(@"The Array: %@",timeArray);
        
        
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Request Failed: %@, %@", error, error.userInfo);
        
    }];
    
    [operation start];
    [self hudAssignment];
    
    
}

-(void)sendMessages
{
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *userName = [defaults objectForKey:@"userName"];
    NSLog(@"username---->%@",userName);
    
    
    NSString  *serverAddress = [NSString stringWithFormat:@"http://54.174.166.2/sendMessageLogs?email_ID=%@",userName];
    
    NSURL *url = [NSURL URLWithString:serverAddress];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //AFNetworking asynchronous url request
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    NSLog(@"Response ------>%@",operation.responseSerializer);
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        HUD.hidden =YES;
        self.messsages = [[[responseObject objectForKey:@"messageLogArray"]reverseObjectEnumerator]allObjects];
        
        
        NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
        [DateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateString = [DateFormatter stringFromDate:[NSDate date]];
        
        NSDateComponents *components = [[NSDateComponents alloc] init] ;
        [components setDay:-1];
        
        NSDate *yesterday = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:[NSDate date] options:0];
        NSString *yesterdayDateStr = [DateFormatter stringFromDate:yesterday];
        
        
        
        
        for (NSDictionary *inbox in self.messsages) {
            
            NSDictionary *dict = [inbox valueForKey:@"fields"];
            
            
            NSLog(@"Inside The LOOP---->%@",dict[@"callerid"]);

            NSString* callerId = [NSString stringWithFormat:@"%@", dict[@"callerid"]];
            [phoneArray addObject:callerId];
            [bodyArray addObject:dict[@"body"]];
            NSString *dictVal = [[inbox objectForKey:@"fields"]valueForKey:@"time"];
            NSArray* timestampStr = [dictVal componentsSeparatedByString: @" "];
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
            
        }
        NSLog(@"Phone Array---->%@",dateArray);
        NSLog(@"Body Array---->%@",timeArray);
        
        
        
        
        NSLog(@"The Array: %@",timeArray);
        
     
       [self.tableView reloadData];
     
     
     
     
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Request Failed: %@, %@", error, error.userInfo);
        
    }];
    
    [operation start];
    [self hudAssignment];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.messsages count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    /*UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath] ;*/
    
    NSDictionary *tempDictionary= [self.messsages objectAtIndex:indexPath.row];
    NSLog(@"tempDictionary------>%@",self.messsages);
    

    
    
    MyCell *mycell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!mycell){
        
        mycell = [[MyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    NSString *str = [[tempDictionary objectForKey:@"fields"]valueForKey:@"type"];
    NSLog(@"Phone Array->-->-->-->%@",phoneArray);
   
    
//    mycell.phoneLabel.text = [NSString stringWithFormat:@"%@",phoneArray[indexPath.row]];
    mycell.phoneLabel.text = phoneArray[indexPath.row];
    mycell.msgBody.text = bodyArray[indexPath.row];
    mycell.date.text = dateArray[indexPath.row];
    mycell.time.text = timeArray[indexPath.row];
    
    return mycell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Prepare For Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    DetailViewController *detailViewController = (DetailViewController *)segue.destinationViewController;
    detailViewController.detailsOfMSg = [self.messsages objectAtIndex:indexPath.row];
}

-(void) segmentedControlValueDidChange:(UISegmentedControl *)segment{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (segment.selectedSegmentIndex == 0) {
        NSLog(@"Inbox Clicked");
        [defaults setObject:@"inbox" forKey:@"msgType"];
        [self inboxMessages];
        
    } else {
        NSLog(@"Send Clicked");
        
        [defaults setObject:@"sent" forKey:@"msgType"];
        [self sendMessages];
        
    }
    
}



@end
