//
//  TermsOfUse.m
//  Chk
//
//  Created by kavitha on 01/09/11.
//  Copyright 2011 Solutions On Demand Australasia Pty Ltd. All rights reserved.
//

#import "TermsOfUse.h"
#import "SkadateViewController.h"
#import "SkadateAppDelegate.h"
#import "JSON.h"

@implementation TermsOfUse

@synthesize objSignUPSecondView,objSignInView;
@synthesize navBar,NewXval;
@synthesize lblNavTitle,textView,urlReq,textViewDetails, domain;

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

#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redVal/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenVal/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueVal/255.0 alpha:1.0]];
    
    [navBar setTintColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavbar/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavbar/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavbar/255.0 alpha:1.0]];
    navBar.layer.borderColor=[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavBorder/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavBorder/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavBorder/255.0 alpha:1.0].CGColor;
    navBar.layer.borderWidth=1.0f;
    lblNavTitle.font= ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontNavTitle;
    [lblNavTitle setText:@"Terms Of Use"];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    domain = [prefs stringForKey:@"URL"];
    
    urlReq=[NSString stringWithFormat:@"%@/mobile/Terms/",domain];
    [self performSelectorOnMainThread:@selector(WebRequest:) withObject:urlReq waitUntilDone:NO];
    [JSWaiter ShowWaiter:self title:@"Loading.." type:0];
    
    self.view.userInteractionEnabled=NO;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
    
    /*if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if (interfaceOrientation==UIDeviceOrientationLandscapeRight || interfaceOrientation==UIDeviceOrientationLandscapeLeft) 
        {
            indicatorView.frame =CGRectMake((412+NewXval), 344, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30), 40);
            [lblNavTitle setFrame:(CGRectMake(350, 10, 300, 30))];
        }
        else 
        {
            indicatorView.frame =CGRectMake((284+NewXval), 471, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30), 40);
            [lblNavTitle setFrame:(CGRectMake(237, 10, 300, 30))];
        }
        
        return YES;
    }
    else
    {        
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    }*/
}

#pragma mark Custom Methods


#pragma mark Managing API Calls
-(void)WebRequest:(NSString*)url
{
    JSWebManager* webMgr = [[[JSWebManager alloc] initWithAsyncOption:NO] autorelease];
    NSDictionary* ret = [webMgr GetDataFromUrl:url];
    NSError* error = [ret objectForKey:@"error"];
    if (error)
    {
        self.view.userInteractionEnabled=YES;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Connection failed...Please launch the application again." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
    else
    {
        self.view.userInteractionEnabled=YES;
        NSDictionary *parsedData = (NSDictionary *)[ret objectForKey:@"data"];
        if(!parsedData)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to retrieve data from the site. Kindly re-enter login credentials." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
            return;
        }
        else
        {
            if([(NSString*)[parsedData objectForKey:@"Message"] isEqualToString:@"Site suspended"])
            {
                ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Site suspended";
                
                UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Site suspended. Please try after sometime." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
                sessionAlertView.tag=3;
                [sessionAlertView show];
                [sessionAlertView release];
                return;
            }
            
            textViewDetails=(NSString*)[parsedData objectForKey:@"Terms"];
            
            if (textViewDetails==NULL||textViewDetails== (id)[NSNull null])
            {
                textView.text=@"Please read these Terms Of Use carefully before using this site. By using this site,you signify your agreement with these Terms Of Use. If you do not agree with the Terms Of Use, do not use this site. This company reserves the right, at its sole discretion, to modify, alter or otherwise update these Terms Of Use at any time.";
            }
            else
            {
                if ([textViewDetails isEqualToString:@""]||[textViewDetails isEqualToString:@"Your Terms of Use here."])
                {
                    textView.text=@"Please read these Terms Of Use carefully before using this site. By using this site,you signify your agreement with these Terms Of Use. If you do not agree with the Terms Of Use, do not use this site. This company reserves the right, at its sole discretion, to modify, alter or otherwise update these Terms Of Use at any time.";
                }
                else
                {
                    textView.text=textViewDetails;
                }
            }
        }
    }
    [JSWaiter HideWaiter];
}

#pragma mark IBAction

- (IBAction)clickedAccept:(UIButton *)button
{    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"INFO" message:@"By accepting the Terms of Use, you agree to abide by all rules specified here." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    alertView.tag = 1;
    [alertView release];
      
}

- (IBAction)clickedDecline:(UIButton *)button
{
    UIAlertView *alertView1 = [[UIAlertView alloc] initWithTitle:@"INFO" message:@"By declining the Terms of Use, you will not be allowed to sign up to this online dating network!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
    [alertView1 show];
    alertView1.tag = 2;
    [alertView1 release];
}

- (IBAction)clickedClose:(UIButton *)button
{    
     [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark AlertView Delegate

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex 
{    
    if (actionSheet.tag==1)
    {
        if (buttonIndex == 0)
        {
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
			[prefs setBool:YES forKey:@"touAgreed"];
            [self.navigationController popViewControllerAnimated:YES];
        }        
    }
    else if (actionSheet.tag==2) 
    {
        // the user clicked one of the OK/Cancel buttons
        if (buttonIndex == 0)
        {
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            [prefs setBool:NO forKey:@"touAgreed"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
    else if (actionSheet.tag==3) 
    {
         // the user clicked one of the OK/Cancel buttons
        if (buttonIndex == 0)
        {         
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}


@end
