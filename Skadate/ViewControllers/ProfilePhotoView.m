//
//  ProfilePhotoView.m
//  Chk
//
//  Created by SODTechnologies on 23/08/11.
//  Copyright 2011 Solutions On Demand Australasia Pty Ltd. All rights reserved.
//

#import "ProfilePhotoView.h"
#import "ProfileView.h"
#import "JSON.h"
#import "OnlineMembers.h"
#import "ChatMembersView.h"
#import "ComposeMessageView.h"
#import "SkadateAppDelegate.h"
#import "PhotoFullView.h"
#import "SearchResults.h"
#import "NewsFeedsController.h"
#import "MyNeighboursSearchResults.h"
#import "CommonStaticMethods.h"



@implementation ProfilePhotoView
@synthesize segmentControl,tempScrollView,btnComposeMail,btnBookmark,btnChat,btnHome;
@synthesize thumbPicURLs,profilegenderId,backbtnimgId;
@synthesize profileId,profileName,photoimgstring,domain,queue,imageView,imgBtn;
@synthesize timer,invocation,addedPicURLs;
@synthesize NewXval;


#pragma mark Memory Management

- (void)dealloc
{
    [super dealloc];
    [thumbPicURLs release];
    [addedPicURLs release];
    if (timer)
    {        
        [timer invalidate];
        timer = nil;
    }
    [fetchNot release];
    
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

-(void)ChangeImageOrientation
{
    
    for(UIView *subview in [tempScrollView subviews]) 
    {
        if([subview isKindOfClass:[UIButton class]])
        {
            [subview removeFromSuperview];
        }
    }  
    
    int imgX=4;
    int imgY=4;
    int colCount=1;
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    { 
        imgX=22;
        imgY=60;
    }
    
    for (int i=0; i<[thumbPicURLs count]; i++) 
    {
        imgBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [imgBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        imgBtn.tag=i;
       
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        { 
            imgBtn.frame= CGRectMake(imgX, imgY, 106, 106);
        }
        else
        {
            imgBtn.frame= CGRectMake(imgX, imgY, 75, 75);
        }
        
        [self.tempScrollView addSubview:imgBtn];
        NSString *profilePicURL=[NSString stringWithFormat:@"%@%@",domain,[thumbPicURLs objectAtIndex:i]];
        NSString *imageName=[NSString stringWithFormat:@"%@",[thumbPicURLs objectAtIndex:i]];
        //imageName=[imageName stringByReplacingOccurrencesOfString:@"/$userfiles/" withString:@""];  // for old version
        imageName=[imageName stringByReplacingOccurrencesOfString:@"/userfiles/" withString:@""];  // for new version
        NSString *originalPath =[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]  stringByAppendingPathComponent:@"Images"];
        NSString *localFilePath = [originalPath stringByAppendingPathComponent:imageName];
        BOOL isDir=[CommonStaticMethods directoryExistsAtAbsolutePath:[originalPath stringByAppendingPathComponent:@"profile.png"]];
       
        if(!isDir)
        {
            [[NSFileManager defaultManager]createDirectoryAtPath: originalPath withIntermediateDirectories: YES attributes: nil error: NULL];
        }
        
        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:localFilePath];
       
        if (!fileExists)
        {
            NSURL *imageURL = [[[NSURL alloc] initWithString:profilePicURL]autorelease];            
            NSURLRequest *request = [NSURLRequest requestWithURL:imageURL];
            [NSURLConnection connectionWithRequest:request delegate:self];
            NSData *thedata = [NSData dataWithContentsOfURL:imageURL];
            [thedata writeToFile:localFilePath atomically:YES];
        }
        
        UIImage* image = [UIImage imageWithContentsOfFile:localFilePath];
        [self performSelectorOnMainThread:@selector(displayImage:) withObject:image waitUntilDone:YES];
       
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            if (self.interfaceOrientation==UIInterfaceOrientationPortrait || self.interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown)  
            {
                colCount=6;
            }
            else
            {
                colCount=8;
            }
            
            if ((i+1)%colCount==0)
            {
                imgY=imgY + 122;
                imgX=-100;
            }
            
            imgX+=124;
        }
        else 
        {
            colCount=4;
            
            if ((i+1)%colCount==0)
            {
                imgY=imgY + 79;
                imgX=-75;
            }
            
            imgX+=79;
        }
        tempScrollView.contentSize=CGSizeMake(320,(imgY+350));          
    }
}
-(void)FetchProfilePhoto
{    
    fetchNot=[[CommonMethods alloc]init];
    fetchNot.delegate=self;
    [fetchNot fetchProfilePhoto:profileId];
}

- (void)loadNotificatonCounts:(NSDictionary *)notification
{
    
    NSString *messegeStr=(NSString*)[notification objectForKey:@"Message"]; 
    
    //For checking session validation
    if([messegeStr isEqualToString:@"Site suspended"])
    {
        return;
    }
    else if ([messegeStr isEqualToString:@"Session Expired"])
    {
        return;
    }
    else if ([messegeStr isEqualToString:@"Membership denied"]||[messegeStr isEqualToString:@"Membership Denied"])
    {
        return;
    }  
    
    NSString *resultCount = (NSString*)[notification objectForKey:@"count"];
    if([resultCount intValue]==0 )
    {
        [addedPicURLs removeAllObjects];
        [thumbPicURLs removeAllObjects];
        for(UIView *subview in [tempScrollView subviews]) 
        {
            if([subview isKindOfClass:[UIButton class]])
            {
                [subview removeFromSuperview];
            }
        }  
    }
    
    [addedPicURLs removeAllObjects];
    NSArray *picURLs = [notification valueForKeyPath:@"result.Photo"];
    
    if (addedPicURLs==nil) 
    {
        addedPicURLs=[[NSMutableArray alloc] initWithArray:picURLs copyItems:YES] ;
    }
    else
    {
        [addedPicURLs addObjectsFromArray:picURLs];
    }
    
    BOOL existsFlag=NO;
    
    if([addedPicURLs count]==[thumbPicURLs count])
    {
        for (NSString *photoUrl in addedPicURLs)
        {
            BOOL isTheObjectThere = [thumbPicURLs containsObject: photoUrl];
            if(!isTheObjectThere)
            {      
                existsFlag=YES;
                break;
            }
        }
    }
    else
    {
        existsFlag=YES;
    }
    
    if(existsFlag)
    {
        [thumbPicURLs removeAllObjects];
        [thumbPicURLs addObjectsFromArray:addedPicURLs];
        queue = [[NSOperationQueue alloc] init];
        NSInvocationOperation *operation = [[NSInvocationOperation alloc] 
                                            initWithTarget:self
                                            selector:@selector(RefreshProfilePhotos) 
                                            object:nil];
        [queue addOperation:operation]; 
        [operation release];
    }
    
}

-(void)loadDefaultImage 
{    
    loadFlag=YES;
    int imgX=4;
    int imgY=60;
    int colCount=1;
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    { 
        imgX=22;
        imgY=60;
    }
    
    UIImage* image = [UIImage imageNamed:@"Loading large.PNG"];
    
    for (int i=0; i<[thumbPicURLs count]; i++) 
    {
        imgBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        imgBtn.tag=i;
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        { 
            imgBtn.frame= CGRectMake(imgX, imgY, 106, 106);
        }
        else
        {
            imgBtn.frame= CGRectMake(imgX, imgY, 75, 75);
        }
        imgBtn.layer.masksToBounds=YES;
        [self.tempScrollView addSubview:imgBtn];
        [self performSelectorOnMainThread:@selector(displayImage:) withObject:image waitUntilDone:YES];
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            if (self.interfaceOrientation==UIInterfaceOrientationPortrait || self.interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown)  
            {
                colCount=6;
            }
            else
            {
                colCount=8;
            }
            
            if ((i+1)%colCount==0)
            {
                imgY=imgY + 122;
                imgX=-100;
            }
            imgX+=124;
        }
        else 
        {
            colCount=4;
            if ((i+1)%colCount==0)
            {
                imgY=imgY + 79;
                imgX=-75;
            }
            imgX+=79;
        }
        
        tempScrollView.contentSize=CGSizeMake(320,(imgY+350));    
        
    }
    
}


- (void)AllowEdit 
{    
    if(![queue isSuspended]) 
    {
        [queue setSuspended:YES];
    }
    
    loadFlag=NO;
    invocation= [NSInvocation invocationWithMethodSignature:
                 [self methodSignatureForSelector: @selector(FetchProfilePhoto)]];
    [invocation setTarget:self];
    [invocation setSelector:@selector(FetchProfilePhoto)];
   
    if (timer)
    {
        [timer invalidate];
        timer = nil;
    }
    
    timer = [NSTimer scheduledTimerWithTimeInterval:10.0 invocation:invocation repeats:YES];
}


-(void)loadImage 
{
    loadFlag=YES;
    int imgX=4;
    int imgY=60;
    int colCount=1;
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    { 
        imgX=22;
        imgY=60;
    }
    for (int i=0; i<[thumbPicURLs count]; i++) 
    {
        if(![queue isSuspended]) 
        {
            NSString *profilePicURL=[NSString stringWithFormat:@"%@%@",domain,[thumbPicURLs objectAtIndex:i]];
            NSString *imageName=[NSString stringWithFormat:@"%@",[thumbPicURLs objectAtIndex:i]];
            //imageName=[imageName stringByReplacingOccurrencesOfString:@"/$userfiles/" withString:@""];  // for old version
            imageName=[imageName stringByReplacingOccurrencesOfString:@"/userfiles/" withString:@""];  // for new version
            NSString *originalPath =[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]  stringByAppendingPathComponent:@"Images"];
            NSString *localFilePath = [originalPath stringByAppendingPathComponent:imageName];
                     
            BOOL isDir=[CommonStaticMethods directoryExistsAtAbsolutePath:[originalPath stringByAppendingPathComponent:@"profile.png"]];
            if(!isDir)
            {
                [[NSFileManager defaultManager]createDirectoryAtPath: originalPath withIntermediateDirectories: YES attributes: nil error: NULL];
            }
            BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:localFilePath];
            if (!fileExists)
            {
                
                NSURL *imageURL = [[[NSURL alloc] initWithString:profilePicURL]autorelease];            
                NSURLRequest *request = [NSURLRequest requestWithURL:imageURL];
                [NSURLConnection connectionWithRequest:request delegate:self];
                NSData *thedata = [NSData dataWithContentsOfURL:imageURL];
                [thedata writeToFile:localFilePath atomically:YES];
            }
            UIImage* image = [UIImage imageWithContentsOfFile:localFilePath];
            for(UIView *subview in [tempScrollView subviews]) 
            {
                if([subview isKindOfClass:[UIButton class]])
                {
                    UIButton *btn = (UIButton*)subview; 
                    if ( btn.tag ==i)
                    {
                        [subview removeFromSuperview];
                        imgBtn=[UIButton buttonWithType:UIButtonTypeCustom];
                        [imgBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
                        imgBtn.tag=i;
                        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
                        { 
                            imgBtn.frame= CGRectMake(imgX, imgY, 106, 106);
                        }
                        else
                        {
                            imgBtn.frame= CGRectMake(imgX, imgY, 75, 75);
                        }
                        imgBtn.layer.masksToBounds=YES;
                        [self.tempScrollView addSubview:imgBtn];
                        [self performSelectorOnMainThread:@selector(displayImage:) withObject:image waitUntilDone:YES];
                        break;
                    }
                }
            }  
            if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
            {
                if (self.interfaceOrientation==UIInterfaceOrientationPortrait || self.interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown)  
                {
                    colCount=6;
                }
                else
                {
                    colCount=8;
                }
                
                if ((i+1)%colCount==0)
                {
                    imgY=imgY + 122;
                    imgX=-100;
                }
                
                imgX+=124;
            }
            else 
            {
                colCount=4;
               
                if ((i+1)%colCount==0)
                {
                    imgY=imgY + 79;
                    imgX=-75;
                }
                
                imgX+=79;
            }
        }
        else
        {
            break; 
        }
    }
    [self performSelectorOnMainThread:@selector(AllowEdit) withObject:nil waitUntilDone:YES];
}


-(void)RefreshProfilePhotos 
{    
    loadFlag=YES;
    for(UIView *subview in [tempScrollView subviews]) 
    {
        if([subview isKindOfClass:[UIButton class]])
        {
            [subview removeFromSuperview];
        }
    }  
    
    int imgX=4;
    int imgY=60;
    int colCount=1;
  
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    { 
        imgX=22;
        imgY=60;
    }
    
    for (int i=0; i<[addedPicURLs count]; i++) 
    {
        if(![queue isSuspended]) 
        {
            NSString *profilePicURL=[NSString stringWithFormat:@"%@%@",domain,[addedPicURLs objectAtIndex:i]];
            NSString *imageName=[NSString stringWithFormat:@"%@",[addedPicURLs objectAtIndex:i]];
            //imageName=[imageName stringByReplacingOccurrencesOfString:@"/$userfiles/" withString:@""];  // for old version
            imageName=[imageName stringByReplacingOccurrencesOfString:@"/userfiles/" withString:@""];  // for new version
            NSString *originalPath =[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]  stringByAppendingPathComponent:@"Images"];
            NSString *localFilePath = [originalPath stringByAppendingPathComponent:imageName];
            BOOL isDir=[CommonStaticMethods directoryExistsAtAbsolutePath:[originalPath stringByAppendingPathComponent:@"profile.png"]];
            if(!isDir)
            {
                [[NSFileManager defaultManager]createDirectoryAtPath: originalPath withIntermediateDirectories: YES attributes: nil error: NULL];
            }
            BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:localFilePath];
            if (!fileExists)
            {
                NSURL *imageURL = [[[NSURL alloc] initWithString:profilePicURL]autorelease];            
                NSURLRequest *request = [NSURLRequest requestWithURL:imageURL];
                [NSURLConnection connectionWithRequest:request delegate:self];
                NSData *thedata = [NSData dataWithContentsOfURL:imageURL];
                [thedata writeToFile:localFilePath atomically:YES];
            }
            UIImage* image = [UIImage imageWithContentsOfFile:localFilePath];
            imgBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [imgBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            imgBtn.tag=i;
            if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
            { 
                imgBtn.frame= CGRectMake(imgX, imgY, 106, 106);
            }
            else
            {
                imgBtn.frame= CGRectMake(imgX, imgY, 75, 75);
            }
            imgBtn.layer.masksToBounds=YES;
            [self.tempScrollView addSubview:imgBtn];
            [self performSelectorOnMainThread:@selector(displayImage:) withObject:image waitUntilDone:YES];
            if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
            {
                if (self.interfaceOrientation==UIInterfaceOrientationPortrait || self.interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown)  
                {
                    colCount=6;
                }
                else
                {
                    colCount=8;
                }
                
                if ((i+1)%colCount==0)
                {
                    imgY=imgY + 122;
                    imgX=-100;
                }
                imgX+=124;
            }
            else 
            {
                colCount=4;
                if ((i+1)%colCount==0)
                {
                    imgY=imgY + 79;
                    imgX=-75;
                }
                imgX+=79;
            }
            tempScrollView.contentSize=CGSizeMake(320,(imgY+350)); 
        }
        else
        {
            break;
        }
    }
    
    if(![queue isSuspended]) 
    {
        [queue setSuspended:YES];
    }
    
    loadFlag=NO;
}

- (void)displayImage:(UIImage *)image 
{    
    imageView=[[UIImageView alloc]init];
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    { 
        imageView.frame=CGRectMake(0, 0, 106, 106);
    }
    else
    {
        imageView.frame=CGRectMake(0, 0, 75, 75);
    }
    imageView.image=image;
    [self.tempScrollView addSubview:imgBtn];
    [self.imgBtn addSubview:imageView];
}


#pragma mark View lifecycle

- (void)viewDidLoad
{
    
    [btnHome setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    loadFlag=NO;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    domain = [prefs stringForKey:@"URL"];
    
    segmentControl.segmentedControlStyle = UISegmentedControlStyleBar;
    segmentControl.frame = CGRectMake (10, 10, 300,35);
    UIColor *newTintColor = [UIColor colorWithRed: 175/255.0 green:175/255.0 blue:175/255.0 alpha:1.0];
    segmentControl.tintColor = newTintColor;
    UIColor *newSelectedTintColor = [UIColor colorWithRed: 175/255.0 green:175/255.0 blue:175/255.0 alpha:1.0];
    [[[segmentControl subviews] objectAtIndex:0] setTintColor:newSelectedTintColor];
    bookMarkFlag=NO;    
    OnlineFlag=NO;
    picFlag=YES;
    
    [tempScrollView setBackgroundColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redVal/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenVal/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueVal/255.0 alpha:1.0]];
    [navBar setTintColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavbar/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavbar/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavbar/255.0 alpha:1.0]];
    [toolBar  setTintColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavbar/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavbar/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavbar/255.0 alpha:1.0]];
    navBar.layer.borderColor=[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavBorder/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavBorder/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavBorder/255.0 alpha:1.0].CGColor;
    navBar.layer.borderWidth=1.0f;
    toolBar.layer.borderColor=[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavBorder/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavBorder/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavBorder/255.0 alpha:1.0].CGColor;
    toolBar.layer.borderWidth=1.0f;
    photoslab.font= ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontNavTitle;
    [photoslab setTextAlignment:UITextAlignmentCenter];
    photoslab.text=[NSString stringWithFormat:@"%@'s Profile",profileName];
   
    NSString *req = [NSString stringWithFormat:@"%@/mobile/ViewPhotos/?id=%@&vid=%@&skey=%@",domain,profileId,((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedSessionID];
    
    [JSWaiter ShowWaiter:self title:@"Loading..." type:0];
    [self performSelectorOnMainThread:@selector(WebRequest:) withObject:req waitUntilDone:NO];
    [super viewDidLoad];
    
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
        }
        else 
        {
            indicatorView.frame =CGRectMake((284+NewXval), 471, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30), 40);
        }
        
        if (!loadFlag)
        {
            [self ChangeImageOrientation];
        }
        
        return YES;
    }
    else
    {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    }*/
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
        NSDictionary *json = [[ret objectForKey:@"text"] JSONValue];
        
        if (bookMarkFlag)
        {
            bookMarkFlag=NO;
            NSString *bookMark=(NSString*)[parsedData objectForKey:@"Message"];
            //For checking session validation
            if([bookMark isEqualToString:@"Site suspended"])
            {
                ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Site suspended";
                UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Site suspended. Please try after sometime." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
                sessionAlertView.tag=1;
                [sessionAlertView show];
                [sessionAlertView release];
            }
            else if ([bookMark isEqualToString:@"Session Expired"])
            {
                ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Session Expired";
                UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Your session has expired. Please login again." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
                sessionAlertView.tag=1;
                [sessionAlertView show];
                [sessionAlertView release];
            }
            else if ([bookMark isEqualToString:@"Membership denied"]||[bookMark isEqualToString:@"Membership Denied"])
            {
                UIAlertView *MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Please upgrade your membership to bookmark  the profile." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [MembershipAlertView show];
                [MembershipAlertView release];
            }
            else if ((bookMark==(id)[NSNull null]) || [bookMark isEqualToString:@""] || [bookMark isEqualToString:@"0"])
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[@"Cannot bookmark the profile now. Please try after sometime." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
                [alertView release];
            }
            else if([bookMark isEqualToString:@"Already Bookmarked"])
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"You had already bookmarked this profile." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
                [alertView release];
                
            }
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[@"Successfully bookmarked the profile." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
                [alertView release];
            }
            [JSWaiter HideWaiter];
            return;
        }
        
        if (picFlag)
        {
            NSString *messegeStr=(NSString*)[parsedData objectForKey:@"Message"];
            //For checking session validation
            if([messegeStr isEqualToString:@"Site suspended"])
            {
                ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Site suspended";
                UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Site suspended. Please try after sometime." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
                sessionAlertView.tag=1;
                [sessionAlertView show];
                [sessionAlertView release];
            }
            else if ([messegeStr isEqualToString:@"Session Expired"])
            {
                ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Session Expired";
                UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Your session has expired. Please login again." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
                sessionAlertView.tag=1;
                [sessionAlertView show];
                [sessionAlertView release];
            }
            else if ([messegeStr isEqualToString:@"Membership denied"]||[messegeStr isEqualToString:@"Membership Denied"])
            {
                UIAlertView *MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Please upgrade your membership to view photos." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [MembershipAlertView show];
                [MembershipAlertView release];
            }
            else
            {
                NSString *resultCount = (NSString*)[parsedData objectForKey:@"count"];
                if ([resultCount intValue] == 0 )
                {
                    invocation= [NSInvocation invocationWithMethodSignature:
                                 [self methodSignatureForSelector: @selector(FetchProfilePhoto)]];
                    [invocation setTarget:self];
                    [invocation setSelector:@selector(FetchProfilePhoto)];
                    if (timer)
                    {
                        [timer invalidate];
                        timer = nil;
                    }
                    timer = [NSTimer scheduledTimerWithTimeInterval:10.0 invocation:invocation repeats:YES];
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"No photos found"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alertView show];
                    [alertView release];
                }
                else
                {
                    NSArray *picURLs = [json valueForKeyPath:@"result.Photo"];
                    thumbPicURLs=[[[NSMutableArray alloc] initWithArray:picURLs copyItems:YES] retain];
                    
                    [self performSelectorOnMainThread:@selector(loadDefaultImage) withObject:nil waitUntilDone:YES];
                    queue = [[NSOperationQueue alloc] init];
                    NSInvocationOperation *operation = [[NSInvocationOperation alloc] 
                                                        initWithTarget:self
                                                        selector:@selector(loadImage) 
                                                        object:nil];
                    [queue addOperation:operation]; 
                    [operation release];
                }
            }
        }
    }
    [JSWaiter HideWaiter];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error 
{    
	
	return;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{    
    
    
    
}


#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex 
{
        
    if (actionSheet.tag==1&&buttonIndex==0)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark IBActions

-(IBAction) clickedSegmentControllerSearchedSaved
{
	int selectedsegment=segmentControl.selectedSegmentIndex;
    if (selectedsegment==0) 
	{
        if (timer)
        {
            [timer invalidate];
            timer = nil;
        }
        [segmentControl setImage:[UIImage imageNamed:@"Info_tab_over.png"] forSegmentAtIndex:0];
        [segmentControl setImage:[UIImage imageNamed:@"Photos_tab.png"] forSegmentAtIndex:1];
        [self.navigationController popViewControllerAnimated:NO];
	}
	
}

-(IBAction)buttonAction:(id)sender
{
    UIButton *clickedBtnImage=(UIButton*)sender;
    PhotoFullView *objPhotoFullView=[[PhotoFullView alloc]initWithNibName:@"PhotoFullView" bundle:nil];
    objPhotoFullView.resultCount=[thumbPicURLs count];
    objPhotoFullView.imgURLs=thumbPicURLs;
    objPhotoFullView.imgIndex=clickedBtnImage.tag;
    objPhotoFullView.fromMyphotos=NO;
    [self.navigationController pushViewController:objPhotoFullView animated:YES];
    [objPhotoFullView release];
}

-(IBAction)clickedOnlineButton:(id) sender
{    
    if(![queue isSuspended]) 
    {
        [queue setSuspended:YES];
    }
    
    if (timer)
    {
        [timer invalidate];
        timer = nil;
    }
    
    if (backbtnimgId==1)
    {
        NSArray *viewControllers=[[self navigationController] viewControllers];
        for( int i=0;i<[ viewControllers count];i++)
        {
            id obj=[viewControllers objectAtIndex:i];
            if([obj isKindOfClass:[SearchResults class]] )
            {
                [[self navigationController] popToViewController:obj animated:YES];
                return;
            }
        }
    }
    else
    {
        NSArray *viewControllers=[[self navigationController] viewControllers];
        for( int i=0;i<[ viewControllers count];i++)
        {
            id obj=[viewControllers objectAtIndex:i];
            if([obj isKindOfClass:[OnlineMembers class]] )
            {
                [[self navigationController] popToViewController:obj animated:YES];
                return;
            }
            else if([obj isKindOfClass:[NewsFeedsController class]] )
            {
                [[self navigationController] popToViewController:obj animated:YES];
                return;
            }
            else if([obj isKindOfClass:[MyNeighboursSearchResults class]] )
            {
                [[self navigationController] popToViewController:obj animated:YES];
                return;
            }
        }
    }
}

-(IBAction)clickedChatButton:(id) sender
{   
    if (timer)
    {        
        [timer invalidate];
        timer = nil;
    }
    
    ChatMembersView *objChatMembersView=[[ChatMembersView alloc]initWithNibName:@"ChatMembersView" bundle:nil];
    objChatMembersView.receipientProfileId = profileId;
    objChatMembersView.receipientName = profileName;
    objChatMembersView.receipientProfilePic = photoimgstring;
    objChatMembersView.recipientgender = profilegenderId;
    [self.navigationController pushViewController:objChatMembersView animated:YES];
    [objChatMembersView release];
}

-(IBAction)clickedMailButton:(id) sender
{    
    ComposeMessageView *objComposeMessageView=[[ComposeMessageView alloc]initWithNibName:@"ComposeMessageView" bundle:nil];
    objComposeMessageView.selectedprofileid=(int)profileId;
    objComposeMessageView.profilenamestring=profileName;
    
    if ((photoimgstring == (id)[NSNull null])||([photoimgstring length] == 0)) 
    {
        
        UIImage *myimage=[[[UIImage alloc]init] autorelease];
        if ([profilegenderId intValue]==1) 
        {
            myimage =[UIImage imageNamed:@"women.png"];
        }
        else if ([profilegenderId intValue]==2) 
        {
            myimage =[UIImage imageNamed:@"man.png"];
        }
        else if ([profilegenderId intValue]==4) 
        {
            myimage =[UIImage imageNamed:@"man_women.png"];
        }
        else if ([profilegenderId intValue]==8)
        {
            myimage =[UIImage imageNamed:@"man_women_a.png"];
        }
        objComposeMessageView.userImage=myimage;
    }
    else
    {
        NSString *string=[NSString stringWithFormat:@"%@%@",domain,photoimgstring];
        NSData *mydata = [[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:string]] autorelease];
        UIImage *myimage = [[[UIImage alloc] initWithData:mydata] autorelease];
        objComposeMessageView.userImage=myimage;
    }
    
    objComposeMessageView.decision=YES;
    [self.navigationController pushViewController:objComposeMessageView animated:YES];
    [objComposeMessageView release];
    
}


-(IBAction)clickedBookmarkButton:(id) sender
{
    NSString *pid=(((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID);
    if ([pid isEqualToString:profileId]) 
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"you are not able to bookmark yourself. " description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return;
    }
    else
    {
        bookMarkFlag=YES;
        NSString *req = [NSString stringWithFormat:@"%@/mobile/Bookmark_Profile/?pid=%@&skey=%@&bid=%@",domain,(((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID),((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID ,profileId]; 
        [JSWaiter ShowWaiter:self title:@"Bookmarking..." type:0];
        [self performSelectorOnMainThread:@selector(WebRequest:) withObject:req waitUntilDone:NO];
    }
}

@end
