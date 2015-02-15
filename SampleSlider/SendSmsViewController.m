//
//  SendSmsViewController.m
//  SampleSlider
//
//  Created by Jayesh on 25/11/14.
//  Copyright (c) 2014 WhiteSnow. All rights reserved.
//

#import "SendSmsViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"

@interface SendSmsViewController ()<MBProgressHUDDelegate>{
    
    NSString *userName;
    NSString *phoneNumberStr;
    NSString *countryCodeFlag;
    NSString *countryCode;
    MBProgressHUD *HUD;
    NSMutableArray *newCountryCodeStr;
    NSArray *countryList;
     NSString *countryCodeStr;
    NSUInteger countryCodeLength;
    
}

@end




@implementation SendSmsViewController
@synthesize sendSmsTextField,senderNumber,countryCodeData,countryCodeName,pickerViewContainer,textRemaining,textUsed,contacts,creditRemaingSpinner,creditRemainigImg,textUsedImg,textUsedSpinner;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*[[UINavigationBar appearance]setBackgroundColor:[UIColor grayColor]];
    UIImageView* titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    [titleImage setImage:[UIImage imageNamed:@"logo-siempre-transparent.png"]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    self.navigationItem.titleView = titleImage;*/
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo-siempre-transparent.png"]];
    titleImageView.frame = CGRectMake(30, 0, 0, self.navigationController.navigationBar.frame.size.height); // Here I am passing
    titleImageView.contentMode=UIViewContentModeScaleAspectFit;
    self.navigationItem.titleView = titleImageView;
    
    newCountryCodeStr = [[NSMutableArray alloc]init];
    
    
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
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString * phNumber = [defaults objectForKey:@"phNumber"];
    if([phNumber length] != 0){
        senderNumber.text = phNumber;
        
        
        NSString *oldTrimmedPhNumber = [phNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *phNumber = [oldTrimmedPhNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString *trimPhNumber =  [[phNumber stringByReplacingOccurrencesOfString:@" " withString:@""]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        
        senderNumber.text =[trimPhNumber stringByReplacingOccurrencesOfString:@"\u00a0" withString:@""];
        
        
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
                countryCodeName.text = [splitStr objectAtIndex:0];
            }
        
        }
    }
    

    self.title=@"";
    NSLog(@"Enter The Text Screen");
    pickerViewContainer.hidden = YES;
    creditRemainigImg.hidden =YES;
    textUsedImg.hidden = YES;
    [self.creditRemaingSpinner startAnimating];
    [self.textUsedSpinner startAnimating];

    userName = [defaults objectForKey:@"userName"];
    NSLog(@"username---->%@",userName);

    NSString *path = [[NSBundle mainBundle]pathForResource:@"countryCode" ofType:@"plist"];
    
    countryCodeData = [[NSArray alloc]initWithContentsOfFile:path];
    
    countryCodeData = [countryCodeData sortedArrayUsingSelector:@selector(compare:)];
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    pickerViewContainer.frame = CGRectMake(0,800, 320, 261);
    
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *url = [NSString stringWithFormat:@"http://54.174.166.2/getTextCredits?email_ID=%@",userName];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"Response----%@",responseObject);
         
         textRemaining.text = [[responseObject objectForKey:@"creditsBalance"]valueForKey:@"credits_balance"];

         textUsed.text = [[responseObject objectForKey:@"creditsBalance"]
                          valueForKey:@"text_credits_used"];
         
         if ([textRemaining.text intValue] < 0) {
             textRemaining.text =@"0";
         }
         if ([textUsed.text intValue] < 0) {
             textUsed.text =@"0";
         }
         
         [self.creditRemaingSpinner stopAnimating];
         [self.textUsedSpinner stopAnimating];
         creditRemainigImg.hidden =NO;
         textUsedImg.hidden = NO;
         
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         [self.creditRemaingSpinner stopAnimating];
         [self.textUsedSpinner stopAnimating];
         creditRemainigImg.hidden =NO;
         textUsedImg.hidden = NO;
         
     }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)myTask{
    sleep(3);
}

- (IBAction)sendSmsButtonClicked:(id)sender
{
    
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.labelText = @"Sending.....";
    HUD.delegate = self;
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];

    pickerViewContainer.hidden =YES;
    if([textRemaining.text isEqualToString:@"0"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"You have run out of credits. Please purchase more credits" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }else if ([countryCodeName.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please select the country" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    } else if([senderNumber isEqual:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter the phone Number" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }else if([senderNumber.text length]<12 || [senderNumber.text length]>15){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter Valid Number" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];

        
    }else if(sendSmsTextField.text.length<=160) {
        
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        NSString* body = sendSmsTextField.text;
        NSString* sender_no = senderNumber.text;
        NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
        [DateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *startTime = [DateFormatter stringFromDate:[NSDate date]];
        
        NSLog(@"username---->%@",userName);
        
        NSString  *serverAddress = [NSString stringWithFormat:@"http://54.174.166.2/sendSms/?email_ID=%@&receiver=%@&body=%@&time=%@",[userName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[sender_no stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"],[body stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[startTime stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"ServerText---->%@",serverAddress);
        [manager GET:serverAddress parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             self.posts = (NSDictionary *) responseObject;
             self.post = self.posts[@"sendSms"][@"success"];
             NSString *value = self.posts[@"sendSms"][@"success"];
             
             if ([value isEqualToString:@"true"])
             {
                 //[self performSegueWithIdentifier:@"SignInSegue" sender:self];
                 HUD.hidden = YES;
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message Alert" message:@"Message Sent Successfully..." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [alert show];
                 senderNumber.text =@"";
                 sendSmsTextField.text=@"";
                 
                 
                 //Call a link for Database Entry OF the Message
                 NSString *url = [NSString stringWithFormat:@"http://54.174.166.2/getTextCredits?email_ID=%@",userName];
                 
                 [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
                  {
                      NSLog(@"Response----%@",responseObject);
                      
                      textRemaining.text = [[responseObject objectForKey:@"creditsBalance"]valueForKey:@"credits_balance"];
                      
                      textUsed.text = [[responseObject objectForKey:@"creditsBalance"]
                                       valueForKey:@"text_credits_used"];
                      
                  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                      NSLog(@"Error: %@", error);
                      
                  }];
                 
                 
                 
             }else{
                
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Message could not be deliverd" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [alert show];
             }
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error..!!" message:@"Error Connecting to Server...!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             [alert show];
         }];
    }
}



#pragma mark _UIPickerView Datasource & Delegate Methods
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

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSString *selectCountry = [newCountryCodeStr objectAtIndex:row];
    countryCodeName.text = selectCountry;
    countryCodeFlag = @"true";
    
}


- (IBAction)tapGestureSendSms:(id)sender {
    //pickerViewContainer.hidden = YES;
    [self.view endEditing:YES];
}
- (IBAction)showPickerBtn:(id)sender {
    NSString *path = [[NSBundle mainBundle]pathForResource:@"countryCode" ofType:@"plist"];
    
    countryCodeData = [[NSArray alloc]initWithContentsOfFile:path];
    
    countryCodeData = [countryCodeData sortedArrayUsingSelector:@selector(compare:)];
    
    [UIView beginAnimations:nil context:NULL];
    //[UIView setAnimationDuration:0.3];
    pickerViewContainer.hidden = NO;
   // pickerViewContainer.frame = CGRectMake(0, 315, 320, 261);
    [UIView commitAnimations];

}

- (IBAction)hidePickerView:(id)sender {
    
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
        NSString *str = countryCodeName.text;
        if([str isEqualToString:countryStr]){
            
            countryCode = temp;
        }
    }
    senderNumber.text = countryCode;
    countryCodeLength =[senderNumber.text length];
    
   [UIView beginAnimations:nil context:NULL];
   // [UIView setAnimationDuration:0.3];
    //pickerViewContainer.frame = CGRectMake(0, 800, 320, 261);
    [UIView commitAnimations];
    pickerViewContainer.hidden = YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField ==senderNumber) {
        textField.keyboardType = UIKeyboardTypeNumberPad;
        pickerViewContainer.hidden =YES;

        return YES;
    }else if(textField == senderNumber || textField == sendSmsTextField){
        
        pickerViewContainer.hidden =YES;
        return YES;
    }else{
        return  NO;
    }
}

- (IBAction)contactBtn:(id)sender {
    
    contacts = [[ABPeoplePickerNavigationController alloc] init];
    
    [contacts setPeoplePickerDelegate:self];
    
    [contacts setDisplayedProperties:[NSArray arrayWithObject:[NSNumber numberWithInt:kABPersonPhoneProperty]]];
    NSLog(@"Phone Number---->%d",kABPersonPhoneProperty);
    
    
    //[self presentViewController:contacts animated:YES];
    [self presentViewController:contacts animated:YES completion:nil ];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}


-(void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    
    ABMutableMultiValueRef multiEmail = ABRecordCopyValue(person, property);
    NSString *phoneNumber = (__bridge NSString *) ABMultiValueCopyValueAtIndex(multiEmail, identifier);
    
    NSMutableCharacterSet *characterSet =
    [NSMutableCharacterSet characterSetWithCharactersInString:@"()-"];
    NSArray *arrayOfComponents = [phoneNumber componentsSeparatedByCharactersInSet:characterSet];
    phoneNumberStr = [arrayOfComponents componentsJoinedByString:@""];
    NSString *firstLetter = [phoneNumberStr substringToIndex:1];
    
    
    if([firstLetter isEqualToString:@"+"]){
        
        senderNumber.text = [[[phoneNumberStr stringByReplacingOccurrencesOfString:@" " withString:@""]stringByReplacingOccurrencesOfString:@" " withString:@""]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        //numberField.text = phNumber;
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
                countryCodeName.text = [splitStr objectAtIndex:0];
            }
            /*if([countryCodeStr isEqualToString:countryStr]){
                countryCodeName.text = [splitStr objectAtIndex:0];
            }*/
        }

    }else if([countryCodeFlag isEqualToString:@"true"]){
        
        senderNumber.text = [[[countryCode  stringByAppendingString:phoneNumberStr]stringByReplacingOccurrencesOfString:@" " withString:@""]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                             
    }else{
        senderNumber.text=[[phoneNumberStr stringByReplacingOccurrencesOfString:@" " withString:@""]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    
    
    
}

-(void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker{
    //   [contacts dismissModalViewControllerAnimated:YES];
    [contacts dismissViewControllerAnimated:true completion:nil];
    if(![phoneNumberStr isEqualToString:nil]){
        
        NSString *firstLetter = [phoneNumberStr substringFromIndex:1];
        
        if([firstLetter isEqualToString:@"+"]){
            senderNumber.text = phoneNumberStr;
        }else{
            senderNumber.text = [countryCode stringByAppendingString:phoneNumberStr] ;
        }
        
    }
    
}



@end
