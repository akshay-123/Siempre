#import "HelloMonkeyViewController.h"
#import "HelloMonkeyAppDelegate.h"
#import "MonkeyPhone.h"

@implementation HelloMonkeyViewController

// … unchanged code omitted for brevity
-(IBAction)dialButtonPressed:(id)sender
{
    HelloMonkeyAppDelegate* appDelegate = (HelloMonkeyAppDelegate*)[UIApplication sharedApplication].delegate;
    MonkeyPhone* phone = appDelegate.phone;
    [phone connect:self.numberField.text];
    
}
-(IBAction)hangupButtonPressed:(id)sender
{
    HelloMonkeyAppDelegate* appDelegate = (HelloMonkeyAppDelegate*)[UIApplication sharedApplication].delegate;
    MonkeyPhone* phone = appDelegate.phone;
    [phone disconnect];
    
}


// … unchanged code omitted for brevity

@end