//
//  SkadateViewController.m
//  Skadate
//
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import "SkadateAppDelegate.h"
#import "SkadateViewController.h"
#import "SignUPFirstView.h"
#import "HomeView.h"
#import "ForgotPassword.h"
#import "JSON.h"

@implementation SkadateViewController
@synthesize textFldUsername;
@synthesize textFldPassword;
@synthesize textFldURL;
@synthesize btnSignIn;
@synthesize btnSignUp;
@synthesize btnFrgtPwd;
@synthesize navBar;
@synthesize lblNavTitle;
@synthesize imgView;
@synthesize lblEmail;
@synthesize lblPassword;
@synthesize lblSite;
@synthesize tempScrollView;
@synthesize strUsername;
@synthesize strURL;
@synthesize strPassword;
@synthesize strEncryptedPass;
@synthesize SALT;

#pragma mark Memory Management

- (void)dealloc
{    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark initWithNibName

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        // Custom initialization
    }
    return self;
}

#pragma mark Custom Methods

- (NSString *)stringToSha1:(NSString *)str
{    
    const char *s = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *keyData = [NSData dataWithBytes:s length:strlen(s)];
    
    // This is the destination
    uint8_t digest[CC_SHA1_DIGEST_LENGTH] = {0};
    /// This one function does an unkeyed SHA1 hash of your hash data
    CC_SHA1(keyData.bytes, keyData.length, digest);
    
    // Now convert to NSData structure to make it usable again
    NSData *out = [NSData dataWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
    // description converts to hex but puts <> around it and spaces every 4 bytes
    NSString *hash = [out description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    return hash;
}

- (BOOL) validateUrl: (NSString *) testURL 
{    
    NSString *urlRegEx = @"(http|https)://+[A-Za-z0-9.-]+([\\.|/]+((\\w)*|([0-9]*)|([-|_])*))+";
    
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx]; 
    return [urlTest evaluateWithObject:testURL];
}

/*-(void)iPadOrientation
{    return;
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) 
    {
        if (self.interfaceOrientation==UIInterfaceOrientationPortrait || self.interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) 
        {
            
            indicatorView.frame = CGRectMake(250, 310, 300, 300);
            [tempScrollView setFrame:(CGRectMake(0, 44, 768, 980))];
            tempScrollView.contentSize=CGSizeMake(768, 980);
            
            [imgView setFrame:(CGRectMake(84, 60, 600, 110))];
            [textFldUsername setFrame:CGRectMake(220, 70, 535, 60)];
            [textFldPassword setFrame:CGRectMake(220, 105, 535, 60)];
            [textFldURL setFrame:CGRectMake(114, 152, 535, 60)];
            
            [btnFrgtPwd setFrame:(CGRectMake(520, 230, 150, 37))];
            [btnSignIn setFrame:(CGRectMake(231, 280, 306, 46))];
        }
        else if (self.interfaceOrientation==UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation==UIInterfaceOrientationLandscapeRight)
        {
            
            indicatorView .frame=CGRectMake(364, 234, 300, 300);
            [tempScrollView setFrame:(CGRectMake(0, 44, 1024, 724))];
            tempScrollView.contentSize=CGSizeMake(1024, 724);
            
            [imgView setFrame:(CGRectMake(212, 60, 600, 150))];
            
            [textFldUsername setFrame:CGRectMake(237, 60, 535, 60)];
            [textFldPassword setFrame:CGRectMake(237, 105, 535, 60)];
            [textFldURL setFrame:CGRectMake(237, 152, 535, 60)];
            
            [btnFrgtPwd setFrame:(CGRectMake(642, 230, 150, 37))];
            [btnSignIn setFrame:(CGRectMake(359, 280, 306, 46))];
            
        } 
    }
}*/



#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

- (void)viewDidLoad
{
    
    self.navigationController.navigationBarHidden=YES;
    strUsername=[[[NSString alloc]init] retain];
    strPassword=[[[NSString alloc]init] retain];
    strURL=[[[NSString alloc]init] retain];
    
    btnSignUp.hidden = YES;
        
    [self.view setBackgroundColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redVal/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenVal/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueVal/255.0 alpha:1.0]];
    [imgView setBackgroundColor:[UIColor clearColor]];
    
    [navBar setTintColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavbar/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavbar/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavbar/255.0 alpha:1.0]];
    navBar.layer.borderColor=[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavBorder/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavBorder/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavBorder/255.0 alpha:1.0].CGColor;
    navBar.layer.borderWidth=1.0f;
    lblNavTitle.font= ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontNavTitle;
    lblEmail.font=((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontHomeTitle;
    lblPassword.font=((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontHomeTitle;
    lblSite.font=((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontHomeTitle;
    
    [lblNavTitle setText:@"Sign In"];
    
    textFldUsername.font=[UIFont fontWithName:@"Ubuntu-Bold" size:13];
    textFldPassword.font=[UIFont fontWithName:@"Ubuntu-Bold" size:13];
    textFldURL.font=[UIFont fontWithName:@"Ubuntu-Bold" size:13];
    
    if ( [self siteUrlEmbedded] )
    {
        [textFldURL setHidden:YES];
        [imgView setImage:[UIImage imageNamed:@"bg_2.png"]];
        [imgView setFrame:(CGRectMake(10, 69, 299, 110))];
    }
    else
    {
        [textFldURL setDelegate:self];
        [textFldURL setTag:3];
    }
    
    [tempScrollView setContentMode:UIViewContentModeScaleAspectFit];
    [tempScrollView sizeToFit];

    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) 
    {
        tempScrollView.contentSize=CGSizeMake(300,418);
    }
    
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated
{    
    [[NSNotificationCenter defaultCenter] 
     postNotificationName:@"InvalidateHomePageTimers" object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{   
    
    //[self iPadOrientation];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


//-(NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskAll;
//}

-(BOOL)shouldAutorotate
{
    return NO;
}

/*-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
       
    //if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    //{
        //[self iPadOrientation];
        
    //}
    
}*/


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
    
    // Return YES for supported orientations
    
    /*if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {        
        //[self iPadOrientation];
        return YES;  
    }
    else 
    {
        return NO;  
    }*/
    
}


#pragma mark Text Field Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{      
    if (textField==textFldUsername) 
    {        
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        
        if (newLength > 50) 
        {            
            return NO;
        }
        else
        {            
            NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789._@"] invertedSet];
            NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
            return [string isEqualToString:filtered];
        }
    }
    else
    {
        return YES;
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{    
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) 
    {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    }
    else 
    {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}


- (IBAction)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (textField.tag!=3) 
    {
        return;
    }
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        return;
    }
    [tempScrollView setContentOffset:CGPointMake(0,40) animated:YES];

}

- (IBAction)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag!=3) 
    {
        return;
    }
   
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        return;
    }
    [tempScrollView setContentOffset:CGPointMake(0,0) animated:YES];

}

#pragma mark -IBAction

- (IBAction)clickedSignInButton:(id)sender
{
    [textFldUsername resignFirstResponder];
    [textFldPassword resignFirstResponder];
    [textFldURL resignFirstResponder];
    
    btnSignIn.enabled=NO;
    //btnSignUp.enabled=NO;
    btnFrgtPwd.enabled=NO;
    strUsername = self.textFldUsername.text;
    strPassword = self.textFldPassword.text;
    
    if ( [self siteUrlEmbedded] )
    {
        strURL = [self getSiteUrl];
    }
    else
    {
        strURL = self.textFldURL.text;
    }
    
    if ( [textFldUsername.text isEqualToString:@""] || [textFldPassword.text isEqualToString:@""] || (![self siteUrlEmbedded] && [textFldURL.text isEqualToString:@""]) )
    {
        btnSignIn.enabled=YES;
        //btnSignUp.enabled=YES;
        btnFrgtPwd.enabled=YES;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Please fill all fields." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return;
    }
    
    if ( ![strURL hasPrefix:@"http://"] )
    {
        strURL = [NSString stringWithFormat:@"http://%@", strURL];
    }
    
    if ( ![self validateUrl:strURL] )
    {        
        btnSignIn.enabled=YES;
        btnFrgtPwd.enabled=YES;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Please enter a valid Website." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return;
    }

    signinFlag=NO;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setValue:strURL forKey:@"URL"];
    NSString *domain = [prefs stringForKey:@"URL"];
    NSString *req = [NSString stringWithFormat:@"%@/%@",domain,@"mobile/Init/"];
    
    [JSWaiter ShowWaiter:self title:@"Loading . ." type:0];
    [self performSelectorOnMainThread:@selector(WebRequest:) withObject:req waitUntilDone:NO];
}

-(void)WebRequest:(NSString*)url
{
    JSWebManager* webMgr = [[[JSWebManager alloc] initWithAsyncOption:NO] autorelease];
    NSDictionary* ret = [webMgr GetDataFromUrl:url];
    NSError* error = [ret objectForKey:@"error"];
    if (error)
    {
        btnSignIn.enabled=YES;
        btnFrgtPwd.enabled=YES;
        [[[[UIAlertView alloc] initWithTitle:@"Error" message:[@"Connection failed...Please try again." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease] show];
    }
    else
    {
        NSDictionary *parsedData = [ret objectForKey:@"data"];

        if(!parsedData)
        {
            btnSignIn.enabled=YES;
            btnFrgtPwd.enabled=YES;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to retrieve data from the site. Kindly re-enter login credentials." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
        }
        else
        {
            if (!signinFlag)
            {
                SALT=(NSString*)[parsedData objectForKey:@"Salt"];
                
                if([(NSString*)[parsedData objectForKey:@"Message"] isEqualToString:@"Site suspended"])
                {
                    ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Site suspended";
                    
                    UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Site suspended. Please try after sometime." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
                    [sessionAlertView show];
                    [sessionAlertView release];
                    btnSignIn.enabled=YES;
                    btnFrgtPwd.enabled=YES;
                    [JSWaiter HideWaiter];
                    return;
                    
                }
                
                if (!SALT)
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Entered site is not vallid" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alertView show];
                    [alertView release];
                    btnSignIn.enabled=YES;
                    btnFrgtPwd.enabled=YES;
                    [JSWaiter HideWaiter];
                    return;
                }
                
                strUsername = self.textFldUsername.text;
                strPassword=self.textFldPassword.text;
                NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                [prefs setValue:strURL forKey:@"URL"];
                
                NSString *domain = [prefs stringForKey:@"URL"];
                
                NSString *req = [NSString stringWithFormat:@"%@/mobile/SignIn/index.php?param=login&u=%@&p=%@&t=1",domain,strUsername,strPassword];
                
                signinFlag=YES;
                [self performSelectorOnMainThread:@selector(WebRequest:) withObject:req waitUntilDone:NO];
            }
            else
            {
                respSignIn.profileId = (NSString*)[parsedData objectForKey:@"profile_id"];
                if ([respSignIn.profileId isEqualToString:@"NULL"]||[respSignIn.profileId isEqualToString:@"0."])
                {
                    btnSignIn.enabled=YES;
                    btnFrgtPwd.enabled=YES;
                    [JSWaiter HideWaiter];
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"ERROR" message:[parsedData objectForKey:@"Message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alertView show];
                    [alertView release];
                    textFldUsername.text = nil;
                    textFldPassword.text = nil;
                }
                else
                {
                    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                    [prefs setValue:textFldUsername.text forKey:@"Username"];
                    [prefs setValue:textFldPassword.text forKey:@"Password"];
                    [prefs setValue:strURL forKey:@"URL"];
                    
                    NSString *originalPath =[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]  stringByAppendingPathComponent:@"Images"];
                    [[NSFileManager defaultManager] removeItemAtPath:originalPath error:NULL];
                    
                    respSignIn.profilePicURL = (NSString*)[parsedData objectForKey:@"Profile_Pic"];
                    respSignIn.notifications = (NSNumber*)[parsedData objectForKey:@"Notifications"];
                    respSignIn.gender = (NSString*)[parsedData objectForKey:@"sex"];
                    respSignIn.skey=(NSString*)[parsedData objectForKey:@"skey"];
                    respSignIn.TimeZone=(NSString*)[parsedData objectForKey:@"Time"];
                    
                    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID=respSignIn.profileId;
                    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID=respSignIn.skey;
                    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfilePic=respSignIn.profilePicURL;
                    
                    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedNotifications=0;
                    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).genderValue=respSignIn.gender;
                    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedTimeZone=respSignIn.TimeZone;
                    
                    btnSignIn.enabled=YES;
                    btnFrgtPwd.enabled=YES;
                    [JSWaiter HideWaiter];
                    textFldUsername.text=@"";
                    textFldPassword.text=@"";
                    
                    HomeView *objHomeView=[[HomeView alloc]initWithNibName:@"HomeView" bundle:nil];
                    
                    objHomeView.profileID=respSignIn.profileId;
                    objHomeView.profilePic=respSignIn.profilePicURL;
                    objHomeView.notifications=respSignIn.notifications;
                    [self.navigationController pushViewController:objHomeView animated:YES];
                    [objHomeView release];
                }
                
            }
        }
    }
    [JSWaiter HideWaiter];
}

- (IBAction)clickedSignUpButton:(id)sender
{
    [self.textFldUsername resignFirstResponder];
    [self.textFldPassword resignFirstResponder];
    [self.textFldURL resignFirstResponder];
    SignUPFirstView *objSignUpFirstView=[[SignUPFirstView alloc]initWithNibName:@"SignUPFirstView" bundle:nil];
    [self.navigationController pushViewController:objSignUpFirstView animated:YES];
    [objSignUpFirstView release];
}


- (IBAction)clickedForgotPasswordButton:(id)sender
{
    ForgotPassword *objForgtPsw=[[ForgotPassword alloc]initWithNibName:@"ForgotPassword" bundle:nil];
    [self.navigationController pushViewController:objForgtPsw animated:YES];
    [objForgtPsw release];
}


#pragma mark Managing API Calls

- (BOOL)siteUrlEmbedded
{
    NSString *urlKey;
    urlKey =[[NSBundle mainBundle] objectForInfoDictionaryKey:@"SKAPIURL"];
    
    return [urlKey length] != 0;
}

- (NSString *)getSiteUrl
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"SKAPIURL"];
}

@end
