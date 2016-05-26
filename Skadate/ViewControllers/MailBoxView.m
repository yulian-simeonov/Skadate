//
//  MailBoxView.m
//  Skadate
//
//  Created by SODTechnologies on 29/09/11.
//  Copyright 2011 Solutions On Demand Australasia Pty Ltd. All rights reserved.
//

#import "MailBoxView.h"
#import "HomeView.h"
#import "ComposeMessageView.h"
#import "JSON.h"
#import "SkadateAppDelegate.h"
#import "MessageView.h"
#import "MailConversationView.h"
#import "NotificationsView.h"
#import "CommonStaticMethods.h"

#define REFRESH_HEADER_HEIGHT 52.0f

@implementation MailBoxView

@synthesize  btnMailBox;
@synthesize  btnComposeMessage,conversationNumber;
@synthesize imageArray,nameArray,table,segmentControl,messageSubjectArray,messageContentArray,messageId,conversationId,senderId,timeArray,urlReq,genders,domain;
@synthesize lblOfTxt,lblOfSubject,lblOfName;
@synthesize kissesImagesArray;
@synthesize winkImagesArray,resultCount;
@synthesize readMsgs,fromView;
@synthesize NewXval;
@synthesize lastRead;

// pull down refresh.........//
@synthesize textPull, textRelease, textLoading, refreshHeaderView, refreshLabel, refreshArrow, refreshSpinner;

#pragma mark Memory Management

- (void)dealloc
{
    [kissesImagesArray release];
    [winkImagesArray release];
    [thumbPicURLs release];
    [imagearray release];
    [nameArray release];
    [messageSubjectArray release];
    [messageContentArray release];
    [messageId release];
    [conversationId release];
    [senderId release];
    [timeArray release];
    [conversationNumber release];
    [genders release];
    [readMsgs release];
    [lastRead release];
    [lblOfTxt release];
    [lblOfSubject release];
    [lblOfName release];
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
            [lblOfName setFrame:CGRectMake(103,15, 450,22 )];
            [lblOfSubject setFrame:CGRectMake(103,37, 450,18 )];
            [lblOfTxt setFrame:CGRectMake(95,50, 500,30 )];
            [messageLabel setFrame:CGRectMake(950,55,20,20)];
            
		}
        else
        {
            [lblOfName setFrame:CGRectMake(103,15, 450,22 )];
            [lblOfSubject setFrame:CGRectMake(103,37, 450,18 )];
            [lblOfTxt setFrame:CGRectMake(95,50, 500,30 )];
            [messageLabel setFrame:CGRectMake(690,55,20,20)];
            
        }
        if ([nameArray count]>0)
        {
            [table reloadData];
            loadFlag=YES;
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

// pull down refresh.........//
- (void)setupStrings
{
    textPull = [[NSString alloc] initWithString:@"Pull down to refresh..."];
    textRelease = [[NSString alloc] initWithString:@"Release to refresh..."];
    textLoading = [[NSString alloc] initWithString:@"Loading..."];
}

- (void)addPullToRefreshHeader
{
    refreshHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 - REFRESH_HEADER_HEIGHT, 320, REFRESH_HEADER_HEIGHT)];
    refreshHeaderView.backgroundColor = [UIColor clearColor];
    refreshLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, REFRESH_HEADER_HEIGHT)];
    refreshLabel.backgroundColor = [UIColor clearColor];
    refreshLabel.font = [UIFont boldSystemFontOfSize:12.0];
    refreshLabel.textAlignment = UITextAlignmentCenter;
    refreshArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.png"]];
    refreshArrow.frame = CGRectMake(floorf((REFRESH_HEADER_HEIGHT - 27) / 2),
                                    (floorf(REFRESH_HEADER_HEIGHT - 44) / 2),
                                    27, 44);
    refreshSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    int xvalue=floorf(floorf(REFRESH_HEADER_HEIGHT - 20) / 2) +85;
    refreshSpinner.frame = CGRectMake(xvalue, floorf((REFRESH_HEADER_HEIGHT - 20) / 2), 20, 20);
    refreshSpinner.hidesWhenStopped = YES;
    [refreshHeaderView addSubview:refreshLabel];
    [refreshHeaderView addSubview:refreshArrow];
    [refreshHeaderView addSubview:refreshSpinner];
    [table addSubview:refreshHeaderView];
}

- (void)startLoading
{
    isLoading = YES;
    // Show the header
    [UIView animateWithDuration:0.3 animations:^{
        table.contentInset = UIEdgeInsetsMake(REFRESH_HEADER_HEIGHT, 0, 0, 0);
        refreshLabel.text = self.textLoading;
        refreshArrow.hidden = YES;
        [refreshSpinner startAnimating];
    }];
    [self refresh];
}

- (void)stopLoading
{
    isLoading = NO;
    self.view.userInteractionEnabled=YES;
    // Hide the header
    [UIView animateWithDuration:0.3 animations:^{
        table.contentInset = UIEdgeInsetsZero;
        [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
    } 
                     completion:^(BOOL finished) {
                         [self performSelector:@selector(stopLoadingComplete)];
                     }];
}

- (void)stopLoadingComplete
{
    // Reset the header
    refreshLabel.text = self.textPull;
    refreshArrow.hidden = NO;
    [refreshSpinner stopAnimating];
}

- (void)refresh
{
    self.view.userInteractionEnabled=NO;
    [self performSelector:@selector(addItem) withObject:nil afterDelay:2.0];
}

- (void)addItem
{
    if (inboxFlag) 
    {
        imageArray=[[NSMutableArray alloc]init];
        thumbPicURLs=[[NSMutableArray alloc]init];
        nameArray=[[NSMutableArray alloc]init];    
        messageSubjectArray=[[NSMutableArray alloc]init];
        messageContentArray=[[NSMutableArray alloc]init];    
        timeArray=[[NSMutableArray alloc]init];
        senderId=[[NSMutableArray alloc]init];
        messageId=[[NSMutableArray alloc]init];
        conversationId=[[NSMutableArray alloc]init];
        conversationNumber=[[NSMutableArray alloc]init];
        readMsgs=[[NSMutableArray alloc]init];
        lastRead=[[NSMutableArray alloc]init];
        genders=[[NSMutableArray alloc]init];
        self.view.userInteractionEnabled=NO;
        urlReq =[NSString stringWithFormat:@"%@/mobile/ViewInboxByLimit/?id=%@&skey=%@&start=0&limit=10",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID];
        [self performSelectorOnMainThread:@selector(WebRequest:) withObject:urlReq waitUntilDone:NO];
    }
    else 
    {
        imageArray=[[NSMutableArray alloc]init];
        thumbPicURLs=[[NSMutableArray alloc]init];
        nameArray=[[NSMutableArray alloc]init];    
        messageSubjectArray=[[NSMutableArray alloc]init];
        messageContentArray=[[NSMutableArray alloc]init];    
        timeArray=[[NSMutableArray alloc]init];
        senderId=[[NSMutableArray alloc]init];
        messageId=[[NSMutableArray alloc]init];
        conversationId=[[NSMutableArray alloc]init];
        conversationNumber=[[NSMutableArray alloc]init];
        readMsgs=[[NSMutableArray alloc]init];
        lastRead=[[NSMutableArray alloc]init];
        genders=[[NSMutableArray alloc]init];
        self.view.userInteractionEnabled=NO;
        urlReq =[NSString stringWithFormat:@"%@/mobile/SendMailByLimit/?id=%@&skey=%@&start=0&limit=10",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID];
        [JSWaiter ShowWaiter:self title:@"Loading..." type:0];
        [self performSelectorOnMainThread:@selector(WebRequest:) withObject:urlReq waitUntilDone:NO];
    }
}

-(NSString *)FormatTime:(NSString *)ServerTimeStr
{
    NSString *serverTime =ServerTimeStr;
    NSString * serverTimeZone=((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedTimeZone;
    NSString *TimeZoneName=[[NSTimeZone systemTimeZone] name];
    DisplayDateTime *objDisplayDateTime =[[DisplayDateTime alloc]init];
    NSString *result= [objDisplayDateTime ConvertMailBoxDateTime:serverTime andServerTimeZone:serverTimeZone andDeviceTimeZone:TimeZoneName];
    [objDisplayDateTime release];
    return result;
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (isLoading) return;
    isDragging = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat sectionHeaderHeight = 50;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) 
    {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } 
    else if (scrollView.contentOffset.y>=sectionHeaderHeight) 
    {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
    if (isLoading) 
    {
        // Update the content inset, good for section headers
        if (scrollView.contentOffset.y > 0)
            table.contentInset = UIEdgeInsetsZero;
        else if (scrollView.contentOffset.y >= -REFRESH_HEADER_HEIGHT)
            table.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }
    else if (isDragging && scrollView.contentOffset.y < 0) 
    {
        // Update the arrow direction and label
        [UIView animateWithDuration:0.25 animations:^{
            if (scrollView.contentOffset.y < -REFRESH_HEADER_HEIGHT)
            {
                // User is scrolling above the header
                refreshLabel.text = self.textRelease;
                [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
            } 
            else 
            { 
                // User is scrolling somewhere within the header
                refreshLabel.text = self.textPull;
                [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
            }
        }];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (isLoading) return;
    isDragging = NO;
    if (scrollView.contentOffset.y <= -REFRESH_HEADER_HEIGHT) 
    {
        // Released above the header
        [self startLoading];
    }
}

#pragma mark View lifecycle

- (void)viewDidLoad
{
    // pull to refresh
    [self setupStrings];
    [super viewDidLoad];
    [self addPullToRefreshHeader];
    self.navigationController.navigationBarHidden=YES;
    
    // for hiding the navigation bar
    segmentControl.segmentedControlStyle = UISegmentedControlStyleBar;
    segmentControl.frame = CGRectMake (10, 53, 298,34);
    UIColor *newTintColor = [UIColor colorWithRed: 245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    segmentControl.tintColor = newTintColor;
    UIColor *newSelectedTintColor = [UIColor colorWithRed: 245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    [[[segmentControl subviews] objectAtIndex:0] setTintColor:newSelectedTintColor];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    domain = [prefs stringForKey:@"URL"];
    [self.view setBackgroundColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redVal/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenVal/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueVal/255.0 alpha:1.0]];
    [navBar setTintColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavbar/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavbar/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavbar/255.0 alpha:1.0]];
    navBar.layer.borderColor=[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavBorder/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavBorder/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavBorder/255.0 alpha:1.0].CGColor;
    navBar.layer.borderWidth=1.0f;
    mailboxlable.font= ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontNavTitle;
    [mailboxlable setTextAlignment:UITextAlignmentCenter];
    mailboxlable.text=@"Mailbox";
    inboxFlag=YES;
    kissesImagesArray=[[NSMutableArray alloc]init ];
   
    for (int j=1; j<=24; j++) 
    {
        UIImage *kiss=[UIImage imageNamed:[NSString stringWithFormat:@"kiss%d.png",j]];
        [kissesImagesArray addObject:kiss];
    }
    
    winkImagesArray=[[NSMutableArray alloc]init ];
    for (int l=1; l<=6; l++) 
    {
        UIImage *wink=[UIImage imageNamed:[NSString stringWithFormat:@"wink%d.png",l]];
        [winkImagesArray addObject:wink];
    }
    
    thumbPicURLs=[[NSMutableArray alloc]init];
    imageArray=[[NSMutableArray alloc]init];
    nameArray=[[NSMutableArray alloc]init];    
    messageSubjectArray=[[NSMutableArray alloc]init];
    messageContentArray=[[NSMutableArray alloc]init];    
    timeArray=[[NSMutableArray alloc]init];
    senderId=[[NSMutableArray alloc]init];
    messageId=[[NSMutableArray alloc]init];
    conversationId=[[NSMutableArray alloc]init];
    conversationNumber=[[NSMutableArray alloc]init];
    readMsgs=[[NSMutableArray alloc]init];
    lastRead=[[NSMutableArray alloc]init];
    urlReq =[NSString stringWithFormat:@"%@/mobile/ViewInboxByLimit/?id=%@&skey=%@&start=0&limit=10",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID];
            
    [JSWaiter ShowWaiter:self title:@"Loading..." type:0];
    [self performSelectorOnMainThread:@selector(WebRequest:) withObject:urlReq waitUntilDone:NO];
    self.view.userInteractionEnabled=NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    if (!loadFlag)
    {
        return;
    }
    if (inboxFlag) 
    {
        imageArray=[[NSMutableArray alloc]init];
        thumbPicURLs=[[NSMutableArray alloc]init];
        nameArray=[[NSMutableArray alloc]init];    
        messageSubjectArray=[[NSMutableArray alloc]init];
        messageContentArray=[[NSMutableArray alloc]init];    
        timeArray=[[NSMutableArray alloc]init];
        senderId=[[NSMutableArray alloc]init];
        messageId=[[NSMutableArray alloc]init];
        conversationId=[[NSMutableArray alloc]init];
        conversationNumber=[[NSMutableArray alloc]init];
        readMsgs=[[NSMutableArray alloc]init];
        lastRead=[[NSMutableArray alloc]init];
        genders=[[NSMutableArray alloc]init];
        self.view.userInteractionEnabled=NO;
        urlReq =[NSString stringWithFormat:@"%@/mobile/ViewInboxByLimit/?id=%@&skey=%@&start=0&limit=10",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID];
        [JSWaiter ShowWaiter:self title:@"Loading..." type:0];
        [self performSelectorOnMainThread:@selector(WebRequest:) withObject:urlReq waitUntilDone:NO];
       
    }
    else 
    {
        imageArray=[[NSMutableArray alloc]init];
        thumbPicURLs=[[NSMutableArray alloc]init];
        nameArray=[[NSMutableArray alloc]init];    
        messageSubjectArray=[[NSMutableArray alloc]init];
        messageContentArray=[[NSMutableArray alloc]init];    
        timeArray=[[NSMutableArray alloc]init];
        senderId=[[NSMutableArray alloc]init];
        messageId=[[NSMutableArray alloc]init];
        conversationId=[[NSMutableArray alloc]init];
        conversationNumber=[[NSMutableArray alloc]init];
        readMsgs=[[NSMutableArray alloc]init];
        lastRead=[[NSMutableArray alloc]init];
        genders=[[NSMutableArray alloc]init];
        self.view.userInteractionEnabled=NO;
        urlReq =[NSString stringWithFormat:@"%@/mobile/SendMailByLimit/?id=%@&skey=%@&start=0&limit=10",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID];
       
        [JSWaiter ShowWaiter:self title:@"Loading..." type:0];
        [self performSelectorOnMainThread:@selector(WebRequest:) withObject:urlReq waitUntilDone:NO];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
    
    // Return YES for supported orientations
    /*if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if (interfaceOrientation==UIInterfaceOrientationLandscapeRight||interfaceOrientation==UIInterfaceOrientationLandscapeLeft)
        {
            indicatorView.frame =CGRectMake((412+NewXval), 344, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30), 40);
            [lblOfName setFrame:CGRectMake(103,15, 450,22 )];
            [lblOfSubject setFrame:CGRectMake(103,37, 450,18 )];
            [lblOfTxt setFrame:CGRectMake(95,50, 500,30 )];
            [messageLabel setFrame:CGRectMake(950,55,20,20)];
        }
        else
        {
            indicatorView.frame =CGRectMake((284+NewXval), 471, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30), 40);
            [lblOfName setFrame:CGRectMake(103,15, 450,22 )];
            [lblOfSubject setFrame:CGRectMake(103,37, 450,18 )];
            [lblOfTxt setFrame:CGRectMake(95,50, 500,30 )];
            [messageLabel setFrame:CGRectMake(690,55,20,20)];
        }
        if ([nameArray count]>0)
        {
            [table reloadData];
            loadFlag=YES;
        }
        return YES;
    }
    else
    {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    }*/
}

#pragma mark IBAction

-(IBAction) clickedSegmentContol
{
    int selectedsegment=segmentControl.selectedSegmentIndex;
    countTotal=0;
   
    if (selectedsegment==0) 
	{
        [JSWaiter HideWaiter];
        self.view.userInteractionEnabled=YES;
        
        if(queue)
        {
            dispatch_suspend(queue);
        }
        
        inboxFlag=YES;
        sentFlag=NO;
        [segmentControl setImage:[UIImage imageNamed:@"Inbox small.png"] forSegmentAtIndex:0];
        [segmentControl setImage:[UIImage imageNamed:@"Send_tab_over.png"] forSegmentAtIndex:1];
        imageArray=[[NSMutableArray alloc]init];
        thumbPicURLs=[[NSMutableArray alloc]init];
        nameArray=[[NSMutableArray alloc]init];    
        messageSubjectArray=[[NSMutableArray alloc]init];
        messageContentArray=[[NSMutableArray alloc]init];    
        timeArray=[[NSMutableArray alloc]init];
        senderId=[[NSMutableArray alloc]init];
        messageId=[[NSMutableArray alloc]init];
        conversationId=[[NSMutableArray alloc]init];
        conversationNumber=[[NSMutableArray alloc]init];
        readMsgs=[[NSMutableArray alloc]init];
        lastRead=[[NSMutableArray alloc]init];
        genders=[[NSMutableArray alloc]init];
        urlReq =[NSString stringWithFormat:@"%@/mobile/ViewInboxByLimit/?id=%@&skey=%@&start=0&limit=10",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID];
        [JSWaiter ShowWaiter:self title:@"Loading..." type:0];
        [self performSelectorOnMainThread:@selector(WebRequest:) withObject:urlReq waitUntilDone:NO];
        self.view.userInteractionEnabled=NO;
        [table reloadData];
    }
    
	if (selectedsegment==1)
	{
        [JSWaiter HideWaiter];
        self.view.userInteractionEnabled=YES;
        
        if(queue)
        {
            dispatch_suspend(queue);
        }
        
		sentFlag=YES;
        inboxFlag=NO;
        [segmentControl setImage:[UIImage imageNamed:@"Inbox_tab.png"] forSegmentAtIndex:0];
        [segmentControl setImage:[UIImage imageNamed:@"Sent_tab.png"] forSegmentAtIndex:1];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setBool:NO forKey:@"inbox"];
        inboxFlag=NO;
        imageArray=[[NSMutableArray alloc]init];
        thumbPicURLs=[[NSMutableArray alloc]init];
        nameArray=[[NSMutableArray alloc]init];    
        messageSubjectArray=[[NSMutableArray alloc]init];
        messageContentArray=[[NSMutableArray alloc]init];    
        timeArray=[[NSMutableArray alloc]init];
        senderId=[[NSMutableArray alloc]init];
        messageId=[[NSMutableArray alloc]init];
        conversationId=[[NSMutableArray alloc]init];
        conversationNumber=[[NSMutableArray alloc]init];
        readMsgs=[[NSMutableArray alloc]init];
        lastRead=[[NSMutableArray alloc]init];
        genders=[[NSMutableArray alloc]init];
        urlReq =[NSString stringWithFormat:@"%@/mobile/SendMailByLimit/?id=%@&skey=%@&start=0&limit=10",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID];
        [JSWaiter ShowWaiter:self title:@"Loading..." type:0];
        [self performSelectorOnMainThread:@selector(WebRequest:) withObject:urlReq waitUntilDone:NO];
         self.view.userInteractionEnabled=NO;
        [table reloadData];
  	}
}


-(IBAction)clickedMailBoxButton:(id) sender
{
    if(queue)
    {
        dispatch_suspend(queue);
    }
    
    NSArray *viewControllers=[[self navigationController] viewControllers];
    if (fromView==1)
    {
        for( int i=0;i<[ viewControllers count];i++)
        {
            id obj=[viewControllers objectAtIndex:i];
            if([obj isKindOfClass:[HomeView class]] )
            {
                [[self navigationController] popToViewController:obj animated:YES];
                return;
            }
        }
    }
    else if (fromView==2)
    {
        for( int i=0;i<[ viewControllers count];i++)
        {
            id obj=[viewControllers objectAtIndex:i];
            if([obj isKindOfClass:[NotificationsView class]] )
            {
                [[self navigationController] popToViewController:obj animated:YES];
                return;
            }
        }
    }
}


-(IBAction)clickedComposeMessageBtn:(id) sender
{
    if(queue)
    {
        dispatch_suspend(queue);
    }
    
    ComposeMessageView *objComposeMessageViewForMailBox=[[ComposeMessageView alloc]initWithNibName:@"ComposeMessageView" bundle:nil];
    [self.navigationController pushViewController:objComposeMessageViewForMailBox animated:NO];
    [objComposeMessageViewForMailBox release];
}


#pragma mark AlertViewDelegate

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==1&&buttonIndex==0) 
    {   
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark Managing API Calls
-(void)WebRequest:(NSString*)url
{
    JSWebManager* webMgr = [[[JSWebManager alloc] initWithAsyncOption:NO] autorelease];
    NSDictionary* ret = [webMgr GetDataFromUrl:url];
    NSError* error = [ret objectForKey:@"error"];
    if (error)
    {
		[self stopLoading];
        self.view.userInteractionEnabled=YES;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Connection failed...Please launch the application again." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
    else
    {
        NSDictionary *parsedData = (NSDictionary *)[ret objectForKey:@"data"];
        self.view.userInteractionEnabled=YES;
        
        NSDictionary *json = [[ret objectForKey:@"text"] JSONValue];
        NSString *messegeStr=(NSString*)[parsedData objectForKey:@"Message"];
        //For checking session validation
        
        if([messegeStr isEqualToString:@"Site suspended"])
        {
            ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Site suspended";
            UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Site suspended. Please try after sometime." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            sessionAlertView.tag=1;
            [sessionAlertView show];
            [sessionAlertView release];
            return;
        }
        else if ([messegeStr isEqualToString:@"Session Expired"])
        {
            ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Session Expired";
            UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Your session has expired. Please login again." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            sessionAlertView.tag=1;
            [sessionAlertView show];
            [sessionAlertView release];
            return;
        }
        else if ([messegeStr isEqualToString:@"Membership denied"]||[messegeStr isEqualToString:@"Membership Denied"])
        {
            UIAlertView *MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Please upgrade your membership to view the mailbox." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [MembershipAlertView show];
            [MembershipAlertView release];
            return;
        }
        
        resultCount = (NSString*)[parsedData objectForKey:@"count"];
        NSString *string = (NSString*)[parsedData objectForKey:@"Total rows"];
        countTotal=[string intValue];
        
        if(countTotal==0)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"No Mail found"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
            [table reloadData];
            [self stopLoading];
            return;
        }
        
        if([resultCount intValue]==0)
        {
            [self stopLoading];
            return;
        }
        else
        {
            NSArray *senderIds = [json valueForKeyPath:@"result.sender_id"];
            if (senderId==nil)
            {
                senderId=[[NSMutableArray alloc] initWithArray:senderIds copyItems:YES];
            }
            else
            {
                [senderId addObjectsFromArray:senderIds];
            }
            NSArray *messageIds = [json valueForKeyPath:@"result.message_id"];
            if (messageId==nil)
            {
                messageId=[[NSMutableArray alloc] initWithArray:messageIds copyItems:YES];
            }
            else
            {
                [messageId addObjectsFromArray:messageIds];
            }
            NSArray *conversationIds = [json valueForKeyPath:@"result.conversation_id"];
            if (conversationId==nil)
            {
                conversationId=[[NSMutableArray alloc] initWithArray:conversationIds copyItems:YES];
            }
            else
            {
                [conversationId addObjectsFromArray:conversationIds];
            }
            NSArray *conversationNo=[json valueForKeyPath:@"result.conversation_number"];
            if (conversationNumber==nil)
            {
                conversationNumber=[[NSMutableArray alloc] initWithArray:conversationNo copyItems:YES];
            }
            else
            {
                [conversationNumber addObjectsFromArray:conversationNo];
            }
            NSArray *messageContentArrayInfo = [json valueForKeyPath:@"result.text"];
            if (messageContentArray==nil)
            {
                messageContentArray=[[NSMutableArray alloc] initWithArray:messageContentArrayInfo copyItems:YES];
            }
            else
            {
                [messageContentArray addObjectsFromArray:messageContentArrayInfo];
            }
            NSArray *timeArrayInfo = [json valueForKeyPath:@"result.Time"];
            if (timeArray==nil)
            {
                timeArray=[[NSMutableArray alloc] initWithArray:timeArrayInfo copyItems:YES];
            }
            else
            {
                [timeArray addObjectsFromArray:timeArrayInfo];
            }
            NSArray *genderArr= [json valueForKeyPath:@"result.sex"];
            if (genders==nil)
            {
                genders=[[NSMutableArray alloc] initWithArray:genderArr copyItems:YES];
            }
            else
            {
                [genders addObjectsFromArray:genderArr];
            }
            NSArray *nameArr = [json valueForKeyPath:@"result.username"];
            if (nameArray==nil)
            {
                nameArray=[[NSMutableArray alloc] initWithArray:nameArr copyItems:YES];
            }
            else
            {
                [nameArray addObjectsFromArray:nameArr];
            }
            NSArray *messageSubjectArrayInfo = [json valueForKeyPath:@"result.subject"];
            if (messageSubjectArray==nil)
            {
                messageSubjectArray=[[NSMutableArray alloc] initWithArray:messageSubjectArrayInfo copyItems:YES];
            }
            else
            {
                [messageSubjectArray addObjectsFromArray:messageSubjectArrayInfo];
            }
            NSArray *readMsgsInfo = [json valueForKeyPath:@"result.bm_read"];
            if (readMsgs==nil)
            {
                readMsgs=[[NSMutableArray alloc] initWithArray:readMsgsInfo copyItems:YES];
            }
            else
            {
                [readMsgs addObjectsFromArray:readMsgsInfo];
            }
            
            NSArray *lastReadUser = [json valueForKeyPath:@"result.LR"];
            if (lastRead==nil)
            {
                lastRead=[[NSMutableArray alloc] initWithArray:lastReadUser copyItems:YES];
            }
            else
            {
                [lastRead addObjectsFromArray:lastReadUser];
            }
            
            NSArray *picURLs = [json valueForKeyPath:@"result.Profile_Pic"];
            if (thumbPicURLs!=nil)
            {
                [thumbPicURLs addObjectsFromArray:picURLs];
            }
            else
            {
                thumbPicURLs=[[[NSMutableArray alloc] initWithArray:picURLs copyItems:YES] retain];
            }
        }
        
        [table reloadData];
        [self stopLoading];
        loadFlag=YES;
    }
    [JSWaiter HideWaiter];
}

#pragma mark Table View Data Source Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    // Return the number of sections.
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // returning the no of rows in section
    if (nameArray.count==0)
    {
        return  countTotal;
    }
    else if (nameArray.count<countTotal) 
    {
        return ([nameArray count]+1);
    }
    else
        return [nameArray count];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //for creating cell height
      return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell;
    cell=nil;
   
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    if (indexPath.section==0) 
    {
        int a=[nameArray count];
        if (indexPath.row==a) 
        {
            if (a<countTotal) 
            {
                if (countTotal!=0) 
                {
                    CGRect frameName =CGRectMake(115,40, 120,22 );
                    lblOfName=[[UILabel alloc]initWithFrame:frameName];
                    lblOfName.text=@"Load more...";
                    lblOfName.font=[UIFont fontWithName:@"Helvetica-Bold" size:15];
                    lblOfName.textColor =[UIColor darkGrayColor];
                    lblOfName.backgroundColor=[UIColor clearColor];
                    lblOfName.textAlignment=UITextAlignmentLeft;
                    [ cell.contentView addSubview: lblOfName];
                    [lblOfName release];
                    
                    //code for underline text
                    CGSize expectedLabelSize = [lblOfName.text sizeWithFont:lblOfName.font constrainedToSize:lblOfName.frame.size lineBreakMode:UILineBreakModeWordWrap];
                    CGRect frameName1 =CGRectMake(115,((40+lblOfName.frame.size.height)-4), expectedLabelSize.width, 1);
                    UIView *viewUnderline=[[UIView alloc]initWithFrame:frameName1];
                    viewUnderline.backgroundColor=[UIColor darkGrayColor];
                    [ cell.contentView addSubview: viewUnderline];
                    [viewUnderline release];
                }
            }
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            //adding the accessory disclosure button to cell
            isKiss=NO;
            isWink=NO;
            UIImageView *imgview=[[[UIImageView alloc]initWithFrame:CGRectMake(10, 18, 60, 60)] autorelease];
            imgview.layer.cornerRadius=10.0;
            imgview.layer.masksToBounds=YES;
            imgview.layer.borderColor = [UIColor lightGrayColor].CGColor;
            imgview.layer.borderWidth = 1.0;
            [cell addSubview:imgview];
            imgview.image=[UIImage imageNamed:@"ImageLoading.png"];
            
            // Lazy image loading         
            NSString *profilePicURL1=[NSString stringWithFormat:@"%@%@",domain,[thumbPicURLs objectAtIndex:indexPath.row]];
            NSString *imageName=[NSString stringWithFormat:@"%@",[thumbPicURLs objectAtIndex:indexPath.row]];
            //imageName=[imageName stringByReplacingOccurrencesOfString:@"/$userfiles/" withString:@""];  // for old version
            imageName=[imageName stringByReplacingOccurrencesOfString:@"/userfiles/" withString:@""];  // for new version
            NSString *originalPath =[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]  stringByAppendingPathComponent:@"Images"];
            NSString *localFilePath = [originalPath stringByAppendingPathComponent:imageName];
            BOOL isDir=[CommonStaticMethods directoryExistsAtAbsolutePath:[originalPath stringByAppendingPathComponent:@"profile.png"]];
            if(!isDir)
            {
                [[NSFileManager defaultManager]createDirectoryAtPath: originalPath withIntermediateDirectories: YES attributes: nil error: NULL];
            }
            queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
            dispatch_async(queue, ^{
                BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:localFilePath];
                if (!fileExists)
                {
                    NSURL *imageURL = [[[NSURL alloc] initWithString:profilePicURL1]autorelease];            
                    NSURLRequest *request = [NSURLRequest requestWithURL:imageURL];
                    [NSURLConnection connectionWithRequest:request delegate:self];
                    NSData *thedata = [NSData dataWithContentsOfURL:imageURL];
                    [thedata writeToFile:localFilePath atomically:YES];
                }
                UIImage* image = [UIImage imageWithContentsOfFile:localFilePath];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    if(image)
                    {
                        [imgview setImage:image];
                    }
                    else
                    {
                        if([genders count]>0)
                        {
                            if ( ([genders objectAtIndex:indexPath.row] == (id)[NSNull null])
                                || ([genders objectAtIndex:indexPath.row] == NULL)
                                || ([[genders objectAtIndex:indexPath.row] isEqual:@""])
                                || ([[genders objectAtIndex:indexPath.row] length] == 0) )
                            {                                                      
                                imgview.image=[UIImage imageNamed:@"man.png"];
                            }
                            else
                            {
                                if ([[genders objectAtIndex:indexPath.row] intValue]==1) 
                                {
                                    imgview.image=[UIImage imageNamed:@"women.png"];
                                }
                                else if ([[genders objectAtIndex:indexPath.row] intValue]==2) 
                                {
                                    imgview.image=[UIImage imageNamed:@"man.png"];
                                }
                                else if ([[genders objectAtIndex:indexPath.row] intValue]==4) 
                                {
                                    imgview.image=[UIImage imageNamed:@"man_women.png"];
                                }
                                else if ([[genders objectAtIndex:indexPath.row] intValue]==8) 
                                {
                                    imgview.image=[UIImage imageNamed:@"man_women_a.png"];
                                }
                                else 
                                {
                                    imgview.image=[UIImage imageNamed:@"man.png"];
                                } 
                            }
                        }
                        else
                        {
                            imgview.image=[UIImage imageNamed:@"man.png"];
                        }
   
                    }
                });
            });  
            
            dispatch_release(queue);
            NSString *winkstring=[NSString stringWithFormat:@"[wink]4[/wink]"];
            NSString *smilestring=[NSString stringWithFormat:@"[smiles]58[/smiles]"];
          
            if (([messageContentArray objectAtIndex:indexPath.row]== (id)[NSNull null])||([messageContentArray objectAtIndex:indexPath.row]== NULL)) 
            {
                lblOfTxt.text=@"";
                [cell addSubview:lblOfTxt];
            }
            else if([[messageContentArray objectAtIndex:indexPath.row] isEqualToString:winkstring])
            {
                isKiss=NO;
                isWink=YES;
                UIImageView *smileyImgView=[[UIImageView alloc]init];
                smileyImgView.frame=CGRectMake(135, 65, 25, 25);
                smileyImgView.animationImages=winkImagesArray;
                smileyImgView.animationDuration=1.5;
                smileyImgView.animationRepeatCount=0;
                [smileyImgView startAnimating];
                [cell addSubview:smileyImgView];
                [smileyImgView release];
            }
            else if([[messageContentArray objectAtIndex:indexPath.row] isEqualToString:smilestring])
            {
                isKiss=YES;
                isWink=NO;
                UIImageView *smileyImgView=[[UIImageView alloc]init];
                smileyImgView.frame=CGRectMake(135, 62, 35, 20);
                smileyImgView.animationImages=kissesImagesArray;
                smileyImgView.animationDuration=3.5;
                smileyImgView.animationRepeatCount=0;
                [smileyImgView startAnimating];
                [cell addSubview:smileyImgView];
                [smileyImgView release];
            }
            else
            {
                CGRect frame3=CGRectMake(70,50, 185,30 );
                lblOfTxt=[[UITextView alloc]initWithFrame:frame3];
                lblOfTxt.userInteractionEnabled=NO;
                lblOfTxt.font = [UIFont fontWithName:@"Helvetica" size:15]; 
                lblOfTxt.textColor=[UIColor colorWithRed:112/255.0 green:110/255.0 blue:110/255.0 alpha:2.0];
                lblOfTxt.text=[messageContentArray objectAtIndex:indexPath.row];
                [cell addSubview:lblOfTxt];
            }
            
            CGRect frame2=CGRectMake(78,37, 180,18 );
            lblOfSubject=[[UILabel alloc]initWithFrame:frame2];
            lblOfSubject.font=[UIFont boldSystemFontOfSize:17];
            lblOfSubject.textColor=[UIColor colorWithRed:98/255.0 green:96/255.0 blue:96/255.0 alpha:2.0];
            lblOfSubject.textAlignment=UITextAlignmentLeft;
            if (([messageSubjectArray objectAtIndex:indexPath.row]== (id)[NSNull null])||([messageSubjectArray objectAtIndex:indexPath.row]== NULL)) 
            {
                lblOfSubject.text=@"";
            }
            else if(isKiss)
            {
                lblOfSubject.frame=CGRectMake(78,32, 180,18 );
                lblOfSubject.text=[NSString stringWithFormat:@"%@ kissed to you",[messageSubjectArray objectAtIndex:indexPath.row]];
            }
            else if(isWink)
            {
                lblOfSubject.frame=CGRectMake(78,32, 180,18 );
                lblOfSubject.text=[NSString stringWithFormat:@"%@ wink to you",[messageSubjectArray objectAtIndex:indexPath.row]];
            }
            else
            {
                lblOfSubject.text=[messageSubjectArray objectAtIndex:indexPath.row];
            }
            
            [cell addSubview: lblOfSubject];
            
            if (isKiss||isWink)
            {
            }
            else
            {
                CGRect frame1 =CGRectMake(78,15, 200,22 );
                lblOfName=[[UILabel alloc]initWithFrame:frame1];
                lblOfName.font=[UIFont fontWithName:@"Ubuntu-Bold" size:17];
                lblOfName.textColor =[UIColor blackColor]; 
                lblOfName.textAlignment=UITextAlignmentLeft;
                if (([nameArray objectAtIndex:indexPath.row]== (id)[NSNull null])||([nameArray objectAtIndex:indexPath.row]==NULL)) 
                {
                    lblOfName.text=@"";
                }
                else 
                {
                    lblOfName.text=[nameArray objectAtIndex:indexPath.row];
                }
                [cell addSubview: lblOfName];
            }
            
            CGRect frame6=CGRectMake(26,90, 170,15 );
            UILabel *lblOfTime=[[UILabel alloc]initWithFrame:frame6];
            if (([timeArray objectAtIndex:indexPath.row]== (id)[NSNull null])||([timeArray objectAtIndex:indexPath.row]==NULL)) 
            {
                lblOfTime.text=@"";
            }
            else 
            {        
                NSString *trimstring =[timeArray objectAtIndex:indexPath.row];
                lblOfTime.text=[self FormatTime:trimstring];
            }
            
            lblOfTime.font=[UIFont boldSystemFontOfSize:14];
            lblOfTime.textColor=[UIColor colorWithRed:163/255.0 green:163/255.0 blue:163/255.0 alpha:2.0]; 
            lblOfTime.textAlignment=UITextAlignmentLeft;
            [cell addSubview: lblOfTime];
            [lblOfTime release];
          
            if ([conversationNumber objectAtIndex:indexPath.row]== (id)[NSNull null]||[[conversationNumber objectAtIndex:indexPath.row] isEqualToString:@"1"]||!inboxFlag )
            {
            }
            else if(inboxFlag) 
            {
                messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(300,45,20,20)];
                [messageLabel setTextAlignment:UITextAlignmentCenter];
                messageLabel.text=[conversationNumber objectAtIndex:indexPath.row];
                messageLabel.layer.cornerRadius = 5.0f;
                messageLabel.textColor =[UIColor whiteColor];
                [messageLabel setFont:[UIFont boldSystemFontOfSize:12.0]];
                messageLabel.backgroundColor=[UIColor colorWithRed:147/255.0 green:156/255.0 blue:165/255.0 alpha:2.0];
                [cell.contentView addSubview:messageLabel];
            }
            
            if (sentFlag)
            {
                sentFlag=YES;
                inboxFlag=NO;
                messageLabel.hidden=YES;
            }
            
            if (inboxFlag)
            {
                inboxFlag=YES;
                sentFlag=NO;
        
                // image for showing unread messages
                NSString *isReaded;
                if ([readMsgs objectAtIndex:indexPath.row]== (id)[NSNull null]||[readMsgs objectAtIndex:indexPath.row]==NULL)
                {
                    isReaded=@"1";
                }
                else
                {
                    isReaded=[readMsgs objectAtIndex:indexPath.row];
                }
                                           
                NSString *lastReadUserId;
                if ([lastRead objectAtIndex:indexPath.row]== (id)[NSNull null]||[lastRead objectAtIndex:indexPath.row]==NULL)
                {
                    lastReadUserId=@"";
                }
                else
                {
                    lastReadUserId=[lastRead objectAtIndex:indexPath.row];
                }
                
                NSString *profileID=((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID;
                NSString *initiatorId=[senderId objectAtIndex:indexPath.row];
                
                if([isReaded isEqualToString:@"0"])
                {
                    UIImageView *imgarrow;
                    imgarrow=[[UIImageView alloc] initWithFrame:CGRectMake(12, 92, 10, 10)];
                    imgarrow.image =[UIImage imageNamed:@"blueroundbtn.png"];
                    [cell addSubview:imgarrow];
                    [imgarrow release];
                   
                }
                else if(([isReaded isEqualToString:@"1"]) && ([lastReadUserId isEqualToString:profileID]))
                {
                    UIImageView *imgarrow;
                    imgarrow=[[UIImageView alloc] initWithFrame:CGRectMake(12, 92, 10, 10)];
                    imgarrow.image =[UIImage imageNamed:@"blueroundbtn.png"];
                    [cell addSubview:imgarrow];
                    [imgarrow release];
                }
                else if(([isReaded isEqualToString:@"2"]) && ![initiatorId isEqualToString:@"0"] && ([lastReadUserId isEqualToString:profileID]))
                {
                    UIImageView *imgarrow;
                    imgarrow=[[UIImageView alloc] initWithFrame:CGRectMake(12, 92, 10, 10)];
                    imgarrow.image =[UIImage imageNamed:@"blueroundbtn.png"];
                    [cell addSubview:imgarrow];
                    [imgarrow release];
                }
            }
                         
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                if (self.interfaceOrientation==UIInterfaceOrientationLandscapeRight||self.interfaceOrientation==UIInterfaceOrientationLandscapeLeft) 
                {
                    [lblOfName setFrame:CGRectMake(78,15, 450,22 )];
                    [lblOfSubject setFrame:CGRectMake(78,37, 450,18 )];
                    [lblOfTxt setFrame:CGRectMake(70,50, 500,30 )];
                    [messageLabel setFrame:CGRectMake(970,45,20,20)];
                }
                else
                {
                    [lblOfName setFrame:CGRectMake(78,15, 450,22 )];
                    [lblOfSubject setFrame:CGRectMake(78,37, 450,18 )];
                    [lblOfTxt setFrame:CGRectMake(70,50, 500,30 )];
                    [messageLabel setFrame:CGRectMake(710,45,20,20)];
                }
            }
            else
            {
                [messageLabel setFrame:CGRectMake(280,45,20,20)];
            }
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
       
        int a=[nameArray count];
        if (indexPath.row==a) 
        {
            if (inboxFlag)
            {
                self.view.userInteractionEnabled=NO;
                urlReq =[NSString stringWithFormat:@"%@/mobile/ViewInboxByLimit/?id=%@&skey=%@&start=%i&limit=10",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID,a];
                [JSWaiter ShowWaiter:self title:@"Loading..." type:0];
                [self performSelectorOnMainThread:@selector(WebRequest:) withObject:urlReq waitUntilDone:NO];
            }
            else 
            {
                self.view.userInteractionEnabled=NO;
                urlReq =[NSString stringWithFormat:@"%@/mobile/SendMailByLimit/?id=%@&skey=%@&start=%i&limit=10",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID,a];
                [JSWaiter ShowWaiter:self title:@"Loading..." type:0];
                [self performSelectorOnMainThread:@selector(WebRequest:) withObject:urlReq waitUntilDone:NO];
            }
        }
        else
        {
            NSString *conversationNum=[conversationNumber objectAtIndex:indexPath.row];
            if ([conversationNum isEqualToString:@""]||[conversationNum isEqualToString:@"0"]||[conversationNum isEqualToString:@"1"])
            {
                NSString *mesgId=[messageId objectAtIndex:indexPath.row];
                NSString *sendId=[senderId objectAtIndex:indexPath.row];
                MessageView *objMessageView=[[MessageView alloc]initWithNibName:@"MessageView" bundle:nil];
                objMessageView.messageID1=mesgId;
                objMessageView.profileID=sendId;
                objMessageView.rootMsgIDArray=messageId;
                objMessageView.rootConIDArray=conversationId;
                objMessageView.rootConNumArray=conversationNumber;
                objMessageView.index=indexPath.row;
                objMessageView.fromInbox=inboxFlag;
                objMessageView.conversationNumber=1;
                if (inboxFlag)
                {
                    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                    [prefs setBool:YES forKey:@"Inbox"];
                }
                else 
                {
                    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                    [prefs setBool:NO forKey:@"Inbox"];
                }
                [self.navigationController pushViewController:objMessageView animated:YES];
                [objMessageView release];
            }
            else
            {
                NSString *mesgId1=[conversationId objectAtIndex:indexPath.row];
                NSString *sendId1=[senderId objectAtIndex:indexPath.row];
                MailConversationView *objMailConversationView=[[MailConversationView alloc]initWithNibName:@"MailConversationView" bundle:nil];
                objMailConversationView.messageID=mesgId1;
                objMailConversationView.senderID=sendId1;
                objMailConversationView.rootMsgIDArray=messageId;
                objMailConversationView.rootConIDArray=conversationId;
                objMailConversationView.rootConNumArray=conversationNumber;
                objMailConversationView.index=indexPath.row;
                objMailConversationView.conversNum=conversationNum;
                
                if (inboxFlag) 
                {
                    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                    [prefs setBool:YES forKey:@"Inbox"];
                }
                else 
                {
                    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                    [prefs setBool:NO forKey:@"Inbox"];
                }
                
                [self.navigationController pushViewController:objMailConversationView animated:YES];
                [objMailConversationView release]; 
                
            }
            
        }
        
    }
    
}


@end
