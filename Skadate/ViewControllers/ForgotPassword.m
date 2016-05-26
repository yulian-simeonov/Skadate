//
//  ForgotPassword.m
//  Chk
//
//  Created by kavitha on 31/08/11.
//  Copyright 2011 Solutions On Demand Australasia Pty Ltd. All rights reserved.
//

#import "ForgotPassword.h"
#import "SkadateViewController.h"
#import "SkadateAppDelegate.h"
#import "JSON.h"

@implementation ForgotPassword

@synthesize objSignInView;
@synthesize lblDefaultText;
@synthesize btnClose;
@synthesize mailID;
@synthesize lblNavTitle;
@synthesize navBar,lblforgotpass;
@synthesize imgView,siteUrlLbl,siteUrTF,strURL;
@synthesize NewXval;

#pragma mark Memory Management

- (void)dealloc
{
    [lblDefaultText release];
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

-(void)ios6ipad{
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        
        if (([[UIDevice currentDevice] orientation])==UIInterfaceOrientationLandscapeRight||([[UIDevice currentDevice] orientation])==UIInterfaceOrientationLandscapeLeft)
        {
            [imgView setFrame:(CGRectMake(230, 60, 600, 120))];
            [lblforgotpass setFrame:CGRectMake(255, 60, 80, 60)];
            [mailID setFrame:CGRectMake(355, 60, 400, 60)];
            [siteUrlLbl setFrame:CGRectMake(255, 117, 80, 60)];
            [siteUrTF setFrame:CGRectMake(355, 117, 400, 60)];
            [lblDefaultText setFrame:CGRectMake(230, 200, 600, 60)];
		}
        else
        {         
            [imgView setFrame:(CGRectMake(100, 60, 600, 120))];
            [lblforgotpass setFrame:CGRectMake(125, 60, 80, 60)];
            [mailID setFrame:CGRectMake(225, 60, 400, 60)];
            [siteUrlLbl setFrame:CGRectMake(125, 117, 80, 60)];
            [siteUrTF setFrame:CGRectMake(225, 117, 400, 60)];
            [lblDefaultText setFrame:CGRectMake(100, 200, 600, 60)];            
        }
        
    }
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
       
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        [self ios6ipad];
    }
    
}*/

#pragma mark Validation Methods

- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
    return [emailTest evaluateWithObject:email];
}

- (BOOL) validateUrl: (NSString *) testURL
{
    NSString *urlRegEx = @"(http|https)://+[A-Za-z0-9.-]+([\\.|/]+((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx]; 
    return [urlTest evaluateWithObject:testURL];
}

#pragma mark Text Field Delegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
   
    if (![self validateEmailWithString:mailID.text]) 
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Please enter a valid Email ID." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return YES;
    }
    
    if ( [self siteUrlEmbedded] )
    {
        strURL = [self getSiteUrl];
    }
    else
    {
        strURL = self.siteUrTF.text;
        if (![strURL hasPrefix:@"http://"])
        {
            strURL = [NSString stringWithFormat:@"http://%@", strURL];
        }
        
        if (![self validateUrl:strURL])
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Please enter a valid Website." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
            return YES;
        }
    }
    
    NSString *req = [NSString stringWithFormat:@"%@/mobile/Forgot/index.php?email=%@",strURL,mailID.text];    
    [JSWaiter ShowWaiter:self title:@"Sending..." type:0];
    [self performSelectorOnMainThread:@selector(WebRequest:) withObject:req waitUntilDone:NO];
   	return YES;
}

#pragma mark IBAction

- (IBAction)clickedCloseButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    [objSignInView release];
}

#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redVal/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenVal/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueVal/255.0 alpha:1.0]];
    [self.view setBackgroundColor:[UIColor colorWithRed:245/255.0 green:244/255.0 blue:243/255.0 alpha:1.0]];
    [navBar setTintColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavbar/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavbar/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavbar/255.0 alpha:1.0]];
    lblNavTitle.font= ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontNavTitle;
    [lblNavTitle setText:@"Forgot Password?"];
    lblforgotpass.font=[UIFont fontWithName:@"Ubuntu-Bold" size:13];
    navBar.layer.borderColor=[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavBorder/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavBorder/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavBorder/255.0 alpha:1.0].CGColor;
    navBar.layer.borderWidth=1.0f;

    if ( [self siteUrlEmbedded] )
    {
        [siteUrTF setHidden:YES];
        [siteUrlLbl setHidden:YES];
        [imgView setImage:[UIImage imageNamed:@"bg_1.png"]];
        [imgView setFrame:(CGRectMake(10, 69, 299, 55))];
    }
}

- (void)viewDidUnload
{
    [self setLblDefaultText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
    
    /*if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        if (interfaceOrientation==UIInterfaceOrientationPortrait || interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) 
        {
            indicatorView.frame =CGRectMake((284+NewXval), 471, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30), 40);
            [imgView setFrame:(CGRectMake(100, 60, 600, 120))];
            [lblforgotpass setFrame:CGRectMake(125, 60, 80, 60)];
            [mailID setFrame:CGRectMake(225, 60, 400, 60)];
            [siteUrlLbl setFrame:CGRectMake(125, 117, 80, 60)];
            [siteUrTF setFrame:CGRectMake(225, 117, 400, 60)];
            [lblDefaultText setFrame:CGRectMake(100, 200, 600, 60)];
        }
        else if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft || interfaceOrientation==UIInterfaceOrientationLandscapeRight)
        {
            indicatorView.frame =CGRectMake((412+NewXval), 344, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30), 40);
            [imgView setFrame:(CGRectMake(230, 60, 600, 120))];
            [lblforgotpass setFrame:CGRectMake(255, 60, 80, 60)];
            [mailID setFrame:CGRectMake(355, 60, 400, 60)];
            [siteUrlLbl setFrame:CGRectMake(255, 117, 80, 60)];
            [siteUrTF setFrame:CGRectMake(355, 117, 400, 60)];
            [lblDefaultText setFrame:CGRectMake(230, 200, 600, 60)];
        } 
        return YES;  
    }
    else 
    {
        return NO;  
    }*/
}

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

#pragma mark Managing API Calls
-(void)WebRequest:(NSString*)url
{
    JSWebManager* webMgr = [[[JSWebManager alloc] initWithAsyncOption:NO] autorelease];
    NSDictionary* ret = [webMgr GetDataFromUrl:url];
    NSError* error = [ret objectForKey:@"error"];
    if (error)
    {
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Connection failed...Please launch the application again." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
    else
    {
        NSDictionary *parsedData = (NSDictionary *)[ret objectForKey:@"data"];
        respForgotPw.frgtPwStatusMsg = (NSString*)[parsedData objectForKey:@"Message"];
        if(!parsedData)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to retrieve data from the site. Kindly re-enter the Email ID!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
        }
        else  if([respForgotPw.frgtPwStatusMsg isEqualToString:@"Site suspended"])
        {
            ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Site suspended";
            UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Site suspended. Please try after sometime." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            sessionAlertView.tag=1;
            [sessionAlertView show];
            [sessionAlertView release];
        }
        else if ([respForgotPw.frgtPwStatusMsg isEqualToString:@"Email sent to given email address"])
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Password has been sent to the given Email address! Kindly re-enter the login credentials." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
            SkadateViewController *objSkadateViewController=[[SkadateViewController alloc]initWithNibName:@"SkadateViewController" bundle:nil];
            [self.navigationController pushViewController:objSkadateViewController animated:YES];
            [objSkadateViewController release];
        }
        else if([respForgotPw.frgtPwStatusMsg isEqualToString:@"Error: Requires Valid Email"])
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"The e-mail address you entered is not valid." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
            mailID.text = nil;
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Email ID provided does not match any ID in records! Kindly re-enter the Email ID." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
            mailID.text = nil;
        }
    }
    [JSWaiter HideWaiter];
}

#pragma mark-AlertViewDelegate

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==1&&buttonIndex==0)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
