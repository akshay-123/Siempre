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
    applist = [NSArray arrayWithObjects:@"WAZE", @"GOOGLE MAPS",@"APPLE MAPS",@"FACETIME", nil];
    appIcons= [NSArray arrayWithObjects:@"newWaze1.png",@"newGoogleMaps.png",@"newAppleMap1.png",@"newFaceTime.png",nil];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *user = [defaults objectForKey:@"userName"];
    NSString *facetime = [@"facetime://" stringByAppendingString:user];
    
    checkPath=[NSArray arrayWithObjects:@"waze://",@"comgooglemaps://",@"maps://",facetime, nil];
    downloadlinks=[NSArray arrayWithObjects:@"id323229106",@"id585027354",@"id592990211",@"facetime", nil];
    
//    [[UINavigationBar appearance]setBackgroundColor:[UIColor grayColor]];
//    UIImageView* titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
//    [titleImage setImage:[UIImage imageNamed:@"logo-siempre-transparent.png"]];
//    self.navigationItem.titleView = titleImage;
    
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo-siempre-transparent.png"]];
    titleImageView.frame = CGRectMake(0, 0, 0, self.navigationController.navigationBar.frame.size.height); // Here I am passing
    titleImageView.contentMode=UIViewContentModeScaleAspectFit;
    self.navigationItem.titleView = titleImageView;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
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
    cell.imageView.frame = CGRectMake(0, 0, 50, 50);
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
        NSString *msg=[NSString stringWithFormat:@"You will be redirected to Apple Store. Do you want to continue?"];
        
        UIAlertView *installAppAlert = [[UIAlertView alloc]initWithTitle:
                                        @"Alert" message: msg delegate:self
                                                       cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        [installAppAlert show];
        
        
        
    }
    else
    {
        j=2;
        NSString *msg=[NSString stringWithFormat:@"You will be navigated to ""%@%@",applist[index], @". Are you sure want to navigate away from Siempre Wifi?"];
        
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
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.imageView.frame = CGRectMake(10, 10, 5, 5);
    
}

//this method redirect to applestore
-(void) redirectToAppStore:(int)index{
    NSString *iTunesLink = iTunesLink = [NSString stringWithFormat:@"http://itunes.apple.com/us/app/""%@",downloadlinks[i]];
    NSLog(@"%@",iTunesLink);
    NSLog(@"URLWithString--->%@",downloadlinks[i]);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
}

//this method opens the app
-(void)openApp:(int)index{
    NSLog(@"%@",checkPath[i]);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: checkPath[i]]];
    NSLog(@"URLWithString--->%@",checkPath[i]);
}

- (float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.02f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    // To "clear" the footer view
    return [UIView new];
}



@end
