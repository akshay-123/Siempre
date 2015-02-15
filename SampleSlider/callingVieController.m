//
//  callingVieController.m
//  SampleSlider
//
//  Created by Jayesh on 12/1/14.
//  Copyright (c) 2014 WhiteSnow. All rights reserved.
//

#import "callingVieController.h"
#import "AppDelegate.h"
#import "MonkeyPhone.h"
#import "AFNetworking.h"
#import "CallViewController.h"
#import "TableViewController.h"


@interface callingVieController ()<TCDeviceDelegate,TCConnectionDelegate>


@end

@implementation callingVieController{
    bool start;
    NSTimeInterval time;
    NSString *startTime;
    NSString *userName;
    NSString *token;
}
@synthesize calledPhoneNumber,calledNumber,displayTimer;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.jjjsw37e1`
    UIDevice *device = [UIDevice currentDevice];
    device.proximityMonitoringEnabled = YES;

    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    calledNumber.text = [defaults objectForKey:@"calledPhoneNumber"];
    self.displayTimer.text = @"00.00";
    start = false;
    self.displayTimer.hidden = NO;
    
    if (start == false) {
        start = true;
        
        time = [NSDate timeIntervalSinceReferenceDate];
        [self update];
        
    }else{
        
        start = false;
    }
    
  }


-(void)update{
    if (start == false) {
        return;
    }
    NSTimeInterval currebtTime = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval elappedTime = currebtTime -time;
    
    int minutes = (int)(elappedTime / 60.0);
    int seconds = (int)(elappedTime - (minutes*60));
    
    self.displayTimer.text = [NSString stringWithFormat:@"%02u:%02u",minutes,seconds];
    
    [self performSelector:@selector(update) withObject:self afterDelay:0.1];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *credits = [defaults objectForKey:@"credits"];
    
    if([credits integerValue] == minutes){
        AppDelegate *delegate =[UIApplication sharedApplication].delegate;
        [delegate.phone disconnectAll];
        [self dismissViewControllerAnimated:true completion:nil];

    }
    
}


- (void)didReceiveMemoryWarning {
    calledPhoneNumber.text = calledNumber.text;
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)timer{
    [self performSelectorOnMainThread:@selector(timerOnMainThread) withObject:nil waitUntilDone:NO];
}
-(void)timerOnMainThread{
    NSLog(@"Timmer Clicked");
    self.displayTimer.hidden = YES;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)callEndBtn:(id)sender {
    
    [self dismissViewControllerAnimated:true completion:nil];
    
    AppDelegate *delegate =[UIApplication sharedApplication].delegate;
    [delegate.phone disconnectAll];
    
    [self creditCalculation];
    
    
}

-(void) creditCalculation{
    
    NSLog(@"Call End Button --->%@",startTime);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    userName = [defaults objectForKey:@"userName"];

    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    startTime = [DateFormatter stringFromDate:[NSDate date]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString  *serverAddress = [NSString stringWithFormat:@"http://54.174.166.2/update_call_log?email_ID=%@&time=%@&duration=%@&caller_ID=%@&type=dialed",[userName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[startTime stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[self.displayTimer.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[calledNumber.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"startTime------>%@",serverAddress);
    [manager GET:serverAddress parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"Saved");
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Not Saved.....: %@", error);
         
     }];
    
    NSUserDefaults *durationTime = [NSUserDefaults standardUserDefaults];
    
    [durationTime setObject:self.displayTimer.text forKey:@"durationTime"];
}

-(void)connectionDidConnect:(TCConnection *)connection{
    NSLog(@"Connected.....");
}

-(void)connectionDidDisconnect:(TCConnection *)connection{
    NSLog(@"Disconnect....");
    
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"callingScreenView"];
    
   // [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)connectionDidStartConnecting:(TCConnection *)connection{
    NSLog(@"Connecting........");
}


@end
