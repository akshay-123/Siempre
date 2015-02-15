//
//  CallViewController.m
//  SampleSlider
//
//  Created by Jayesh on 26/11/14.
//  Copyright (c) 2014 WhiteSnow. All rights reserved.
//

#import "CallViewController.h"
#import "AppDelegate.h"
#import "MonkeyPhone.h"
#import "MainVCViewController.h"
#import "AFNetworking.h"
#import "TwilioClient.h"
#import "TCConnectionDelegate.h"
#import "Reachability.h"
#import "customViewCell.h"

@interface CallViewController ()<TCDeviceDelegate,TCConnectionDelegate>{
   //TCDevice* _phone;
    TCConnection* _connection;
}
@end
//countryCodeData
@implementation CallViewController{
    
    NSString *username;
    NSString *credits;
    NSString *countryCode;
    NSString *phoneNumberStr;
    NSString *countryCodeFlag;
    NSString *newPhoneNumber;
    NSArray *countryList;
    NSString *contryStr;
    NSString *countryCodeStr;
    NSMutableArray *newCountryCodeStr;
    NSUInteger countryCodeLength;
    NSArray *dialBtn;
    NSArray *handler;
    
}
@synthesize numberField,pickerViewContainer,countryCodeData,countryCodeTxtField,callingView,callCreditsUsed,creditsBalance,phConnection,phone,contacts,delegate,creditSpinner,minuteUsedSpinner,creditImg,creditUsedImg,detailsOfCallLogs,collectionView;




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"header.png"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance]setBackgroundColor:[UIColor grayColor]];
    /*UIImageView* titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    [titleImage setImage:[UIImage imageNamed:@"logo-siempre-transparent.png"]];
    self.navigationItem.titleView = titleImage;*/
    
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo-siempre-transparent.png"]];
    titleImageView.frame = CGRectMake(0, 0, 0, self.navigationController.navigationBar.frame.size.height); // Here I am passing
    titleImageView.contentMode=UIViewContentModeScaleAspectFit;
    self.navigationItem.titleView = titleImageView;
    
    newCountryCodeStr = [[NSMutableArray alloc]init];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];

    
    //NSString *pathCountryList = [[NSBundle mainBundle]pathForResource:@"countryCode" ofType:@"plist"];
    //NSArray *countryList = [[NSArray alloc]initWithContentsOfFile:pathCountryList];
    
    //[self.collectionView registerClass:[customViewCell class] forCellWithReuseIdentifier:@"Cell"];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.scrollEnabled = NO;
    
    

    dialBtn = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"+",@"0",@"<-", nil];
    handler = [[NSArray alloc]initWithObjects:@"dialOne",@"dialTwo", nil];
    
       countryList  = [[NSArray alloc]initWithObjects:@"Other (+)",@"United States (+1)",@"United Kingdom (+44)",@"Spain (+34)",@"India (+91)",@"Germany (+49)",@"Mexico (+52)",@"France (+33)",@"Brazil (+55)",@"Spain (+34)",@"Costa Rica (+506)",@"Italy (+3)",@"Irel(+353)",@"Portugal (+351)",@"Canada (+1)",@"D.R. (+1809)",@"Chile (+56)",@"Switzerland (+41)",@"Austria (+43)",@"Afghanistan (+93)",@"Albania (+355)",@"Algeria (+213)",@"American Samoa (+1684)",@"Andorra (+376)",@"Angola (+244)",@"Anguilla (+1264)",@"Antarctica (+672)",@"Antigua and Barbuda (+1268)",@"Argentina (+54)",@"Armenia (+374)",@"Ar(+297)",@"Australia (+61)",@"Austria (+43)",@"Azerbaijan (+994)",@"Bahamas (+1242)",@"Bahrain (+973)",@"Banglad(+880)",@"Barbados (+1246)",@"Belarus (+375)",@"Belgium (+32)",@"Belize (+501)",@"Benin (+229)",@"Bermuda (+441)",@"Bhutan (+975)",@"Bolivia (+591)",@"Bosnia and Herzegovina (+387)",@"Botswana (+267)",@"Brazil (+55)",@"British VirIslands (+1284)",@"Brunei (+673)",@"Bulgaria (+359)",@"Burkina Faso (+226)",@"Burma  Myanmar (+95)",@"Burundi (+257)",@"Cambodia (+855)",@"Cameroon (+237)",@"Canada (+1)",@"Cape Verde (+238)",@"Cayman Islands (+1345)",@"Central AfriRepublic (+236)",@"Chad (+235)",@"Chile (+56)",@"China (+86)",@"Christmas Island (+61)",@"Cocos  Keeling Islands (+61)",@"Colombia (+57)",@"Comoros (+269)",@"Cook Islands (+682)",@"Costa Rica (+506)",@"Croatia (+385)",@"Cuba (+53)",@"Cyprus (+357)",@"Czech Republic (+420)",@"Democratic Republic of the Congo (+243)",@"Denmark (+45)",@"Djibouti (+253)",@"Dominica (+1767)",@"Dominican Republic (+1809)",@"Ecuador (+593)",@"Egypt (+20)",@"El Salvador (+503)",@"EquatorGuinea (+240)",@"Eritrea (+291)",@"Estonia (+372)",@"Ethiopia (+251)",@"Falkland Islands (+500)",@"FaIsla(+298)",@"Fiji (+679)",@"Finland (+358)",@"France (+33)",@"French Polynesia (+689)",@"Gabon (+241)",@"Gam(+220)",@"Gaza Strip (+970)",@"Georgia (+995)",@"Germany (+49)",@"Ghana (+233)",@"Gibraltar (+350)",@"Gre(+30)",@"Greenland (+299)",@"Grenada (+1473)",@"Guam (+1671)",@"Guatemala (+502)",@"Guinea (+224)",@"Guinea-Bissau (+245)",@"Guyana (+592)",@"Haiti (+509)",@"Holy See  Vatican City (+39)",@"Honduras (+504)",@"HK(+852)",@"Hungary (+36)",@"Iceland (+354)",@"Indonesia (+62)",@"Iran (+98)",@"Iraq (+964)",@"Ireland (+353)",@"Isle of Man (+44)",@"Israel (+972)",@"Italy (+39)",@"Ivory Coast (+225)",@"Jamaica (+1876)",@"Japan (+81)",@"Jor(+962)",@"Kazakhstan (+7)",@"Kenya (+254)",@"Kiribati (+686)",@"Kosovo (+381)",@"Kuwait (+965)",@"Kyrgyzs(+996)",@"Laos (+856)",@"Latvia (+371)",@"Lebanon (+961)",@"Lesotho (+266)",@"Liberia (+231)",@"Libya (+218)",@"Liechtenstein (+423)",@"Lithuania (+370)",@"Luxembourg (+352)",@"Macau (+853)",@"Macedonia (+389)",@"Madagas(+261)",@"Malawi (+265)",@"Malaysia (+60)",@"Maldives (+960)",@"Mali (+223)",@"Malta (+356)",@"MarshIsla(+692)",@"Mauritania (+222)",@"Mauritius (+230)",@"Mayotte (+262)",@"Mexico (+52)",@"Micronesia (+691)",@"Moldova (+373)",@"Monaco (+377)",@"Mongolia (+976)",@"Montenegro (+382)",@"Montserrat (+1 664)",@"Morocco (+212)",@"Mozambique (+258)",@"Namibia (+264)",@"Nauru (+674)",@"Nepal (+977)",@"Netherlands (+31)",@"Netherlands Antil(+599)",@"New Caledonia (+687)",@"New Zealand (+64)",@"Nicaragua (+505)",@"Niger (+227)",@"Nigeria (+234)",@"Niue (+683)",@"Norfolk Island (+672)",@"North Korea (+850)",@"Northern Mariana Islands (+1670)",@"Norway (+47)",@"Oman (+968)",@"Pakistan (+92)",@"Palau (+680)",@"Panama (+507)",@"Papua New Guinea (+675)",@"Paraguay (+595)",@"Peru (+51)",@"Philippines (+63)",@"Pitcairn Islands (+870)",@"Poland (+48)",@"Portugal (+351)",@"Puerto Rico (+1)",@"Qatar (+974)",@"Republic of the Congo (+242)",@"Romania (+40)",@"Russia (+7)",@"Rwanda (+250)",@"Saint Barthelemy (+590)",@"SaHel(+290)",@"Saint Kitts and Nevis (+1 869)",@"Saint Lucia (+1 758)",@"Saint Martin (+1 599)",@"Saint Pierre Miquelon (+508)",@"Saint Vincent and the Grenadines (+1 784)",@"Samoa (+685)",@"San Marino (+378)",@"Sao Tome and Princ(+239)",@"Saudi Arabia (+966)",@"Senegal (+221)",@"Serbia (+381)",@"Seychelles (+248)",@"Sierra Leone (+232)",@"Singap(+65)",@"Slovakia (+421)",@"Slovenia (+386)",@"Solomon Islands (+677)",@"Somalia (+252)",@"South Africa (+27)",@"South Korea (+82)",@"Sri Lanka (+94)",@"Sudan (+249)",@"Suriname (+597)",@"Swaziland (+268)",@"Sweden (+46)",@"Switzerland (+41)",@"Syria (+963)",@"Taiwan (+886)",@"Tajikistan (+992)",@"Tanzania (+255)",@"Thailand (+66)",@"Timor-Leste (+670)",@"Togo (+228)",@"Tokelau (+690)",@"Tonga (+676)",@"Trinidad and Tobago (+1 868)",@"Tunisia (+216)",@"Turkey (+90)",@"Turkmenistan (+993)",@"Turks and Caicos Islands (+1 649)",@"Tuvalu (+688)",@"Uganda (+256)",@"Ukraine (+380)",@"United Arab Emirates (+971)",@"United Kingdom (+44)",@"United States (+1)",@"Uruguay (+598)",@"Virgin Islands (+1 340)",@"Uzbekistan (+998)",@"Vanuatu (+678)",@"Venezuela (+58)",@"Vietnam (+84)",@"Wallis Fut(+681)",@"West Bank(+970)",@"Yemen (+967)",@"Zambia (+260)",@"Zimbabwe (+263)",nil];
    
    
    for (int i =0 ; i<250; i++) {
     
        NSString *countryName = countryList[i];
        
        NSMutableCharacterSet *characterSet = [NSMutableCharacterSet characterSetWithCharactersInString:@")-"];
        NSArray *arrayOfComponents = [countryName componentsSeparatedByCharactersInSet:characterSet];
        countryCodeStr = [arrayOfComponents componentsJoinedByString:@""];
        NSArray *splitStr = [countryCodeStr componentsSeparatedByString:@"("];
        NSString *countryStr = [splitStr objectAtIndex:0];
        [newCountryCodeStr addObject:countryStr];
        
    }
    
    NSString *firstLetter = [[detailsOfCallLogs objectForKey:@"fields"]valueForKey:@"callerid"];
    int times = [[firstLetter componentsSeparatedByString:@"+"] count]-1;
    if([detailsOfCallLogs count]!=0){
        NSString *str = @"";
        if(!(times == 1)){
              str = @"+";
        }
       
        NSString *oldTrimmedPhNumber = [[[detailsOfCallLogs objectForKey:@"fields"]valueForKey:@"callerid"]stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *phNumber = [[str stringByAppendingString:oldTrimmedPhNumber]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString *trimPhNumber =  [[phNumber stringByReplacingOccurrencesOfString:@" " withString:@""]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        
        numberField.text =[trimPhNumber stringByReplacingOccurrencesOfString:@"\u00a0" withString:@""];
        
        for (int i =0; i<250; i++) {
            
            NSString *countryName = countryList[i];
            
            
            NSMutableCharacterSet *characterSet = [NSMutableCharacterSet characterSetWithCharactersInString:@")-"];
            NSArray *arrayOfComponents = [countryName componentsSeparatedByCharactersInSet:characterSet];
            countryCodeStr = [arrayOfComponents componentsJoinedByString:@""];
            NSArray *splitStr = [countryCodeStr componentsSeparatedByString:@"("];
            NSString *countryStr = [splitStr objectAtIndex:1];
            countryCodeLength =[countryStr length];
            NSRange range = [trimPhNumber rangeOfString:countryStr];
            
            if(range.length != 0){
                NSLog(@"Rangee oF str %i",range.length);
                countryCodeTxtField.text = [splitStr objectAtIndex:0];
            }
            
        }
        
    }

    
    
    
    NSLog(@"Count --- >%d",countryList.count);

    NSLog(@"Enter The Screen");
    numberField.layer.cornerRadius = 0;
    creditUsedImg.hidden = YES;
    creditImg.hidden = YES;
    [self.creditSpinner startAnimating];
    [self.minuteUsedSpinner startAnimating];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"countryCode" ofType:@"plist"]];
    NSLog(@"dictionary = %@", dictionary);
    NSArray *array = [dictionary objectForKey:@"keyarray1"];
    NSLog(@"array = %@", array);
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    username = [defaults objectForKey:@"userName"];
    
   
    self.title =@"";
   
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];

    pickerViewContainer.hidden = YES;
    NSString *path = [[NSBundle mainBundle]pathForResource:@"countryCode" ofType:@"plist"];
    
    countryCodeData = [[NSArray alloc]initWithContentsOfFile:path];
    
    countryCodeData = [countryCodeData sortedArrayUsingSelector:@selector(compare:)];
   
    pickerViewContainer.frame = CGRectMake(0, 800, 320, 261);
    

    
    
   /* NSString *urlString = [NSString stringWithFormat:@"http://54.174.166.2/generate_token/?email_ID=g.bagul3@gmail.com"];
    NSURL *url1 = [NSURL URLWithString:urlString];
    NSError *error = nil;
    NSString *token = [NSString stringWithContentsOfURL:url1 encoding:NSUTF8StringEncoding error:&error];
    NSLog(@"Token--->%@",token);
    [defaults setObject:token forKey:@"token"];
    
    if (token == nil) {
        NSLog(@"Error retrieving token: %@", [error localizedDescription]);
    } else {
        _phone = [[TCDevice alloc] initWithCapabilityToken:token delegate:self];
    }*/
    
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        NSLog(@"There IS NO internet connection");
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please check Internet Connection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSString *url =[NSString stringWithFormat:@"http://54.174.166.2/getCallCredits?email_ID=%@",username];
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             creditsBalance.text = [[responseObject objectForKey:@"creditsBalance"]valueForKey:@"credits_balance"];
         
             callCreditsUsed.text = [[responseObject objectForKey:@"creditsBalance"]
                          valueForKey:@"call_credits_used"];

         
             if ([creditsBalance.text intValue] < 0) {
                 creditsBalance.text =@"0";
             }
             if ([callCreditsUsed.text intValue] < 0) {
                 callCreditsUsed.text =@"0";
             }
         
             [defaults setValue:creditsBalance.text forKey:@"credits"];
        
             [self.creditSpinner stopAnimating];
             [self.minuteUsedSpinner stopAnimating];
             creditUsedImg.hidden = NO;
             creditImg.hidden = NO;
         
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             creditUsedImg.hidden = NO;
             creditImg.hidden = NO;

             [self.creditSpinner stopAnimating];
             [self.minuteUsedSpinner stopAnimating];
             NSLog(@"Error: %@", error);
         
         }];
        UIImage *image = [UIImage imageNamed:@"header.png"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    }
    
   // CGRect rect =  CGRectMake(0, 0,100 ,100);
    //self.view.frame.size.width-(30)
    //imageView.frame = CGRectMake(0, 0, 40, );
    //self.navigationItem.titleView = imageView;
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url =[NSString stringWithFormat:@"http://54.174.166.2/getCallCredits?email_ID=%@",username];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         creditsBalance.text = [[responseObject objectForKey:@"creditsBalance"]valueForKey:@"credits_balance"];
         
         callCreditsUsed.text = [[responseObject objectForKey:@"creditsBalance"]
                                 valueForKey:@"call_credits_used"];
         
         
         if ([creditsBalance.text intValue] < 0) {
             creditsBalance.text =@"0";
         }
         if ([callCreditsUsed.text intValue] < 0) {
             callCreditsUsed.text =@"0";
         }
         
         [defaults setValue:creditsBalance.text forKey:@"credits"];
         
         [self.creditSpinner stopAnimating];
         [self.minuteUsedSpinner stopAnimating];
         creditUsedImg.hidden = NO;
         creditImg.hidden = NO;
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         creditUsedImg.hidden = NO;
         creditImg.hidden = NO;
         
         [self.creditSpinner stopAnimating];
         [self.minuteUsedSpinner stopAnimating];
         NSLog(@"Error: %@", error);
         
     }];

    
}

- (void)device:(TCDevice *)device didReceiveIncomingConnection:(TCConnection *)connection
{
    
  
    NSLog(@"Incoming connection from: %@", [connection parameters][@"From"]);
  if (device.state == TCDeviceStateBusy) {
        [connection reject];
    } else {
        [connection accept];
        //_connection = connection;
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma marks -UIPickerView & Delegate Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;

}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [newCountryCodeStr count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return newCountryCodeStr[row];
}


-(void)configureLeftMenuButton:(UIButton *)button
{
    
    CGRect frame = button.frame;
    frame.origin = (CGPoint) {0,0};
    frame.size = (CGSize){25,25};
    button.frame = frame;
    [button setImage:[UIImage imageNamed:@"togglebtnSlider.png"] forState:UIControlStateNormal];
    
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    countryCodeFlag = @"true";
    NSString *selectCountry = [newCountryCodeStr objectAtIndex:row];
    countryCodeTxtField.text = selectCountry;
}



- (IBAction)tapGestureKeyboard:(id)sender {
    pickerViewContainer.hidden = YES;
    [self.view endEditing:YES];
}

- (IBAction)countryCodePicker:(id)sender {
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"countryCode" ofType:@"plist"];
    
    countryCodeData = [[NSArray alloc]initWithContentsOfFile:path];
    
    //countryCodeData = [countryCodeData sortedArrayUsingSelector:@selector(compare:)];
    
    [UIView beginAnimations:nil context:NULL];
    //[UIView setAnimationDuration:0.3];
    pickerViewContainer.hidden = NO;
    //pickerViewContainer.frame = CGRectMake(0, 315, 320, 261);
    [UIView commitAnimations];

}

-(IBAction)dialButtonPressed:(id)sender
{
    

    NSLog(@"Call Button CLicked");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:numberField.text forKey:@"calledPhoneNumber"];
    
    if([creditsBalance.text isEqualToString:@"0"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"You have run out of minutes. Please purchase more credits" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }else if ([countryCodeTxtField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please select the country" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }else if ([numberField.text  isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter the phone number" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }else if([numberField.text length]<12 || [numberField.text length]>15){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please Enter Valid Number" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
       
    }else{
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *userName = [defaults objectForKey:@"userName"];
        NSLog(@"userName--->%@",userName);
        
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        NSDictionary *params = @{@"phoneNumber": self.numberField.text,@"email_ID":userName,@"callLimit":creditsBalance.text};
        _connection = [delegate.phone connect:params delegate:self];
        
        
        //AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    //delegate.phConnection = [delegate.phone connect:params delegate:nil];

        
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"callingScreenView"];
        
    [self presentViewController:vc animated:YES completion:nil ];
        
        phoneNumber = numberField.text;
        NSLog(@"Phone Number--->%@",phoneNumber);
    }
    
    }


-(IBAction)hangupButtonPressed:(id)sender
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.phConnection disconnect];
}

-(void)dialOne {
    [UIApplication sharedApplication].idleTimerDisabled = NO;
    pickerViewContainer.hidden = YES;
    numberField.text = [NSString stringWithFormat:@"%@1",numberField.text];
   
}



- (void)dialTwo {
    pickerViewContainer.hidden = YES;
    numberField.text = [NSString stringWithFormat:@"%@2",numberField.text];
}

- (void)dialThree {
    pickerViewContainer.hidden = YES;
     numberField.text = [NSString stringWithFormat:@"%@3",numberField.text];
    
}

- (void)dialFour {
    pickerViewContainer.hidden = YES;
     numberField.text = [NSString stringWithFormat:@"%@4",numberField.text];
}

- (void)dialFive{
    pickerViewContainer.hidden = YES;
     numberField.text = [NSString stringWithFormat:@"%@5",numberField.text];
}

- (void)dialSix{
    pickerViewContainer.hidden = YES;
     numberField.text = [NSString stringWithFormat:@"%@6",numberField.text];
}

- (void)dialSeven{
    pickerViewContainer.hidden = YES;
     numberField.text = [NSString stringWithFormat:@"%@7",numberField.text];
}

- (void)dialEight{
    pickerViewContainer.hidden = YES;
     numberField.text = [NSString stringWithFormat:@"%@8",numberField.text];
}

- (void)dialNine{
    pickerViewContainer.hidden = YES;
     numberField.text = [NSString stringWithFormat:@"%@9",numberField.text];
}

- (void)dialClear{
    pickerViewContainer.hidden = YES;
     numberField.text = @"";
}

- (void)dialZero{
    pickerViewContainer.hidden = YES;
     numberField.text = [NSString stringWithFormat:@"%@0",numberField.text];
}

- (void)dialbackspace{
    
    phoneNumber = numberField.text;
    
//    if ([phoneNumber length]-countryCodeLength < [phoneNumber length])
//    {
//        
//        phoneNumber = [phoneNumber substringToIndex:[phoneNumber length] - 1];
//        numberField.text = phoneNumber;
//        
//    } 
//    
    
    if ([phoneNumber length]>0)
            {
        
                phoneNumber = [phoneNumber substringToIndex:[phoneNumber length] - 1];
                numberField.text = phoneNumber;
                
            } 

}

- (IBAction)hidePickerView:(id)sender {
    NSLog(@"Clicked....");
    
    NSArray *splitStr = [[NSArray alloc]init];
    
    for (int i =0 ; i<250; i++) {
        
        
        
        
        NSString *countryName = countryList[i];
        
        
        NSMutableCharacterSet *characterSet = [NSMutableCharacterSet characterSetWithCharactersInString:@")-"];
        NSArray *arrayOfComponents = [countryName componentsSeparatedByCharactersInSet:characterSet];
        countryCodeStr = [arrayOfComponents componentsJoinedByString:@""];
        splitStr = [countryCodeStr componentsSeparatedByString:@"("];
        NSString *countryStr = [splitStr objectAtIndex:0];
        NSString *temp = [splitStr objectAtIndex:1];
        NSLog(@"countryCodeTxtField----%d",i);
        NSString *str = countryCodeTxtField.text;
        if([str isEqualToString:countryStr]){
            
           countryCode = temp;
        }
    }
    
    numberField.text = countryCode;
    countryCodeLength = [numberField.text length];
    pickerViewContainer.hidden = YES;
    [UIView beginAnimations:nil context:NULL];
    //[UIView setAnimationDuration:0.3];
    //pickerViewContainer.frame = CGRectMake(0, 800, 320, 261);
    [UIView commitAnimations];
    

}





-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    if(textField == countryCodeTxtField){
        pickerViewContainer.hidden = NO;
    }
    [textField resignFirstResponder];
    
    return YES;
}
-(BOOL) textFieldShouldBeginEditing:(UITextField *)field {
    return NO;
}



- (IBAction)phoneContact:(id)sender {
    
    contacts = [[ABPeoplePickerNavigationController alloc] init];
    
    [contacts setPeoplePickerDelegate:self];
    
    [contacts setDisplayedProperties:[NSArray arrayWithObject:[NSNumber numberWithInt:kABPersonPhoneProperty]]];
    NSLog(@"Phone Number---->%d",kABPersonPhoneProperty);
    
    
    //[self presentViewController:contacts animated:YES];
     [self presentViewController:contacts animated:YES completion:nil ];

}

- (IBAction)additionSign:(id)sender {
    pickerViewContainer.hidden = YES;
    numberField.text = [NSString stringWithFormat:@"%@+",numberField.text];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

-(void)connectionDidConnect:(TCConnection *)connection{
    NSLog(@"Connected.....");
    callingVieController *viewObj = [[callingVieController alloc] init];
    //view.displayTimer.hidden = NO;
   // [viewObj timer];
}

-(void)connectionDidDisconnect:(TCConnection *)connection{
    NSLog(@"Disconnect....");
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"callingScreenView"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate registrationForTwilio];

}

-(void)connectionDidStartConnecting:(TCConnection *)connection{
    NSLog(@"Connecting........");
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark - UITableView Delegate Methods

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


/*-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person{
    
    NSLog(@"Selected Person------>%@",person);
    return YES;
}*/

/*-(void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person{
    NSLog(@"\n");
   
    NSLog(@"Slected---->%@",person );
    
        NSLog(@"\n");
}*/


-(void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
   
    ABMutableMultiValueRef multiEmail = ABRecordCopyValue(person, property);
    NSString *phoneNumber = (__bridge NSString *) ABMultiValueCopyValueAtIndex(multiEmail, identifier);
    
    NSMutableCharacterSet *characterSet =
    [NSMutableCharacterSet characterSetWithCharactersInString:@"()-"];
    NSArray *arrayOfComponents = [phoneNumber componentsSeparatedByCharactersInSet:characterSet];
    phoneNumberStr = [arrayOfComponents componentsJoinedByString:@""];
     NSString *firstLetter = [phoneNumberStr substringToIndex:1];
    
    
    if([firstLetter isEqualToString:@"+"]){
        
        NSString *phNumber = [[[phoneNumberStr stringByReplacingOccurrencesOfString:@" " withString:@""]stringByReplacingOccurrencesOfString:@" " withString:@""]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        numberField.text = phNumber;
        NSString *phoneNumber= phoneNumberStr;
        NSLog(@"Phone Number----->%@",phoneNumberStr);
        
        for (int i= 0 ; i<250; i++) {
         
            
            NSString *countryName = countryList[i];
            
            
            NSMutableCharacterSet *characterSet = [NSMutableCharacterSet characterSetWithCharactersInString:@")-"];
            NSArray *arrayOfComponents = [countryName componentsSeparatedByCharactersInSet:characterSet];
            countryCodeStr = [arrayOfComponents componentsJoinedByString:@""];
            NSArray *splitStr = [countryCodeStr componentsSeparatedByString:@"("];
            NSString *countryStr = [splitStr objectAtIndex:1];
            
            NSArray *temp = [phoneNumberStr componentsSeparatedByString:@" "];
            NSString *countryCodeStr = [temp objectAtIndex:0];
            NSRange range = [countryCodeStr rangeOfString:countryStr];
            
            if(range.length != 0){
                NSLog(@"Rangee oF str %i",range.length);
                countryCodeTxtField.text = [splitStr objectAtIndex:0];
               
            }
            
        }
        
        
    }else if([countryCodeFlag isEqualToString:@"true"]){
        numberField.text = [[[countryCode stringByAppendingString:phoneNumberStr]stringByReplacingOccurrencesOfString:@" " withString:@""]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSLog(@"numberField.text----%@",numberField.text);
        numberField.text = [numberField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    }else{
        numberField.text=[[phoneNumberStr stringByReplacingOccurrencesOfString:@" " withString:@""]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    
    
    
}


-(void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker{
 //   [contacts dismissModalViewControllerAnimated:YES];
    [contacts dismissViewControllerAnimated:true completion:nil];
    if(![phoneNumberStr isEqualToString:nil]){
        NSString *firstLetter = [phoneNumberStr substringFromIndex:1];
        
        if([firstLetter isEqualToString:@"+"]){
            numberField.text = phoneNumberStr;
        }else{
                numberField.text = [countryCode stringByAppendingString:phoneNumberStr] ;
        }
        

    }
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Index Path --->%d",indexPath.row);
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if([numberField.text length]<=4)
        return YES;
    else
        return NO;
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [dialBtn count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier =@"Cell";
    customViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
   
    if(indexPath.row!=11){
        [cell.collectionViewBtn setTitle:[dialBtn objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    }else{
        //[cell.collectionViewBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
        cell.imageView.image =  [UIImage imageNamed:@"arrow.png"];
    }
   
    [dialBtn objectAtIndex:indexPath.row];
    if(indexPath.row == 0){
            [cell.collectionViewBtn addTarget:self action:@selector(dialOne) forControlEvents:UIControlEventTouchUpInside];
    }else if(indexPath.row == 1){
        [cell.collectionViewBtn addTarget:self action:@selector(dialTwo) forControlEvents:UIControlEventTouchUpInside];
    }else if(indexPath.row == 2){
        [cell.collectionViewBtn addTarget:self action:@selector(dialThree) forControlEvents:UIControlEventTouchUpInside];
    }else if(indexPath.row == 3){
        [cell.collectionViewBtn addTarget:self action:@selector(dialFour) forControlEvents:UIControlEventTouchUpInside];
    }else if(indexPath.row == 4){
        [cell.collectionViewBtn addTarget:self action:@selector(dialFive) forControlEvents:UIControlEventTouchUpInside];
    }else if(indexPath.row == 5){
        [cell.collectionViewBtn addTarget:self action:@selector(dialSix) forControlEvents:UIControlEventTouchUpInside];
    }else if(indexPath.row == 6){
        [cell.collectionViewBtn addTarget:self action:@selector(dialSeven) forControlEvents:UIControlEventTouchUpInside];
    }else if(indexPath.row == 7){
        [cell.collectionViewBtn addTarget:self action:@selector(dialEight) forControlEvents:UIControlEventTouchUpInside];
    }else if(indexPath.row == 8){
        [cell.collectionViewBtn addTarget:self action:@selector(dialNine) forControlEvents:UIControlEventTouchUpInside];
    }else if(indexPath.row == 9){
        [cell.collectionViewBtn addTarget:self action:@selector(dialClear) forControlEvents:UIControlEventTouchUpInside];
    }else if(indexPath.row == 10){
        [cell.collectionViewBtn addTarget:self action:@selector(dialZero) forControlEvents:UIControlEventTouchUpInside];
    }else if(indexPath.row == 11){
        [cell.collectionViewBtn addTarget:self action:@selector(dialbackspace) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    
    
    return cell;
}





- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
   NSInteger width = collectionView.frame.size.width;
    NSUInteger height = collectionView.frame.size.height;
    
    if(width == 375){
         NSLog(@"Index Path ---->%d",indexPath.row);
        return CGSizeMake(115, 70);
        
    }else if(width == 414){
        
        return CGSizeMake(130, 80);
    }else{
        return CGSizeMake(100, 58);
    }
   
    
}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 0; // This is the minimum inter item spacing, can be more
//}





@end
