#import "TCDevice.h"
#import "TCConnection.h"

@interface MonkeyPhone : NSObject
{
@private
    TCDevice* _device;
    TCConnection* _connection;
}

-(void)connect:(NSString*)phoneNumber;
-(void)disconnect;

-(void)deviceDidStartListeningForIncomingConnections:(TCDevice*)device;
-(void)device:(TCDevice*)device didStopListeningForIncomingConnections:(NSError*)error;


@end