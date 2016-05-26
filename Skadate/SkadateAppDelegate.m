//
//  SkadateAppDelegate.m
//  Skadate
//
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SkadateAppDelegate.h"
#import <CommonCrypto/CommonDigest.h>
#import "SkadateViewController.h"
#import <CFNetwork/CFNetwork.h>

@implementation SkadateAppDelegate

@synthesize splashView;
@synthesize loggedProfileID;
@synthesize loggedProfilePic;
@synthesize loggedNotifications;
@synthesize loggedUserStatus;
@synthesize loggedUserMessage;
@synthesize loggedUserUnRegistered;
@synthesize loggedUserImg;
@synthesize window;
@synthesize navigation;
@synthesize viewController;
@synthesize redVal;
@synthesize greenVal;
@synthesize blueVal;
@synthesize redNavbar;
@synthesize greenNavbar;
@synthesize blueNavbar;
@synthesize fontNavTitle;
@synthesize fontHomeTitle;
@synthesize redNavBorder;
@synthesize greenNavBorder;
@synthesize blueNavBorder;
@synthesize username;
@synthesize password;
@synthesize siteURL;
//@synthesize salt;
@synthesize genderValue;
@synthesize loggedSessionID;
@synthesize fromCommentView;
@synthesize fromlikesView_liked;
@synthesize fromlikesView_Unliked;
@synthesize loggedTimeZone;
@synthesize appDelegateTimer;
@synthesize appDelegateinvocation;
@synthesize loggedMailCount;
@synthesize domain;
@synthesize respData;
@synthesize NotificationCountConnection;
@synthesize loggedUserChatImg;

#pragma mark Memory Management

- (void)dealloc
{
    [navigation release];
    [window release];
    [viewController release];
    [appDelegateTimer invalidate];
    appDelegateTimer=nil;
    
    [super dealloc];
}

#pragma mark Custom Methods

-(void)GetAvatarChange
{    
    NSString *profilePic=((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfilePic;
        
    int gender = [((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).genderValue intValue];
    
    if ([profilePic isEqualToString:@""]||(profilePic == (id)[NSNull null])||([profilePic length] == 0)||(profilePic==NULL)) 
    {
        
        if (gender==1) 
        {
           ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedUserImg=[UIImage imageNamed:@"women.png"] ;             
        }
        else if (gender==2) 
        {
            ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedUserImg=[UIImage imageNamed:@"man.png"];
        }
        else if (gender==4)
        {
            ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedUserImg=[UIImage imageNamed:@"man_women.png"];
        }
        else  if (gender==8)
        {
            ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedUserImg=[UIImage imageNamed:@"man_women_a.png"] ;
        } 
        else
        {
            ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedUserImg=[UIImage imageNamed:@"man.png"];
        }
    }
    else
    {
        profilePic=[NSString stringWithFormat:@"%@%@",domain,profilePic];
        
        NSData *mydata = [[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:profilePic]] autorelease];
        if (mydata) 
        {
            
            UIImage *myimage = [[[UIImage alloc] initWithData:mydata] autorelease];
                       
            if (myimage)
            {                
                 ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedUserImg=myimage; 
            }
            else
            {                
                if (gender==1) 
                {
                    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedUserImg=[UIImage imageNamed:@"women.png"];             
                }
                else if (gender==2) 
                {
                    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedUserImg=[UIImage imageNamed:@"man.png"] ;
                }
                else if (gender==4) 
                {
                    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedUserImg=[UIImage imageNamed:@"man_women.png"];
                }
                else  if (gender==8)
                {
                    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedUserImg=[UIImage imageNamed:@"man_women_a.png"];
                }
                else
                {
                     ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedUserImg=[UIImage imageNamed:@"man.png"];
                }
                            
            }
            
        }
        else
        {            
            if (gender==1)
            {
                ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedUserImg=[UIImage imageNamed:@"women.png"] ;             
            }
            else if (gender==2) 
            {
                 ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedUserImg=[UIImage imageNamed:@"man.png"];
            }
            else if (gender==4) 
            {
                ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedUserImg=[UIImage imageNamed:@"man_women.png"];
            }
            else  if (gender==8)
            {
                 ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedUserImg=[UIImage imageNamed:@"man_women_a.png"];
            } 
            else
            {
                ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedUserImg=[UIImage imageNamed:@"man.png"];
            }
          
        }
        
    }
    
}


- (void)urlResponseData:(NSData *)respData1 
{
    
	NSString *responseString = [[NSString alloc] initWithData:respData1 encoding:NSUTF8StringEncoding];
	NSError *error;
       
    if (!responseString) 
    {
        return;
    }
          
	SBJsonParser *parser = [[SBJsonParser alloc] init];
	NSDictionary *parsedData = (NSDictionary *)[parser objectWithString:responseString error:&error];
    [responseString release];
    CFRelease((CFTypeRef) parser);
    
    if(!parsedData)
    {        
        return;
    }
       
    if ((NSString*)[parsedData valueForKey:@"chatcount"]==(id)[NSNull null]||(NSString*)[parsedData valueForKey:@"chatcount"]==NULL) 
    {        
        ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedNotifications=0;
    }
    else
    {        
        NSString *CountVal=[NSString stringWithFormat:@"%@",(NSString*)[parsedData valueForKey:@"chatcount"]];
        
        ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedNotifications= (NSNumber*)CountVal;
    }
    
    if ((NSString*)[parsedData valueForKey:@"mailcount"]==(id)[NSNull null]||(NSString*)[parsedData valueForKey:@"mailcount"]==NULL) 
    {        
        ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedMailCount=0;
    }
    else
    {        
        NSString *CountVal=[NSString stringWithFormat:@"%@",(NSString*)[parsedData valueForKey:@"mailcount"]];
        
        ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedMailCount= (NSNumber*)CountVal;
    }
    
    if ([parsedData valueForKey:@"status"]==(id)[NSNull null]||[parsedData valueForKey:@"status"]==NULL)
    {        
        ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedUserStatus=@"";
    }
    else
    {        
        ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedUserStatus=[NSString stringWithFormat:@"%@",[parsedData valueForKey:@"status"]];
    }
    
    if ([parsedData valueForKey:@"Message"]==(id)[NSNull null]||[parsedData valueForKey:@"Message"]==NULL)
    {        
        ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedUserMessage=@"";
    }
    else
    {        
        ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedUserMessage=[NSString stringWithFormat:@"%@",[parsedData valueForKey:@"Message"]];
    }
    
    if ([parsedData valueForKey:@"Un_Registered"]==(id)[NSNull null]||[parsedData valueForKey:@"Un_Registered"]==NULL) 
    {        
        ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedUserUnRegistered=@"";
    }
    else
    {        
        ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedUserUnRegistered=[NSString stringWithFormat:@"%@",[parsedData valueForKey:@"Un_Registered"]];
    }
    
    NSString *imgUrl=(NSString*)[parsedData objectForKey:@"Profile_Pic"]; 
    if ([((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfilePic isEqualToString:imgUrl])
    {
        ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfilePic=imgUrl;
    }
    else
    {
        if (imgUrl==(id)[NSNull null]||imgUrl==NULL||[imgUrl isEqualToString:@""]) 
        {        
            ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfilePic=@"";
            ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedUserImg=nil;
        }
        else
        {                
            ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfilePic=imgUrl; 
           
        }  
        [self GetAvatarChange];
        
    }
    
}


-(void)checkUserStatus
{    
    NSString *userStatusResult = [CommonStaticMethods getUserStatus];
    if ([userStatusResult length]>0) 
    {
        ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedProfileID=@"";
        ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserStatus=@"";
        ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserUnRegistered=@"";
        ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedProfilePic=@"";
        
        ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserChatImg=nil
        ;
        ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedUserImg=nil;
                       
        if ([((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage isEqualToString:@"Session Expired"] || [((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage isEqualToString:@"Site suspended"] )
        {
            ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"";
            NSArray *array = self.navigation.viewControllers;
                      
            if ([array count]==2)
            {
                UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[userStatusResult description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
                sessionAlertView.tag=1;
                
                [sessionAlertView show];
                [sessionAlertView release];
            }

            return;
        }
        else
        {
            ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"";
            UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[userStatusResult description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            sessionAlertView.tag=1;
            
            [sessionAlertView show];
            [sessionAlertView release];
            return;
        }
        
    }   
    
}

- (void)allTasksDone 
{
   [self release];
    
}

-(void )fetchNotificationData
{
    
    NSString *loggedId=((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedProfileID;
           
    if (loggedId)
    {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
        
        if ([loggedId length]==0)
        {
            ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedProfileID=@"";
            ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserStatus=@"";
            ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"";
            ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserUnRegistered=@"";
            ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedProfilePic=@"";
            
            ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserUnRegistered=@"";
            ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedUserImg=nil;
             
        }
        else
        {            
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            domain = [prefs stringForKey:@"URL"];
            
            NSString *urlReq = [NSString stringWithFormat:@"%@/mobile/NotificationCount/?pid=%@&skey=%@",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedSessionID];
                                                         
            NSURL *url = [NSURL URLWithString:[urlReq stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            NSURLRequest *urlrequest = [NSURLRequest requestWithURL:url];
                        
            dispatch_async(queue, ^{
                NSURLResponse *response = nil;
                NSError *error = nil;
                
                NSData *receivedData = [NSURLConnection sendSynchronousRequest:urlrequest
                                                             returningResponse:&response
                                                                         error:&error];
                
                [self urlResponseData:receivedData];
                
            });  
            
            [self performSelectorOnMainThread:@selector(checkUserStatus) withObject:nil waitUntilDone:NO];
            
            dispatch_release(queue);
        }
        
    }
                            
}

- (NSString *)strToSha1:(NSString *)str
{
    const char *s = [str cStringUsingEncoding:NSASCIIStringEncoding];
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

#pragma mark Application delegate callback

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    redVal=239.0;
    greenVal=236.0;
    blueVal=234.0;
    
    redNavbar=230.0;
    greenNavbar=230.0;
    blueNavbar=230.0;
    
    redNavBorder=173.0;
    greenNavBorder=173.0;
    blueNavBorder=173.0;
    
    username=[[[NSString alloc]init] retain];
    password=[[[NSString alloc]init] retain];
    siteURL=[[[NSString alloc]init] retain];
    //salt=[[[NSString alloc]init] retain];
    
    fontNavTitle=[UIFont fontWithName:@"Helvetica-Bold" size:22];
    
    fontHomeTitle=[UIFont fontWithName:@"Helvetica-Bold" size:12];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSString *uname = [prefs stringForKey:@"Username"];
    NSString *pwd = [prefs stringForKey:@"Password"];
    NSString *url = [prefs stringForKey:@"URL"];
    //NSString *sitesalt = [prefs stringForKey:@"SALT"];
    
    if (![uname isEqualToString:@""] || ![pwd isEqualToString:@""] || ![url isEqualToString:@""] /*|| ![sitesalt isEqualToString:@""]*/)
    {
        navigation=[[UINavigationController alloc]initWithRootViewController:viewController]; 
    }
    else 
    {
        username=uname;
        password=pwd;
        siteURL=url;
        //salt=sitesalt;
    }
       
   // [window addSubview:navigation.view];
    
    [self.window setRootViewController:navigation];
    [self.window makeKeyAndVisible];
    splashView = [UIImageView alloc];
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {        
        splashView = [splashView initWithFrame:CGRectMake(0,0, 320, 480)];
        splashView.image = [UIImage imageNamed:@"Home.png"];
        [window addSubview:splashView];
        [self.window makeKeyAndVisible];
        [window bringSubviewToFront:splashView];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1.0];
        [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:window cache:YES];
        [UIView setAnimationDelegate:self]; 
        [splashView retain];
        
        [UIView setAnimationDidStopSelector:@selector(startupAnimationDone:finished:context:)];
        splashView.alpha = 0.0;
        
        splashView.frame = CGRectMake(-60, -60, 440, 600);
        
        [UIView commitAnimations];
        
    }
    else
    {        
        sleep(3);
    }
    
    [prefs setBool:NO forKey:@"touAgreed"];
    
    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedMailCount=0;
    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedNotifications=0;
           
    appDelegateinvocation= [NSInvocation invocationWithMethodSignature:
                 [self methodSignatureForSelector: @selector(fetchNotificationData)]];
    [appDelegateinvocation setTarget:self];
    [appDelegateinvocation setSelector:@selector(fetchNotificationData)];
    
    if (appDelegateTimer) 
    {        
        [appDelegateTimer invalidate];
        appDelegateTimer = nil;
    }
    
    appDelegateTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 invocation:appDelegateinvocation repeats:YES];
    return YES;
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
    
   /* [[NSNotificationCenter defaultCenter] 
     postNotificationName:@"DismissSaveResultsAlertView" object:nil];*/
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
    
    [[NSNotificationCenter defaultCenter] 
     postNotificationName:@"DismissSaveResultsAlertView" object:nil];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


#pragma mark AlertView delegate

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex 
{    
    if(actionSheet.tag==1&&buttonIndex==0)
    {        
               
        NSArray *array = self.navigation.viewControllers;
        NSString* class =@"SkadateViewController";
        Class detailClass = NSClassFromString(class);
        UIViewController* detailViewController = [[[detailClass alloc] initWithNibName:nil bundle:nil] autorelease];
        
        for(UIViewController *tempVC in array)
        {
            if([tempVC isKindOfClass:[detailViewController class]])
            {
                [self.navigation popToViewController:[array objectAtIndex:[array indexOfObject:tempVC]] animated:NO];
            }
        }
                
    }
}

#pragma mark NavigationController Management

- (void)navigationController:(UINavigationController *)navigationController 
      willShowViewController:(UIViewController *)newViewController animated:(BOOL)animated 
{
    [newViewController viewWillAppear:animated];
}

- (void)navigationController:(UINavigationController *)navigationController 
       didShowViewController:(UIViewController *)newViewController animated:(BOOL)animated 
{
    [newViewController viewDidAppear:animated];
}


@end
