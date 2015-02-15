//
//  AppLinkController.m
//  SampleSlider
//
//  Created by Jayesh on 27/11/14.
//  Copyright (c) 2014 WhiteSnow. All rights reserved.
//

#import "AppLinkController.h"

@interface AppLinkController ()

@end

@implementation AppLinkController



NSArray *applist,*appIcons,*checkPath,*downloadlinks;
int i,j;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Initialize table data
    applist = [NSArray arrayWithObjects:@"Waze", @"Google Maps",@"Apple Maps",@"FaceTime", nil];
    appIcons= [NSArray arrayWithObjects:@"waze.png",@"google-maps.png",@"apple-maps.png",@"facetime.png",nil];
    checkPath=[NSArray arrayWithObjects:@"fb://",@"comgooglemaps://",@"fb://",@"facetime://user@example.com", nil];
    downloadlinks=[NSArray arrayWithObjects:@"waze",@"googlemaps",@"applemaps",@"facetime", nil];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text = [applist objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[appIcons objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"Row Selected = %i",indexPath.row);
    
    switch (indexPath.row) {
        case 0:
            [self installApp:indexPath.row];
            break;
        case 1:
            [self installApp:indexPath.row];
            break;
        case 2:
            [self installApp:indexPath.row];
            break;
        case 3:
            [self installApp:indexPath.row];
            break;
    }
    
    
}
- (void) installApp:(int)index
{
    i=index;
    
    NSLog(@"%@",applist[index]);
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:checkPath[index]]]) {
        j=1;
        NSString *msg=[NSString stringWithFormat:@"You will be redirected to Apple Store, Do you want to continue.?"];
        
        UIAlertView *installAppAlert = [[UIAlertView alloc]initWithTitle:
                                        @"Alert" message: msg delegate:self
                                                       cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        [installAppAlert show];
        
        
        
    }
    else
    {
        j=2;
        NSString *msg=[NSString stringWithFormat:@"You are about to open ""%@%@",applist[index], @", Do you want to continue.?"];
        
        UIAlertView *openAppAlert = [[UIAlertView alloc]initWithTitle:
                                     @"Alert" message: msg delegate:self
                                                    cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        
        [openAppAlert show];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        
    }
    if(buttonIndex == 1) {
        
        if(j==1){
            [self redirectToAppStore:i];
        }
        if(j==2){
            [self openApp:i];
        }
    }
    
}


//this method redirect to applestore
-(void) redirectToAppStore:(int)index{
    NSString *iTunesLink = [NSString stringWithFormat:@"https://itunes.com/app/""%@",downloadlinks[i]];
    NSLog(@"%@",iTunesLink);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
}

//this method opens the app
-(void)openApp:(int)index{
    NSLog(@"%@",checkPath[i]);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: checkPath[i]]];
}


@end
