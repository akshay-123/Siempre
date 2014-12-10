//
//  callingVieController.h
//  SampleSlider
//
//  Created by Jayesh on 12/1/14.
//  Copyright (c) 2014 WhiteSnow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface callingVieController : UIViewController{
    UITextField *calledNumber;
}
@property (retain, nonatomic) IBOutlet UILabel *calledPhoneNumber;
@property (retain,nonatomic) IBOutlet UITextField *calledNumber;

- (IBAction)callEndBtn:(id)sender;


@end
