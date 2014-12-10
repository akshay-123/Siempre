//
//  Copyright 2011 Twilio. All rights reserved.
//
 
#import "MonkeyPhone.h"

@implementation MonkeyPhone


-(id)init
{
    
    if ( self = [super init] )
    {
        NSURL* url = [NSURL URLWithString:@"http://ecellmit.com/Smita/auth.php?clientName=MegaBytes"];
        NSLog(@"Connected to server...");
        NSURLResponse* response = nil;
        NSError* error = nil;
        NSData* data = [NSURLConnection sendSynchronousRequest:
                        [NSURLRequest requestWithURL:url]
                                             returningResponse:&response
                                                         error:&error];
        
       // NSLog(@"Data----->%d",data);
        if (data)
        {
            NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
            NSLog(@" hhtp Response ----> %@",httpResponse);
            if (httpResponse.statusCode == 200)
            {
                 NSLog(@"Capability Token Before ----->");
               NSString* capabilityToken =
                [[NSString alloc] initWithData:data
                                       encoding:NSUTF8StringEncoding];
                
                _device = [[TCDevice alloc] initWithCapabilityToken:capabilityToken
                                                           delegate:nil];
                NSLog(@"Capability Token After ----->%@",capabilityToken);
                NSLog(@"Connected.......");
            }
            else
            {
                NSString*  errorString = [NSString stringWithFormat:
                                          @"HTTP status code %ld",(long)httpResponse.statusCode];
                NSLog(@"Error logging in: %@", errorString);
            }
        }
        else
        {
            NSLog(@"Error logging in: %@", [error localizedDescription]);
        }
    }
    return self;
}


-(void)connect:(NSString*)phoneNumber
{
    NSDictionary* parameters = nil;
    if ( [phoneNumber length] > 0 )
    {
        parameters = [NSDictionary dictionaryWithObject:phoneNumber forKey:@"PhoneNumber"];
    }
    _connection = [_device connect:parameters delegate:nil];
    //[_connection retain];
    NSLog(@"Calling...");

}
-(void)disconnect
{
    [_connection disconnect];
    //[_connection release];
    _connection = nil;
    NSLog(@"Disconected...");

}
-(void)device:(TCDevice*)device didReceiveIncomingConnection:(TCConnection*)connection
{
    if ( _connection )
    {
        [self disconnect];
    }
    //_connection = [connection retain];
    [_connection accept];
}


-(void)deviceDidStartListeningForIncomingConnections:(TCDevice*)device
{
    
    NSLog(@"Device is now listening for incoming connections");
    
}

-(void)device:(TCDevice*)device didStopListeningForIncomingConnections:(NSError*)error
{
    if ( !error )
    {
        NSLog(@"Device is no longer listening for incoming connections");
    }
    else
    {
        NSLog(@"Device no longer listening for incoming connections due to error: %@", [error localizedDescription]);
    }
}
@end
