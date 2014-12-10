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

@interface TableViewController ()

@property (strong, nonatomic) NSArray *googlePlacesArrayFromAFNetworking;
@property (strong, nonatomic) NSArray *missedCallArray;
@end

@implementation TableViewController

@synthesize InboxAndSendSegmentedControll,filteredTableData;


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
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *userName = [defaults objectForKey:@"userName"];
    NSString *password = [defaults objectForKey:@"password"];
    int flag = [defaults integerForKey:@"flag"];
    
    NSLog(@"Inherited Values userName ----->%@",userName);
    NSLog(@"Inherited Values Password ----->%@",password);
    NSLog(@"Inherited Values flag----->%d",flag);

    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
     [self callLogs];
    
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
    
    NSURL *url = [NSURL URLWithString:@"http://192.168.2.106:8000/callLogs?email_ID=g.bagul3%40gmail.com"];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //AFNetworking asynchronous url request
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        self.googlePlacesArrayFromAFNetworking = [responseObject objectForKey:@"callLogArray"];
        NSDictionary *dict = [[responseObject objectForKey:@"fields"]valueForKey:@"type"];
        
        //NSString *str = [[tempDictionary objectForKey:@"fields"]valueForKey:@"type"];
        
        NSLog(@"The Dictionary Called ---->: %@",dict);

        
        NSLog(@"The Array: %@",self.googlePlacesArrayFromAFNetworking);
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Request Failed: %@, %@", error, error.userInfo);
        
    }];
    
    [operation start];
    
}

-(void)missedCalls
{
    NSURL *url = [NSURL URLWithString:@"http://192.168.2.106:8000/missedCallLogs/?email_ID=g.bagul3%40gmail.com"];
    
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //AFNetworking asynchronous url request
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        
        
        self.googlePlacesArrayFromAFNetworking = [responseObject objectForKey:@"callLogArray"];
        
        
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath] ;
    
    NSDictionary *tempDictionary= [self.googlePlacesArrayFromAFNetworking objectAtIndex:indexPath.row];
    
   
    
    
    
    
    
    
    
    
    
    
    
    UIImage * dailled = [UIImage imageNamed:@"dailled.png"];
    UIImage * incoming = [UIImage imageNamed:@"incoming.png"];
    UIImage * missed = [UIImage imageNamed:@"missed called image.png"];
    
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
    
    NSLog(@"String--->%@",str);
    
    if([str isEqualToString:@"missed"])
    {
        cell.imageView.image = missed;
    }
    else if( [str isEqualToString:@"received"])
    {
         cell.imageView.image = incoming;
    }
    else if([str isEqualToString:@"dialled"])
    {
        cell.imageView.image = dailled;
    }
    
    
    cell.textLabel.text = [[tempDictionary objectForKey:@"fields"]valueForKey:@"caller_ID"];
    
    
    return cell;
}


#pragma mark - Prepare For Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    ViewController *detailViewController = (ViewController *)segue.destinationViewController;
    detailViewController.restuarantDetail = [self.googlePlacesArrayFromAFNetworking objectAtIndex:indexPath.row];
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
