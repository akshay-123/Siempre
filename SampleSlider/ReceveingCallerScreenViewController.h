//
//  ReceveingCallerScreenViewController.h
//  SiempreWifi
//
//  Created by Jayesh on 12/13/14.
//  Copyright (c) 2014 WhiteSnow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface ReceveingCallerScreenViewController : UIViewController
{
   // SystemSoundID PlaySoundID;
    
    AVAudioPlayer *audioPlayer;
    
}



@property (weak, nonatomic) IBOutlet UILabel *incomingPhNumber;

@property (nonatomic, retain) AVAudioPlayer *player;
- (IBAction)callEndBtn:(id)sender;
- (IBAction)callPickUp:(id)sender;
@end
