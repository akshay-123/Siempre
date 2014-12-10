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


@interface MessageBoxTableViewController (){
    
    NSMutableArray *phoneArray;
    NSMutableArray *bodyArray;
    NSArray *messages;
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
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    phoneArray =[NSMutableArray new];
    bodyArray = [NSMutableArray new];
    [self inboxMessages];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)inboxMessages
{
   
    
   

    
    NSURL *url = [NSURL URLWithString:@"http://192.168.2.106:8000/inboxMessageLogs?email_ID=g.bagul3%40gmail.com"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //AFNetworking asynchronous url request
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.messsages = [responseObject objectForKey:@"messageLogArray"];
        
        /*phoneArray = [[responseObject objectForKey:@"fields"]valueForKey:@"caller_ID"];
        bodyArray = [[responseObject objectForKey:@"fields"]valueForKey:@"body"];*/
        
        
        
        
        
        for (NSDictionary *inbox in self.messsages) {
            
            NSDictionary *dict = [inbox valueForKey:@"fields"];
            
            
            NSLog(@"Inside The LOOP---->%@",dict[@"caller_ID"]);
            
                [phoneArray addObject:dict[@"caller_ID"]];
                [bodyArray addObject:dict[@"body"]];
            
        }
                NSLog(@"Phone Array---->%@",phoneArray);
                NSLog(@"Body Array---->%@",bodyArray);

        
        //NSLog(@"The Array: %@",self.messsages);
        
        
        
        [self.tableView reloadData];
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Request Failed: %@, %@", error, error.userInfo);
        
    }];
    
    [operation start];
    
}

-(void)sendMessages
{
    NSURL *url = [NSURL URLWithString:@"http://192.168.2.106:8000/sendMessageLogs/?email_ID=g.bagul3%40gmail.com"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //AFNetworking asynchronous url request
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    NSLog(@"Response ------>%@",operation.responseSerializer);
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.messsages = [responseObject objectForKey:@"messageLogArray"];
        
        
        for (NSDictionary *send in self.messsages) {
            
            NSDictionary *dict = [send valueForKey:@"fields"];
            
            [phoneArray addObject:dict[@"caller_ID"]];
            [bodyArray addObject:dict[@"body"]];
        }
        
        

        NSLog(@"Phone Array---->%@",phoneArray);
        
        NSLog(@"body Array---->%@",bodyArray);
        NSLog(@"The Array: %@",self.messsages);
        
        
        
       [self.tableView reloadData];
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Request Failed: %@, %@", error, error.userInfo);
        
    }];
    
    [operation start];
    
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
    
    UIImage *receiveImage =[UIImage imageNamed:@"incomingImg.png"];
    UIImage *sendImage =[UIImage imageNamed:@"outgoingImg.png"];
    
    NSString *str = [[tempDictionary objectForKey:@"fields"]valueForKey:@"type"];
    NSLog(@"Phone Array->-->-->-->%@",phoneArray);
    mycell.phoneLabel.text = phoneArray [indexPath.row] ;
    mycell.msgBody.text = bodyArray [indexPath.row];
    if([[[tempDictionary objectForKey:@"fields"]valueForKey:@"type"]isEqualToString:@"inbox"]){
            mycell.cellImage.image = receiveImage;
    }else{
        mycell.cellImage.image = sendImage;
    }
    
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




- (IBAction)InboxAndSendSegmentBtn:(id)sender {
    
    if (InboxAndSend.selectedSegmentIndex == 0) {
        NSLog(@"Inbox Clicked");
        [self inboxMessages];
    } else {
        NSLog(@"Send Clicked");
        [self sendMessages];
        
    }
    
}
@end
