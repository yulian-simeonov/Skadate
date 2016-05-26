//
//  AboutUsView.m
//  Chk
//
//  Created by SODTechnologies on 25/08/11.
//  Copyright 2011 Solutions On Demand Australasia Pty Ltd. All rights reserved.
//

#import "AboutUsView.h"
#import "SkadateAppDelegate.h"
#import "JSON.h"

@implementation AboutUsView

@synthesize closeButton,domain;
@synthesize segControl,indicatorView,indicatorLabel,objIndicatorView,textViewInfo;

#pragma mark Memory Management

- (void)dealloc
{
    [webView release];
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

- (void)ShowIndicatorView : (NSString *)DiaplayText
{
    // fixing the activity indicator
    DiaplayText=@"";
    objIndicatorView =[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    objIndicatorView.frame = CGRectMake(10, 10, objIndicatorView.bounds.size.width, objIndicatorView.bounds.size.height);
    CGSize maximumLabelSize ;
    CGSize expectedLabelSize;
    UIFont *DisplayTextFont;
   
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) 
    {
        maximumLabelSize=CGSizeMake(100,objIndicatorView.bounds.size.height);
        DisplayTextFont = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    }
    else
    {
        maximumLabelSize=CGSizeMake(150.0,objIndicatorView.bounds.size.height);
        DisplayTextFont = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    }
    
    expectedLabelSize = [DiaplayText sizeWithFont:DisplayTextFont
                                constrainedToSize:maximumLabelSize
                                    lineBreakMode:UILineBreakModeCharacterWrap];
    indicatorLabel = [[UILabel alloc] initWithFrame:CGRectMake((objIndicatorView.bounds.size.width +15), 10, expectedLabelSize.width, objIndicatorView.bounds.size.height)];
  
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        [indicatorLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
    }
    else
    {
        [indicatorLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    }
    
    indicatorLabel.backgroundColor = [UIColor clearColor];
    indicatorLabel.textColor = [UIColor whiteColor];
    indicatorLabel.adjustsFontSizeToFitWidth = YES;
    indicatorLabel.textAlignment = UITextAlignmentCenter;
    indicatorLabel.text =DiaplayText;
    NewXval=0;
   
    if (expectedLabelSize.width<maximumLabelSize.width)
    {
        NewXval=NewXval=(maximumLabelSize.width-expectedLabelSize.width)/2;
    }
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            // iPhone Classic
            indicatorView = [[UIView alloc] initWithFrame:CGRectMake((85 + NewXval), 200,  (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30),(objIndicatorView.frame.size.height+20))];
        }
        if(result.height == 568)
        {
            // iPhone 5
            indicatorView = [[UIView alloc] initWithFrame:CGRectMake((85 + NewXval), 200+40,  (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30),(objIndicatorView.frame.size.height+20))];
        }
    }
    else
    {
        if (self.interfaceOrientation==UIDeviceOrientationLandscapeRight || self.interfaceOrientation==UIDeviceOrientationLandscapeLeft)
        {
            indicatorView = [[UIView alloc] initWithFrame:CGRectMake((412+NewXval), 344, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30),(objIndicatorView.frame.size.height+20))];
        }
        else
        {
            indicatorView = [[UIView alloc] initWithFrame:CGRectMake((284+NewXval), 471, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30),(objIndicatorView.frame.size.height+20))];
        }
    }
    
    indicatorView.backgroundColor = [UIColor clearColor];
    indicatorView.clipsToBounds = YES;
    indicatorView.layer.cornerRadius = 5.0;
    [indicatorView addSubview:objIndicatorView];
    [indicatorView addSubview:indicatorLabel];
    [self.view addSubview:indicatorView];
    [self.view bringSubviewToFront:indicatorView];
    [objIndicatorView startAnimating];
    
}

#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    aboutUsFlag=YES;
    termsofuseFlag=NO;
    privacyFlag=NO;
    fullversionFlag=NO;
    segControl.segmentedControlStyle = UISegmentedControlStyleBar;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    domain = [prefs stringForKey:@"URL"];
    UIColor *newTintColor = [UIColor colorWithRed: 245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    segControl.tintColor = newTintColor;
    CGRect frame = CGRectMake (7, 12, 306, 40);
    segControl.frame = frame;
    segControl.clipsToBounds = YES;
    segControl.layer.cornerRadius = 5.0;
    [self.view setBackgroundColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redVal/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenVal/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueVal/255.0 alpha:1.0]];
    UIColor *newSelectedTintColor = [UIColor colorWithRed: 245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    [[[segControl subviews] objectAtIndex:0] setTintColor:newSelectedTintColor];
    urlReq=[NSString stringWithFormat:@"%@/mobile/About_US",domain];   
    NSURL *termsUrl = [NSURL URLWithString:[urlReq stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];

    // parse json
    NSData *jsonData=[NSData dataWithContentsOfURL:termsUrl];
    NSDictionary *items=[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    
    NSString *messegeStr=(NSString*)[items objectForKey:@"About_us"];
    
    [webView loadHTMLString:messegeStr baseURL:nil];
    
    [navBar setTintColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavbar/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavbar/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavbar/255.0 alpha:1.0]];
    navBar.layer.borderColor=[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavBorder/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavBorder/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavBorder/255.0 alpha:1.0].CGColor;
    aboutuslab.font= ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontNavTitle;
    [aboutuslab setText:@"Info"];
   
    // starting indicator view
     [self ShowIndicatorView:@"Loading..."];
}

- (void)viewDidUnload
{
    [webView release];
    webView = nil;
    [super viewDidUnload];
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
        return YES;
    }
    else
    {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    }*/
}

#pragma mark IBActions

-(IBAction)clikedClosedButton:(id) sender
{
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction) clickedSegmentContol 
{
    int selectedsegment=segControl.selectedSegmentIndex;
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    domain = [preferences stringForKey:@"URL"];
    if (selectedsegment==0) 
    {   
        indicatorView.hidden=YES;
        self.view.userInteractionEnabled=YES;
        aboutUsFlag=YES;
        termsofuseFlag=NO;
        privacyFlag=NO;
        fullversionFlag=NO;
        [segControl setImage:[UIImage imageNamed:@"about_us_over.png"] forSegmentAtIndex:0];
        [segControl setImage:[UIImage imageNamed:@"terms_of_use.png"] forSegmentAtIndex:1];
        [segControl setImage:[UIImage imageNamed:@"privacy_policy.png"] forSegmentAtIndex:2];
        [segControl setImage:[UIImage imageNamed:@"full_version.png"] forSegmentAtIndex:3];
        urlReq=[NSString stringWithFormat:@"%@/mobile/About_US",domain];   
        NSURL *termsUrl = [NSURL URLWithString:[urlReq stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        // parse json
        NSData *jsonData=[NSData dataWithContentsOfURL:termsUrl];
        NSDictionary *items=[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
        
        NSString *messegeStr=(NSString*)[items objectForKey:@"About_us"];
        [webView loadHTMLString:messegeStr baseURL:nil];
             
        // starting indicator view
        indicatorView.hidden=NO; 
        self.view.userInteractionEnabled=NO;
    }
    
    if (selectedsegment==1) 
    {
        indicatorView.hidden=YES;
        self.view.userInteractionEnabled=YES;
        aboutUsFlag=NO;
        termsofuseFlag=YES;
        privacyFlag=NO;
        fullversionFlag=NO;
        [segControl setImage:[UIImage imageNamed:@"about_us.png"] forSegmentAtIndex:0];
        [segControl setImage:[UIImage imageNamed:@"terms_of_use_hover.png"] forSegmentAtIndex:1];
        [segControl setImage:[UIImage imageNamed:@"privacy_policy.png"] forSegmentAtIndex:2];
        [segControl setImage:[UIImage imageNamed:@"full_version.png"] forSegmentAtIndex:3];
        urlReq=[NSString stringWithFormat:@"%@/mobile/Terms",domain];   
        NSURL *termsUrl = [NSURL URLWithString:[urlReq stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        // parse json
        NSData *jsonData=[NSData dataWithContentsOfURL:termsUrl];
        NSDictionary *items=[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
        
        NSString *messegeStr=(NSString*)[items objectForKey:@"Terms"];
        [webView loadHTMLString:messegeStr baseURL:nil];
                       
        // starting indicator view
        indicatorView.hidden=NO; 
        self.view.userInteractionEnabled=NO;
    }
    
    if (selectedsegment ==2)
    {
        indicatorView.hidden=YES;
        self.view.userInteractionEnabled=YES;
        aboutUsFlag=NO;
        termsofuseFlag=NO;
        privacyFlag=YES;
        fullversionFlag=NO;
        [segControl setImage:[UIImage imageNamed:@"about_us.png"] forSegmentAtIndex:0];
        [segControl setImage:[UIImage imageNamed:@"terms_of_use.png"] forSegmentAtIndex:1];
        [segControl setImage:[UIImage imageNamed:@"privacy_policy_hover.png"] forSegmentAtIndex:2];
        [segControl setImage:[UIImage imageNamed:@"full_version.png"] forSegmentAtIndex:3];
        urlReq=[NSString stringWithFormat:@"%@/mobile/Privacy_Policy",domain];   
        NSURL *termsUrl = [NSURL URLWithString:[urlReq stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        // parse json
        NSData *jsonData=[NSData dataWithContentsOfURL:termsUrl];
        NSDictionary *items=[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
        
        NSString *messegeStr=(NSString*)[items objectForKey:@"Privacy"];
        [webView loadHTMLString:messegeStr baseURL:nil];
                      
       // starting indicator view
        indicatorView.hidden=NO; 
        self.view.userInteractionEnabled=NO;
    }
    
    if (selectedsegment ==3)
    {
        indicatorView.hidden=YES;
        self.view.userInteractionEnabled=YES;
        aboutUsFlag=NO;
        termsofuseFlag=NO;
        privacyFlag=NO;
        fullversionFlag=YES;
        [segControl setImage:[UIImage imageNamed:@"about_us.png"] forSegmentAtIndex:0];
        [segControl setImage:[UIImage imageNamed:@"terms_of_use.png"] forSegmentAtIndex:1];
        [segControl setImage:[UIImage imageNamed:@"privacy_policy.png"] forSegmentAtIndex:2];
        [segControl setImage:[UIImage imageNamed:@"full_version_over.png"] forSegmentAtIndex:3];
        
        urlReq=[NSString stringWithFormat:@"%@/?from=mobile",domain];
        NSURL *url = [NSURL URLWithString:urlReq];
        
        if ( ![[UIApplication sharedApplication] openURL:url] )
        {
            NSLog(@"%@%@", @"Failed to open url:", [url description]);
        }
        
        //NSURL *termsUrl = [NSURL URLWithString:[urlReq stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        // parse json
        //NSData *jsonData=[NSData dataWithContentsOfURL:termsUrl];
        //NSDictionary *items=[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
        
        //NSString *messegeStr=(NSString*)[items objectForKey:@"FullVersion"];
        //[webView loadHTMLString:messegeStr baseURL:nil];
                     
        // starting indicator view
        //indicatorView.hidden=NO;
        //self.view.userInteractionEnabled=NO;
    }
}

#pragma mark WebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    indicatorView.hidden=YES;
    self.view.userInteractionEnabled=YES;  
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    indicatorView.hidden=YES;
    self.view.userInteractionEnabled=YES;
   	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Connection failed...Please launch the application again." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];
	[alertView release];
	return;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{

}

#pragma mark Managing API Calls

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
  	[respData setLength:0 ];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [respData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    indicatorView.hidden=YES;
    self.view.userInteractionEnabled=YES;
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Connection failed...Please launch the application again." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];
	[alertView release];
	return;
}


@end
