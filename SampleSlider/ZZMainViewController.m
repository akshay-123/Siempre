//
//  ZZMainViewController.m
//  PayPal-iOS-SDK-Sample-App
//
//  Copyright (c) 2014, PayPal
//  All rights reserved.
//
#import "Packs.h"
#import "ZZMainViewController.h"
#include "AFNetworking.h"

#import <QuartzCore/QuartzCore.h>

// Set the environment:
// - For live charges, use PayPalEnvironmentProduction (default).
// - To use the PayPal sandbox, use PayPalEnvironmentSandbox.
// - For testing, use PayPalEnvironmentNoNetwork.
#define kPayPalEnvironment PayPalEnvironmentNoNetwork

@interface ZZMainViewController ()

@property(nonatomic, strong, readwrite) IBOutlet UIButton *payNowButton;
@property(nonatomic, strong, readwrite) IBOutlet UIButton *payFutureButton;
@property(nonatomic, strong, readwrite) IBOutlet UIView *successView;

@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;
@property (strong, nonatomic) NSArray *rechargeList;


@property(nonatomic,strong) NSArray *recipeeArray;
@property(nonatomic,strong) NSDictionary *recipee;
@property (strong, nonatomic) NSDictionary *dictionary;
@end

@implementation ZZMainViewController
{
    NSMutableArray *packName;
    NSMutableArray *price;
    NSMutableArray *credits;
    NSString *pp,*pn,*pc;
    NSDecimalNumber *rechargeAmount;
    int rowcount;
    
    int  selectFlag;
}
@synthesize recipeeArray,recipee,packsPaypal,packagepay,amountspay,creditspay;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
    [[UINavigationBar appearance]setBackgroundColor:[UIColor grayColor]];
//    UIImageView* titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 25)];
//    [titleImage setImage:[UIImage imageNamed:@"logo-siempre-transparent.png"]];
//    self.navigationItem.titleView = titleImage;

    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo-siempre-transparent.png"]];
    titleImageView.frame = CGRectMake(0, 0, 0, self.navigationController.navigationBar.frame.size.height); // Here I am passing
    titleImageView.contentMode=UIViewContentModeScaleAspectFit;
    self.navigationItem.titleView = titleImageView;
    //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    //[[self navigationController] setNavigationBarHidden:YES animated:YES];
    // Set up payPalConfig
    _payPalConfig = [[PayPalConfiguration alloc] init];
    _payPalConfig.acceptCreditCards = YES;
    _payPalConfig.merchantName = @"Akshay Maldhure";
    _payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/privacy-full"];
    _payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/useragreement-full"];
    
    // Setting the languageOrLocale property is optional.
    //
    // If you do not set languageOrLocale, then the PayPalPaymentViewController will present
    // its user interface according to the device's current language setting.
    //
    // Setting languageOrLocale to a particular language (e.g., @"es" for Spanish) or
    // locale (e.g., @"es_MX" for Mexican Spanish) forces the PayPalPaymentViewController
    // to use that language/locale.
    //
    // For full details, including a list of available languages and locales, see PayPalPaymentViewController.h.
    
    _payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];
    
    
    // Setting the payPalShippingAddressOption property is optional.
    //
    // See PayPalConfiguration.h for details.
    
    _payPalConfig.payPalShippingAddressOption = PayPalShippingAddressOptionPayPal;
    
    // Do any additional setup after loading the view, typically from a nib.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"recipes" ofType:@"plist"];
    
    selectFlag= 0;
    
    packagepay = [NSMutableArray new];
    creditspay = [NSMutableArray new];
    amountspay = [NSMutableArray new];
    
    
    
    
    // Load the file content and read the data into arrays
  NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    NSLog(@"Dictionary--->%@",dict);
  //  NSDictionary *dict = [[NSDictionary alloc]init];
    //For adding th values from JSON
    
    
    
    
    
        NSLog(@"Values---->%@",self.dictionary);
    NSLog(@"%d",[packName count]);
    NSLog(@"Response Object---->%@",self.rechargeList);

    
    packName = [dict objectForKey:@"RecipeName"];
    price = [dict objectForKey:@"Thumbnail"];
    credits = [dict objectForKey:@"PrepTime"];
    
    self.successView.hidden = YES;
    
    // use default environment, should be Production in real life
    self.environment = kPayPalEnvironment;
    
    NSLog(@"PayPal iOS SDK version: %@", [PayPalMobile libraryVersion]);
    [self setPayPalEnvironment:@"live"];
    NSLog(@"%@",_payPalConfig.merchantName);
    NSLog(@"%@",self.environment);
    
    NSLog(@"PayPal iOS SDK version: %@", [PayPalMobile libraryVersion]);
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://54.174.166.2/getCreditPacks"]];
    
    NSData *theData = [NSURLConnection sendSynchronousRequest:request
                                            returningResponse:nil
                                                        error:nil];
    
    NSDictionary *newJSON = [NSJSONSerialization JSONObjectWithData:theData
                                                            options:0
                                                              error:nil];
    
    NSLog(@"Sync JSON: %@", newJSON);
    self.rechargeList =[newJSON objectForKey:@"creditsArray"];
    
    rowcount= [[newJSON objectForKey:@"creditsArray"]count];
    for (NSDictionary *temp  in self.rechargeList) {
        NSDictionary *fields = [temp objectForKey:@"fields"];
        
        
        [packagepay addObject:fields[@"name"]];
        [creditspay addObject:fields[@"credits"]];
        [amountspay addObject:fields[@"amount"]];
        
    }

}

-(void)viewDidAppear:(BOOL)animated{
   
     [_tableView reloadData];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    // Preconnect to PayPal early
    [self setPayPalEnvironment:@"live"];
   
}

- (void)setPayPalEnvironment:(NSString *)environment {
    self.environment = environment;
    [PayPalMobile preconnectWithEnvironment:environment];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return rowcount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    Packs *cell = (Packs *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier forIndexPath:indexPath];
    
    recipee = recipeeArray[indexPath.row];
    
    //NSLog(@"F----%@",tempP[]);
    NSString *packName1 = [NSString stringWithFormat:@"%@", packagepay[indexPath.row]];
    NSString *price1 = [NSString stringWithFormat:@"%@", amountspay[indexPath.row]];
    NSString *credits1 = [NSString stringWithFormat:@"%@", creditspay[indexPath.row]];
    
    cell.packName.text = packName1;
    cell.amount.text = price1;
    
    cell.credits.text = credits1;
    
    return cell;
}
- (void)setPackName:(NSString *)packn {
    self.pn = packn;
    NSLog(@"%@",packn);
}
- (void)setPackPrice:(NSString *)packp{
    self.pp = packp;
    NSLog(@"%@",packp);
    
}
- (void)setPackCredits:(NSString *)packc{
    self.pc = packc;
    NSLog(@"%@",packc);
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if((indexPath.row%2)==0){
        cell.backgroundColor = [UIColor colorWithRed:(226/255.0) green:(226/255.0) blue:(226/255.0) alpha:1];
    }else{
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    //cell.textLabel.textColor = [UIColor whiteColor];
    //cell.imageView.frame = CGRectMake(10, 10, 5, 5);
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath   *)indexPath
{
    Packs *selectedCell = (Packs*)[tableView cellForRowAtIndexPath:indexPath];
    [self setPackName:selectedCell.packName.text];
    [self setPackPrice:selectedCell.amount.text];
    [self setPackCredits:selectedCell.credits.text];
 
    selectFlag= 1;
    [self pay];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
    selectFlag=0;
    
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath;
}

#pragma mark - Receive Single Payment

- (IBAction)pay {
    
    if(selectFlag==1){
        NSString *pack=pn;
        NSString *price1=pp;
        NSLog(@"HEllooooo--->%@",pack);
        NSLog(@"HEllooooo--->%@",price1);
        
        // Remove our last completed payment, just for demo purposes.
        self.resultText = nil;
        
        PayPalItem *item1 = [PayPalItem itemWithName:[self pp]
                                        withQuantity:1
                                           withPrice:[NSDecimalNumber decimalNumberWithString:[self pp]]
                                        withCurrency:@"USD"
                                             withSku:@"Hip-00037"];
        
        NSArray *items = @[item1];
        NSDecimalNumber *subtotal = [PayPalItem totalPriceForItems:items];
        
        // Optional: include payment details
        NSDecimalNumber *shipping = [[NSDecimalNumber alloc] initWithString:@"0"];
        NSDecimalNumber *tax = [[NSDecimalNumber alloc] initWithString:@"0"];
        
        PayPalPaymentDetails *paymentDetails = [PayPalPaymentDetails paymentDetailsWithSubtotal:subtotal
                                                                                   withShipping:shipping
                                                                                        withTax:tax];
        
        NSDecimalNumber *total = [[subtotal decimalNumberByAdding:shipping] decimalNumberByAdding:tax];
        
        PayPalPayment *payment = [[PayPalPayment alloc] init];
        payment.amount = total;
        rechargeAmount = total;
        NSLog(@"Amount-------->%@",payment.amount);
        payment.currencyCode = @"USD";
        payment.shortDescription = [self pn];
        payment.items = items;  // if not including multiple items, then leave payment.items as nil
        payment.paymentDetails = paymentDetails; // if not including payment details, then leave payment.paymentDetails as nil
        
        if (!payment.processable) {
            // This particular payment will always be processable. If, for
            // example, the amount was negative or the shortDescription was
            // empty, this payment wouldn't be processable, and you'd want
            // to handle that here.
        }
        
        // Update payPalConfig re accepting credit cards.
        self.payPalConfig.acceptCreditCards = self.acceptCreditCards;
        
        PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment
                                                                                                    configuration:self.payPalConfig
                                                                                                         delegate:self];
        [self presentViewController:paymentViewController animated:YES completion:nil];
    }
    else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Alert" message: @"Please Select A Pack" delegate: self cancelButtonTitle: nil otherButtonTitles: @"OK",nil, nil];
        [alert show];
        
    }
}

#pragma mark PayPalPaymentDelegate methods

- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment {
    NSLog(@"PayPal Payment Success!");
    self.resultText = [completedPayment description];
        NSLog(@"Paypal Complition---->%@",self.resultText);
    NSString *amount =[completedPayment.confirmation objectForKey:@"Amount"];
    NSLog(@"Amount------->%@",amount);
    
    [self showSuccess];
    
    [self sendCompletedPaymentToServer:completedPayment]; // Payment was processed successfully; send to server for verification and fulfillment
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    NSLog(@"PayPal Payment Canceled");
    self.resultText = nil;
    self.successView.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Proof of payment validation

- (void)sendCompletedPaymentToServer:(PayPalPayment *)completedPayment {
    // TODO: Send completedPayment.confirmation to server
    NSLog(@"Complete Payment-------%@",completedPayment);
    
    NSLog(@"Here is your proof of payment:\n\n%@\n\nSend this to your server for confirmation and fulfillment.", [[completedPayment.confirmation objectForKey:@"response"]valueForKey:@"state"]);
    if([[[completedPayment.confirmation objectForKey:@"response"]valueForKey:@"state"] isEqualToString:@"approved"]){
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *username = [defaults objectForKey:@"userName"];
        
        NSString *payPalID = [[completedPayment.confirmation objectForKey:@"response"]valueForKey:@"id"];
        NSString *paymentTime = [[completedPayment.confirmation objectForKey:@"response"]valueForKey:@"create_time"];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        NSString *url = [NSString stringWithFormat:@"http://54.174.166.2/setCreditTransaction?email=%@&amount=%@&paymentTime=%@&paymentId=%@",username,rechargeAmount,paymentTime,payPalID];
        NSLog(@"url----%@",url);
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
             
         }];
        

        
        
    }
}


//#pragma mark - Authorize Future Payments
//
//- (IBAction)getUserAuthorizationForFuturePayments:(id)sender {
//
//  PayPalFuturePaymentViewController *futurePaymentViewController = [[PayPalFuturePaymentViewController alloc] initWithConfiguration:self.payPalConfig delegate:self];
//  [self presentViewController:futurePaymentViewController animated:YES completion:nil];
//}
//
//
//#pragma mark PayPalFuturePaymentDelegate methods
//
//- (void)payPalFuturePaymentViewController:(PayPalFuturePaymentViewController *)futurePaymentViewController
//                didAuthorizeFuturePayment:(NSDictionary *)futurePaymentAuthorization {
//  NSLog(@"PayPal Future Payment Authorization Success!");
//  self.resultText = [futurePaymentAuthorization description];
//  [self showSuccess];
//
//  [self sendFuturePaymentAuthorizationToServer:futurePaymentAuthorization];
//  [self dismissViewControllerAnimated:YES completion:nil];
//}
//
//- (void)payPalFuturePaymentDidCancel:(PayPalFuturePaymentViewController *)futurePaymentViewController {
//  NSLog(@"PayPal Future Payment Authorization Canceled");
//  self.successView.hidden = YES;
//  [self dismissViewControllerAnimated:YES completion:nil];
//}
//
//- (void)sendFuturePaymentAuthorizationToServer:(NSDictionary *)authorization {
//  // TODO: Send authorization to server
//  NSLog(@"Here is your authorization:\n\n%@\n\nSend this to your server to complete future payment setup.", authorization);
//}
//
//
//#pragma mark - Authorize Profile Sharing
//
//- (IBAction)getUserAuthorizationForProfileSharing:(id)sender {
//
//  NSSet *scopeValues = [NSSet setWithArray:@[kPayPalOAuth2ScopeOpenId, kPayPalOAuth2ScopeEmail, kPayPalOAuth2ScopeAddress, kPayPalOAuth2ScopePhone]];
//
//  PayPalProfileSharingViewController *profileSharingPaymentViewController = [[PayPalProfileSharingViewController alloc] initWithScopeValues:scopeValues configuration:self.payPalConfig delegate:self];
//  [self presentViewController:profileSharingPaymentViewController animated:YES completion:nil];
//}
//
//
//#pragma mark PayPalProfileSharingDelegate methods
//
//- (void)payPalProfileSharingViewController:(PayPalProfileSharingViewController *)profileSharingViewController
//             userDidLogInWithAuthorization:(NSDictionary *)profileSharingAuthorization {
//  NSLog(@"PayPal Profile Sharing Authorization Success!");
//  self.resultText = [profileSharingAuthorization description];
//  [self showSuccess];
//
//  [self sendProfileSharingAuthorizationToServer:profileSharingAuthorization];
//  [self dismissViewControllerAnimated:YES completion:nil];
//}
//
//- (void)userDidCancelPayPalProfileSharingViewController:(PayPalProfileSharingViewController *)profileSharingViewController {
//  NSLog(@"PayPal Profile Sharing Authorization Canceled");
//  self.successView.hidden = YES;
//  [self dismissViewControllerAnimated:YES completion:nil];
//}
//
//- (void)sendProfileSharingAuthorizationToServer:(NSDictionary *)authorization {
//  // TODO: Send authorization to server
//  NSLog(@"Here is your authorization:\n\n%@\n\nSend this to your server to complete profile sharing setup.", authorization);
//}
//

#pragma mark - Helpers

- (void)showSuccess {
    self.successView.hidden = NO;
    self.successView.alpha = 1.0f;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:2.0];
    self.successView.alpha = 0.0f;
    [UIView commitAnimations];
}

#pragma mark - Flipside View Controller

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"pushSettings"]) {
        [[segue destinationViewController] setDelegate:(id)self];
    }
}

- (IBAction)buyCredits:(id)sender {
    
    if(selectFlag==1){
        NSString *pack=pn;
        NSString *price1=pp;
        NSLog(@"%@",pack);
        NSLog(@"%@",price1);
        
        // Remove our last completed payment, just for demo purposes.
        self.resultText = nil;
        
        PayPalItem *item1 = [PayPalItem itemWithName:[self pp]
                                        withQuantity:1
                                           withPrice:[NSDecimalNumber decimalNumberWithString:[self pp]]
                                        withCurrency:@"USD"
                                             withSku:@"Hip-00037"];
        
        NSArray *items = @[item1];
        NSDecimalNumber *subtotal = [PayPalItem totalPriceForItems:items];
        
        // Optional: include payment details
        NSDecimalNumber *shipping = [[NSDecimalNumber alloc] initWithString:@"0"];
        NSDecimalNumber *tax = [[NSDecimalNumber alloc] initWithString:@"0"];
        
        PayPalPaymentDetails *paymentDetails = [PayPalPaymentDetails paymentDetailsWithSubtotal:subtotal
                                                                                   withShipping:shipping
                                                                                        withTax:tax];
        
        NSDecimalNumber *total = [[subtotal decimalNumberByAdding:shipping] decimalNumberByAdding:tax];
        
        PayPalPayment *payment = [[PayPalPayment alloc] init];
        payment.amount = total;
        payment.currencyCode = @"USD";
        payment.shortDescription = [self pn];
        payment.items = items;  // if not including multiple items, then leave payment.items as nil
        payment.paymentDetails = paymentDetails; // if not including payment details, then leave payment.paymentDetails as nil
        
        if (!payment.processable) {
            // This particular payment will always be processable. If, for
            // example, the amount was negative or the shortDescription was
            // empty, this payment wouldn't be processable, and you'd want
            // to handle that here.
        }
        
        // Update payPalConfig re accepting credit cards.
        self.payPalConfig.acceptCreditCards = self.acceptCreditCards;
        
        PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment
                                                                                                    configuration:self.payPalConfig
                                                                                                         delegate:self];
        [self presentViewController:paymentViewController animated:YES completion:nil];
    }
    else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Alert" message: @"Please Select A Pack" delegate: self cancelButtonTitle: nil otherButtonTitles: @"OK",nil, nil];
        [alert show];
        
    }
    
}
@end
