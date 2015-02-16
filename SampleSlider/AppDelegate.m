//
//  AppDelegate.m
//  SampleSlider
//
//  Created by Jayesh on 11/18/14.
//  Copyright (c) 2014 WhiteSnow. All rights reserved.
//

#import "AppDelegate.h"
#import "MonkeyPhone.h"
#import "CallViewController.h"
#import "PayPalMobile.h"
#import "TwilioClient.h"
#import "AFNetworking.h"
#import "MainVCViewController.h"
#import "UIViewController+AMSlideMenu.h"
#import "ReceveingCallerScreenViewController.h"
#import "Reachability.h"
#import <AVFoundation/AVFoundation.h>


@interface AppDelegate ()<TCDeviceDelegate,TCConnectionDelegate,UIApplicationDelegate,AVAudioPlayerDelegate>{
    TCDevice* _phone;
    TCConnection* _connection;
    id storedViewController;
   

}


//+(AppDelegate*) getInstance;

@end



@implementation AppDelegate
@synthesize window = _window;

@synthesize phone = _phone;
@synthesize phConnection = _connection;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after applicati [self connectionDidStartConnecting:_
      if (launchOptions!=nil) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"handleNotification" object:nil];
    }
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
    
      // NSUInteger taskCount = 0;
    //[UIApplication sharedApplication].applicationIconBadgeNumber = taskCount;
    
    NSDictionary *pushInfo = [launchOptions valueForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    
    
#warning "Enter your credentials"
//    [PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentProduction : @"maldhureakshay-buyer-1@gmail.com",PayPalEnvironmentSandbox : @"AZEdvBAEQtEhu-dLAZgT7DofVOYngCvQ1de5--5-yUEvAYse0q-tCAbbYTHu"}];

    [PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentProduction : @"AeS1HGyFuDkzbDKcczcJxoQj-acyG6rgANSxg3OHOY_jZmb7gOMNzNDCcqh6KY6jJIoB2s8p4_7UAhPr",PayPalEnvironmentSandbox : @""}];

        return YES;
}



- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSLog(@"My token is: %@", deviceToken);
    NSString* deviceTokenStr = [[[[deviceToken description]
                                stringByReplacingOccurrencesOfString: @"<" withString: @""]
                               stringByReplacingOccurrencesOfString: @">" withString: @""]
                              stringByReplacingOccurrencesOfString: @" " withString: @""];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:deviceTokenStr forKey:@"deviceTokenStr"];  
    [defaults synchronize];
    
}



- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    NSLog(@"Msg--->%@",userInfo);
   if ( application.applicationState == UIApplicationStateInactive)
    {
        //opened from a push notification when the app was on background
        NSLog(@"Notification---->%@",userInfo);
        
        NSDictionary *notificationMessage = [userInfo objectForKey:@"aps"];
        NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
        [DateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *time = [DateFormatter stringFromDate:[NSDate date]];
        NSString *receiver = notificationMessage[@"Receiver"];
        NSString *Sender = notificationMessage[@"Sender"];
        NSString *message = notificationMessage[@"alert"];
        
    
        NSString  *serverAddress = [NSString stringWithFormat:@"http://54.174.166.2/receiveMessage?Receiver_ID=%@&caller_ID=%@&time=%@&type=inbox&body=%@",[receiver stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"],[Sender stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"],[time stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[message stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"Server Address----->%@",serverAddress);
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        
        
        [manager GET:serverAddress parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSLog(@"Receive Msg saved");
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Receive Not Msg saved");
         }];
 


    }
    else if(application.applicationState == UIApplicationStateActive)
    {
        NSLog(@"Notification---->%@",userInfo);
        
        NSDictionary *notificationMessage = [userInfo objectForKey:@"aps"];
        NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
        [DateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *time = [DateFormatter stringFromDate:[NSDate date]];
        NSString *receiver = notificationMessage[@"Receiver"];
        NSString *Sender = notificationMessage[@"Sender"];
        NSString *message = notificationMessage[@"alert"];
        
        
        
        NSString  *serverAddress = [NSString stringWithFormat:@"http://54.174.166.2/receiveMessage?Receiver_ID=%@&caller_ID=%@&time=%@&type=inbox&body=%@",[receiver stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"],[Sender stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"],[time stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[message stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"Server Address----->%@",serverAddress);
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        
       
        [manager GET:serverAddress parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSLog(@"Receive Msg saved");
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Receive Not Msg saved");
         }];

    }
    
}

-(void)postNotificationToPresentPushMessagesVC{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"handleNotification" object:nil];

    
}



-(void)registrationForTwilio{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [defaults objectForKey:@"userName"];
    NSString *urlString = [NSString stringWithFormat:@"http://54.174.166.2/generate_token/?email_ID=%@",userName];
    NSURL *url1 = [NSURL URLWithString:urlString];
    NSError *error = nil;
    NSString *token = [NSString stringWithContentsOfURL:url1 encoding:NSUTF8StringEncoding error:&error];
    NSLog(@"Token--->%@",token);
    // [defaults setObject:token forKey:@"token"];
    
    if (token == nil) {
        NSLog(@"Error retrieving token: %@", [error localizedDescription]);
    } else {
        _phone = [[TCDevice alloc] initWithCapabilityToken:token delegate:self];
    }

}

- (NSIndexPath *)initialIndexPathForLeftMenu
{
    return [NSIndexPath indexPathForRow:2 inSection:0];
}


- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
}
-(void)device:(TCDevice *)device didStopListeningForIncomingConnections:(NSError *)error{
    NSLog(@"Stopped Listen");
    //[self registrationForTwilio];

}
- (void)device:(TCDevice *)device didReceiveIncomingConnection:(TCConnection *)connection
{
    NSUserDefaults *incomingPhNumber = [NSUserDefaults standardUserDefaults];
    [incomingPhNumber setObject:[connection parameters][@"From"] forKey:@"incomingNumber"];
    NSLog(@"Incoming Number------>%@",[connection parameters][@"From"]);
    //storedViewController = self.window.rootViewController;
    
    //self.window.rootViewController = [self.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"ReceivingCall"];
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"receivePresentCallScreen"
     object:self];

    
    NSLog(@"Incoming connection from: %@", [connection parameters][@"From"]);
   
    if (device.state == TCDeviceStateBusy) {
        [connection reject];
    } else {
        //[connection accept];
        _connection = connection;
        _connection.delegate = self;
            }
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    [notification setAlertBody:@"Incoming Call on Siempre"];
    notification.soundName = UILocalNotificationDefaultSoundName;
    UIApplication *application = [UIApplication sharedApplication] ;
    [application setScheduledLocalNotifications:[NSArray arrayWithObject:notification]];

   
}
-(void)connectionDidDisconnect:(TCConnection *)connection{
    NSLog(@"Disconnected...appdelgate");
    
    //self.window.rootViewController = storedViewController;
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"receiveDismissCallScreen"
     object:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *missedCallStatus = [defaults objectForKey:@"missedCalledStatus"];
    if(!(missedCallStatus == false)){
        NSLog(@"Missed Call....");
    }
    
}

- (void)deviceDidStartListeningForIncomingConnections:(TCDevice*)device
{
    NSLog(@"Device: %@ deviceDidStartListeningForIncomingConnections", device);
    
}

/*- (void)device:(TCDevice *)device didStopListeningForIncomingConnections:(NSError *)error
{
   // [[NSNotificationCenter defaultCenter]postNotificationName:@"handleNotification" object:nil];
        
    NSLog(@"Device: %@ didStopListeningForIncomingConnections: %@", device, error);
}*/




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"Application-----%@",application);
  
    
}

-(void)doSomething{
    NSLog(@"background");
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
   
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
