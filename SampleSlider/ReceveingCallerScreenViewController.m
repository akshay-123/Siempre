//
//  ReceveingCallerScreenViewController.m
//  SiempreWifi
//
//  Created by Jayesh on 12/13/14.
//  Copyright (c) 2014 WhiteSnow. All rights reserved.
//

#import "ReceveingCallerScreenViewController.h"
#import "AppDelegate.h"
#import "MonkeyPhone.h"
#import <AVFoundation/AVFoundation.h>
#import "HomeViewController.h"
#import "AFNetworking.h"

@interface ReceveingCallerScreenViewController ()<TCDeviceDelegate,TCConnectionDelegate>
@property (weak, nonatomic) IBOutlet UILabel *displayTimer;

@end

@implementation ReceveingCallerScreenViewController{
    bool start;
    NSTimeInterval time;
    NSString *startTime;
    NSString *userName;
    NSString *incomingNumber;
    NSString *callStatus;
    
}
@synthesize incomingPhNumber;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dismisView) name:@"receiveDismissCallScreen" object:nil];

    
    /*CFBundleRef mainBundle = CFBundleGetMainBundle();
    CFURLRef soundFileUrlRef = CFBundleCopyResourceURL(mainBundle, (CFStringRef) @"ringing", CFSTR("mp3"),Nil);
    UInt32 soundID;
    AudioServicesCreateSystemSoundID(soundFileUrlRef, &soundID);*/
    
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/ringring.mp3", [[NSBundle mainBundle] resourcePath]]];
    
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    audioPlayer.numberOfLoops = -1;
    
    if (audioPlayer == nil)
    {
        NSLog(@"Error");
    }else{
        [audioPlayer play];
    }
    self.displayTimer.text = @"00.00";
    start = false;
    self.displayTimer.hidden =YES;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    userName = [defaults objectForKey:@"userName"];
    incomingNumber = [defaults objectForKey:@"incomingNumber"];
    NSLog(@"Incoming Number On The Screen ------->%@",incomingNumber);
    incomingPhNumber.text = incomingNumber;
    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(removeViewNotification:) name:@"dismissReveiverViewControll" object:nil];
    NSUserDefaults *defaultsStr = [NSUserDefaults standardUserDefaults];
    [defaultsStr setObject:@"true" forKey:@"missedCalledStatus"];

    
    
    
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
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
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(IBAction)callEndBtn:(id)sender {
    /*AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
     MonkeyPhone* phone = appDelegate.phone;
     [phone disconnect];*/
    NSLog(@"Disconnect......");
    
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"MainStoryBoard"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self presentViewController:vc animated:YES completion:nil ];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.phConnection disconnect];
    [audioPlayer stop];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    userName = [defaults objectForKey:@"userName"];
    
    NSLog(@"Call End Button --->%@",startTime);
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    startTime = [DateFormatter stringFromDate:[NSDate date]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString  *serverAddress = [URL_LINk stringByAppendingString:[NSString stringWithFormat:@"update_call_log?email_ID=%@&time=%@&duration=%@&caller_ID=%@&type=missed",[userName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[startTime stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[self.displayTimer.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[incomingNumber stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    NSLog(@"startTime------>%@",serverAddress);
     [manager GET:serverAddress parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"Saved");
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Not Saved.....: %@", error);
         
     }];

    
    
    
}

-(void)callStatusType{
    
    if([callStatus isEqualToString:@"false"]){
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        userName = [defaults objectForKey:@"userName"];
        
        NSLog(@"Call End Button --->%@",startTime);
        NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
        [DateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        startTime = [DateFormatter stringFromDate:[NSDate date]];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSString  *serverAddress = [URL_LINk stringByAppendingString:[NSString stringWithFormat:@"update_call_log?email_ID=%@&time=%@&duration=%@&caller_ID=%@&type=missed",[userName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[startTime stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[self.displayTimer.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[incomingNumber stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        
        NSLog(@"startTime------>%@",serverAddress);
        [manager GET:serverAddress parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSLog(@"Saved");
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Not Saved.....: %@", error);
             
         }];

    }
}

-(void)removeView{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [defaults objectForKey:@"stop"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)callPickUp:(id)sender {

    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.phConnection accept];
    
    
    [audioPlayer stop];
    
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    startTime = [DateFormatter stringFromDate:[NSDate date]];
    NSLog(@"DateString---->%@",startTime);
    callStatus =@"true";
    NSUserDefaults *defaultsStr = [NSUserDefaults standardUserDefaults];
    [defaultsStr setObject:@"true" forKey:@"missedCalledStatus"];

    
    self.displayTimer.hidden = NO;
    if (start == false) {
        start = true;
        
        time = [NSDate timeIntervalSinceReferenceDate];
        [self update];
        
    }else{
        
        start = false;
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString  *serverAddress = [URL_LINk stringByAppendingString:[NSString stringWithFormat:@"update_call_log?email_ID=%@&time=%@&duration=%@&caller_ID=%@&type=received",[userName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[startTime stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[self.displayTimer.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[self.incomingPhNumber.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    NSLog(@"startTime------>%@",serverAddress);
    [manager GET:serverAddress parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"Saved");
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Not Saved.....: %@", error);
         
     }];
    

}

-(void)dismisView
{
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"ReceivingCall"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
