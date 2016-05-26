//
//  DetailedCommentViewController.m
//  Skadate
//
//  Created by Heinz Vallonthaiel on 8/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailedCommentViewController.h"
#import "JSON.h"


@implementation DetailedCommentViewController

@synthesize entityId;
@synthesize domain;
@synthesize respData;
@synthesize profilePics;
@synthesize thumbPicURLs;
@synthesize commentsTV;
@synthesize commentArray;
@synthesize NewXval;

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

#pragma mark Memory Management

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc
{    
    [profilePics release];
    [commentArray release];
    
    [super dealloc];
}

#pragma mark Custom Methods

-(void)ios6ipad{
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        
        if (([[UIDevice currentDevice] orientation])==UIInterfaceOrientationLandscapeRight||([[UIDevice currentDevice] orientation])==UIInterfaceOrientationLandscapeLeft)
        {
            
		}
        else
        {
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
-(NSString *)FormatTime:(NSString *)ServerTimeStr
{
    NSString *serverTime =ServerTimeStr;
    NSString * serverTimeZone=((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedTimeZone;
    NSString *TimeZoneName=[[NSTimeZone systemTimeZone] name];
    
    DisplayDateTime *objDisplayDateTime =[[DisplayDateTime alloc]init];
    NSString *result= [objDisplayDateTime CalculateTime:serverTime andServerTimeZone:serverTimeZone andDeviceTimeZone:TimeZoneName];
    [objDisplayDateTime release];
    return result;
}


#pragma mark - View lifecycle

-(void)viewDidAppear:(BOOL)animated
{    
    if (((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fromCommentView) 
    {    
        respData = [[NSMutableData data] retain];
    
        NSString *req = [NSString stringWithFormat:@"%@/mobile/News_Comment_View/?pid=%@&skey=%@&eid=%@",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID,entityId];
        
        [JSWaiter ShowWaiter:self title:@"Loading..." type:0];
        [self performSelectorOnMainThread:@selector(WebRequest:) withObject:req waitUntilDone:NO];
        self.view.userInteractionEnabled=NO;
    }
}


- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewDidLoad
{    
    [super viewDidLoad];
        
    [self.view setBackgroundColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redVal/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenVal/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueVal/255.0 alpha:1.0]];
    
    [navBar setTintColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavbar/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavbar/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavbar/255.0 alpha:1.0]];
    navBar.layer.borderColor=[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavBorder/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavBorder/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavBorder/255.0 alpha:1.0].CGColor;
    navBar.layer.borderWidth=1.0f;
    
    [toolBar setTintColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavbar/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavbar/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavbar/255.0 alpha:1.0]];
    toolBar.layer.borderColor=[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavBorder/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavBorder/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavBorder/255.0 alpha:1.0].CGColor;
    toolBar.layer.borderWidth=1.0f;
    
    navlbl.font= ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontNavTitle;
    
    [navlbl setTextAlignment:UITextAlignmentCenter];
    navlbl.text=@"Comments";
            
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    domain = [prefs stringForKey:@"URL"];
    
    respData = [[NSMutableData data] retain];

    NSString *req = [NSString stringWithFormat:@"%@/mobile/News_Comment_View/?pid=%@&skey=%@&eid=%@",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID,entityId];
    
    [JSWaiter ShowWaiter:self title:@"Loading..." type:0];
    [self performSelectorOnMainThread:@selector(WebRequest:) withObject:req waitUntilDone:NO];
    self.view.userInteractionEnabled=NO;

    // Do any additional setup after loading the view from its nib.
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
        }
        else
        {            
            indicatorView.frame =CGRectMake((284+NewXval), 471, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30), 40);
        }
        return YES;
        
    }
    else
    {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    }*/
}


#pragma mark Table View Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    
    return [commentArray count];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    return 100;
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
    
    if([commentArray count]==0)
    {
        return cell;
    }
    
    UIImageView *imgview=[[[UIImageView alloc]initWithFrame:CGRectMake(7, 10, 40, 40)] autorelease];
    imgview.layer.cornerRadius=3.0;
    imgview.layer.masksToBounds=YES;
    [cell addSubview:imgview];
    
    imgview.image=[UIImage imageNamed:@"ImageLoading.png"];
        
    // Lazy image loading         
    NSString *profilePicURL=[NSString stringWithFormat:@"%@%@",domain,[thumbPicURLs objectAtIndex:indexPath.row]];
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
            
            NSURL *imageURL = [[[NSURL alloc] initWithString:profilePicURL]autorelease];            
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
                                
                NSString *genderId=(NSString*)[(NSDictionary*)[commentArray objectAtIndex:indexPath.row] valueForKey:@"sex"];
               
                
                if((genderId== (id)[NSNull null])||(genderId==NULL)||([genderId isEqualToString:@""])||([genderId length]==0))
                {                                                      
                    imgview.image=[UIImage imageNamed:@"man.png"];
                    
                }
                else
                {                    
                    if ([genderId intValue]==1) 
                    {
                        imgview.image=[UIImage imageNamed:@"women.png"];
                    }
                    else if ([genderId intValue]==2) 
                    {
                        imgview.image=[UIImage imageNamed:@"man.png"];
                    }
                    else if ([genderId intValue]==4) 
                    {
                        imgview.image=[UIImage imageNamed:@"man_women.png"];
                    }
                    else if ([genderId intValue]==8) 
                    {
                        imgview.image=[UIImage imageNamed:@"man_women_a.png"];
                    }
                    else 
                    {
                        imgview.image=[UIImage imageNamed:@"man.png"];
                        
                    } 
                }
                
            }
            
        });
    });  
    dispatch_release(queue);

    
    UILabel *profileName=[[UILabel alloc]initWithFrame:CGRectMake(53, 4, 220, 20)];
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        profileName.frame=CGRectMake(53, 10, 500, 25);
    }
    else
    {
        profileName.frame=CGRectMake(53, 10, 220, 25);
    }
    
    NSString *profileNamestr=(NSString*)[(NSDictionary*)[commentArray objectAtIndex:indexPath.row] valueForKey:@"username"];
    profileName.text=profileNamestr;
    [profileName setTextColor:[UIColor blueColor]];
    profileName.font=[UIFont fontWithName:@"Ubuntu-Bold" size:15];
    [cell addSubview:profileName];
    [profileName release];
    
    UILabel *time_lbl=[[UILabel alloc]initWithFrame:CGRectMake(53, 30, 150, 20)];
    NSString *time_lbl_str=(NSString*)[(NSDictionary*)[commentArray objectAtIndex:indexPath.row] valueForKey:@"create_time"];
    time_lbl.text=[self FormatTime:time_lbl_str];
    [time_lbl setTextColor:[UIColor blackColor]];
    time_lbl.font=[UIFont fontWithName:@"Ubuntu" size:12];
    [cell addSubview:time_lbl];
    [time_lbl release];

    UITextView *commentDet=[[UITextView alloc]initWithFrame:CGRectMake(7, 49, 220, 43)];
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        commentDet.frame=CGRectMake(7, 49, 500, 43);
    }
    else
    {
        commentDet.frame=CGRectMake(7, 49, 306, 43);
    }
    NSString *commentStr;
    
    if (((NSString*)[(NSDictionary*)[commentArray objectAtIndex:indexPath.row] valueForKey:@"text"]==(id)[NSNull null])||((NSString*)[(NSDictionary*)[commentArray objectAtIndex:indexPath.row] valueForKey:@"text"]==NULL))
    {
        commentStr=@"";
    }
    else
    {
        commentStr=(NSString*)[(NSDictionary*)[commentArray objectAtIndex:indexPath.row] valueForKey:@"text"];
    }
    
    commentDet.editable=NO;
    commentDet.text=commentStr;
    [commentDet setTextColor:[UIColor blackColor]];
    commentDet.font=[UIFont fontWithName:@"Ubuntu" size:13];
    [cell addSubview:commentDet];
    [commentDet release];
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
                
    NSString *profileId=(NSString*)[(NSDictionary*)[commentArray objectAtIndex:indexPath.row] valueForKey:@"profile_id"];
    
    if([((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID isEqualToString:profileId])
    {
    }
    else
    {
        ProfileView *objProfileView=[[ProfileView alloc]initWithNibName:@"ProfileView" bundle:nil];
        objProfileView.profileID=profileId;
               
        [self.navigationController pushViewController:objProfileView animated:YES];
        [objProfileView release];
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
		self.view.userInteractionEnabled=YES;
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Connection failed...Please launch the application again." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
    else
    {
        NSDictionary *parsedData = (NSDictionary *)[ret objectForKey:@"data"];
        NSDictionary* json = [[ret objectForKey:@"text"] JSONValue];
        self.view.userInteractionEnabled=YES;
        
        profilePics=[[NSMutableArray alloc]init];
        commentArray=[[NSMutableArray alloc]init];        
        {
            NSString *messageStr=(NSString*)[parsedData objectForKey:@"Message"];
            if([messageStr isEqualToString:@"Site suspended"])
            {
                
                ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Site suspended";
                
                UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Site suspended. Please try after sometime." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
                sessionAlertView.tag=1;
                [sessionAlertView show];
                [sessionAlertView release];
                return;
                
            }
            else if ([messageStr isEqualToString:@"Session Expired"])
            {
                ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Session Expired";
                
                UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Your session has expired. Please login again." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
                sessionAlertView.tag=1;
                [sessionAlertView show];
                [sessionAlertView release];
                return;
                
            }
            else if ([messageStr isEqualToString:@"Membership Denied"])
            {
                UIAlertView *MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Please upgrade your membership." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [MembershipAlertView show];
                [MembershipAlertView release];
                return;
                
            }
            
            NSString *resultCount = (NSString*)[parsedData objectForKey:@"count"];
            
            if ([resultCount intValue] == 0 )
            {
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:[@"No Comments found." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
                [alertView release];
            }
            else
            {
                
                NSArray *newsFeedComments = [json valueForKeyPath:@"result"];
                commentArray=[newsFeedComments copy];
                NSArray *picURLs = [json valueForKeyPath:@"result.Profile_Pic"];
                
                thumbPicURLs=[[NSMutableArray alloc] initWithArray:picURLs copyItems:YES];
                [commentsTV reloadData];
                
            }
        }
    }
    [JSWaiter HideWaiter];
}

#pragma mark IBActions

-(IBAction)clickedCommentButton:(id)sender
{    
    NewsFeedCommentViewController *objcommentView=[[NewsFeedCommentViewController alloc]initWithNibName:@"NewsFeedCommentViewController" bundle:nil];
    objcommentView.entityId=entityId;
    [self.navigationController presentModalViewController:objcommentView animated:YES];
    [objcommentView release];

    
}

-(IBAction)clickedBackButton:(id)sender
{    
    if(queue)
    {
        dispatch_suspend(queue);
    }

    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark AlertView delegate

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{    
    if(actionSheet.tag==1&&buttonIndex==0)
    {        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
    
}


@end
