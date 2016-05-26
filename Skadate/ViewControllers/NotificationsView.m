//
//  NotificationsView.m
//  Skadate
//
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NotificationsView.h"
#import "SkadateAppDelegate.h"
#import "ChatMembersView.h"
#import "MailBoxView.h"
#import "HomeView.h"
#import "JSON.h"
#import "CommonStaticMethods.h"


#define REFRESH_HEADER_HEIGHT 52.0f


@implementation NotificationsView

@synthesize lblNotifications;
@synthesize btnClose, chatMsgIdArray,chatSenderId,chatReciepientId,table,messageTimeArray,urlReq,msgIdArray,senderId,reciepientId,chatNameArray,chatImageArray,chatTextArray,messageText,messageImageArray,messageNameArray,chatImg,msgImg;
@synthesize navBar;
@synthesize NameArray;
@synthesize typeChat;
@synthesize ImageArray,domain;
@synthesize chatgenderarray,msggenderarray;
@synthesize lblOfName,lblOfMsg,lblOfTime;
@synthesize kissImageView, kissesImagesArray,msgSubjectArray,lblOfSub;
@synthesize  NewXval;

// pull down refresh.........//
@synthesize textPull, textRelease, textLoading, refreshHeaderView, refreshLabel, refreshArrow, refreshSpinner;


#pragma mark Memory Management

- (void)dealloc
{
    [super dealloc];
    [kissesImagesArray release];
    [msgSubjectArray release];

}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark Custom Methods

-(void)ios6ipad{
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        if (([[UIDevice currentDevice] orientation])==UIInterfaceOrientationLandscapeRight||([[UIDevice currentDevice] orientation])==UIInterfaceOrientationLandscapeLeft)
        {
            [lblOfName setFrame:CGRectMake(60,15, 300,20)];
            [lblOfTime setFrame:CGRectMake(880,22, 60,15)];
            [lblOfMsg setFrame:CGRectMake(60,35, 600,15)];
            kissImageView.frame=CGRectMake(50, 300, 35, 20);
		}
        else
        {
            [lblOfName setFrame:CGRectMake(60,15, 300,20)];
            [lblOfTime setFrame:CGRectMake(630,22, 60,15)];
            [lblOfMsg setFrame:CGRectMake(60,35, 500,15)];
            kissImageView.frame=CGRectMake(50, 380, 35, 20);
            
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


#pragma mark Custom Methods For Pull To Refresh

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
    // Refresh action!
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
    chatItemCount=0;
    mailItemCount=0;
    chatImg=[[NSMutableArray alloc]init];
    msgImg=[[NSMutableArray alloc]init];
    chatgenderarray=[[NSMutableArray alloc]init];
    msggenderarray=[[NSMutableArray alloc]init];
    chatImageArray=[[NSMutableArray alloc]init];
    messageImageArray=[[NSMutableArray alloc]init];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    domain = [prefs stringForKey:@"URL"];
    urlReq =[NSString stringWithFormat:@"%@/mobile/Notification/?pid=%@&skey=%@",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID];
    [self performSelectorOnMainThread:@selector(WebRequest:) withObject:urlReq waitUntilDone:NO];
    self.view.userInteractionEnabled=NO;    
}


-(NSString *)FormatTime:(NSString *)ServerTimeStr
{
    NSString *serverTime =ServerTimeStr;
    NSString * serverTimeZone=((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedTimeZone;
    NSString *TimeZoneName=[[NSTimeZone systemTimeZone] name];
    DisplayDateTime *objDisplayDateTime =[[DisplayDateTime alloc]init];
    NSString *result= [objDisplayDateTime ConvertTime:serverTime andServerTimeZone:serverTimeZone andDeviceTimeZone:TimeZoneName];
    [objDisplayDateTime release];
    return result;
}


#pragma mark ScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (isLoading) return;
    isDragging = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
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
    [self.view setBackgroundColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redVal/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenVal/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueVal/255.0 alpha:1.0]];
    [navBar setTintColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavbar/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavbar/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavbar/255.0 alpha:1.0]];

    navBar.layer.borderColor=[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavBorder/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavBorder/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavBorder/255.0 alpha:1.0].CGColor;
    navBar.layer.borderWidth=1.0f;
    lblNotifications.font= ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontNavTitle;
    NSString *resultCount=@"";
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *chat=[NSString stringWithFormat:@"%@",((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedNotifications];
    NSString *trimmed1 = [chat stringByTrimmingCharactersInSet:whitespace];
    
    if ([trimmed1 isEqualToString:@"(null)"]||[trimmed1 isEqualToString:@""]||(trimmed1 == (id)[NSNull null])||([trimmed1 length] == 0)||(trimmed1==NULL))
    {
        resultCount= [NSString stringWithFormat:@"%@",@"0"];
    }
    else
    {
        resultCount = [NSString stringWithFormat:@"%@ Notifications", ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedNotifications];
    }
    
    if (resultCount == (id)[NSNull null])
    {
        lblNotifications.text = [NSString stringWithFormat:@"%@ Notifications", @"0"];
    }
    else
    {
        lblNotifications.text = [NSString stringWithFormat:@"%d Notifications", chatItemCount];
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    domain = [prefs stringForKey:@"URL"];
    kissesImagesArray=[[NSMutableArray alloc]init ];
   
    for (int j=1; j<=24; j++) 
    {
        UIImage *kiss=[UIImage imageNamed:[NSString stringWithFormat:@"kiss%d.png",j]];
        [kissesImagesArray addObject:kiss];
    }
    
    urlReq =[NSString stringWithFormat:@"%@/mobile/Notification/?pid=%@&skey=%@",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID];
    [JSWaiter ShowWaiter:self title:@"Loading..." type:0];
    [self performSelectorOnMainThread:@selector(WebRequest:) withObject:urlReq waitUntilDone:NO];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

/*- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if (interfaceOrientation==UIInterfaceOrientationLandscapeRight||interfaceOrientation==UIInterfaceOrientationLandscapeLeft)
        {
            indicatorView.frame =CGRectMake((412+NewXval), 344, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30), 40);
            [lblOfName setFrame:CGRectMake(60,15, 300,20)];
            [lblOfTime setFrame:CGRectMake(880,22, 60,15)];
            [lblOfMsg setFrame:CGRectMake(60,35, 600,15)];
            kissImageView.frame=CGRectMake(50, 300, 35, 20);
        }
        else
        {
            indicatorView.frame =CGRectMake((284+NewXval), 471, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30), 40);
            [lblOfName setFrame:CGRectMake(60,15, 300,20)];
            [lblOfTime setFrame:CGRectMake(630,22, 60,15)];
            [lblOfMsg setFrame:CGRectMake(60,35, 500,15)];
            kissImageView.frame=CGRectMake(50, 380, 35, 20);
        }
        return YES;
    }
    else
    {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    }
}*/


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
        NSDictionary *json = [[ret objectForKey:@"data"] JSONValue];
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
        else if([messegeStr isEqualToString:@"Membership denied"]||[messegeStr isEqualToString:@"Membership Denied"])
        {
            UIAlertView * MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Please upgrade your membership to view notifications." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [MembershipAlertView show];
            [MembershipAlertView release];
            return;
        }
        
        NSString *resultCount = (NSString*)[parsedData objectForKey:@"IMCount"];
        
        if ([resultCount intValue] == 0 )
        {
            chatItemCount=0;
            mailItemCount=0;
            [self stopLoading];
            lblNotifications.text = [NSString stringWithFormat:@"%@ Notifications", @"0"];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:[@"No notifications found." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
        }
        else
        {
            lblNotifications.text = [NSString stringWithFormat:@"%@ Notifications", resultCount];
            NSString *chatCount = (NSString*)[parsedData objectForKey:@"IMCount"];
            NSString *mailCount = (NSString*)[parsedData objectForKey:@"MailCount"];
            chatItemCount=[chatCount intValue];
            mailItemCount=[mailCount intValue];
            chatImg=[[NSMutableArray alloc]init];
            msgImg=[[NSMutableArray alloc]init];
            chatgenderarray=[[NSMutableArray alloc]init];
            msggenderarray=[[NSMutableArray alloc]init];
            chatImageArray=[[NSMutableArray alloc]init];
            messageImageArray=[[NSMutableArray alloc]init];
            NSArray *chatMsgId = [json valueForKeyPath:@"result.im_message_id"];
            chatMsgIdArray=[[NSMutableArray alloc] initWithArray:chatMsgId copyItems:YES];
            NSArray *chatSendId = [json valueForKeyPath:@"result.im_sender_id"];
            chatSenderId=[[NSMutableArray alloc] initWithArray:chatSendId copyItems:YES];
            NSArray *chatRecieptId = [json valueForKeyPath:@"result.im_recipient_id"];
            chatReciepientId=[[NSMutableArray alloc] initWithArray:chatRecieptId copyItems:YES];
            NSArray *chatName = [json valueForKeyPath:@"result.im_username"];
            chatNameArray=[[NSMutableArray alloc] initWithArray:chatName copyItems:YES];
            NSArray *chatText = [json valueForKeyPath:@"result.im_text"];
            chatTextArray=[[NSMutableArray alloc] initWithArray:chatText copyItems:YES];
            NSArray *msgId = [json valueForKeyPath:@"result.message_id"];
            msgIdArray=[[NSMutableArray alloc] initWithArray:msgId copyItems:YES];
            NSArray *sender = [json valueForKeyPath:@"result.sender_id"];
            senderId=[[NSMutableArray alloc] initWithArray:sender copyItems:YES];
            NSArray *reciepient = [json valueForKeyPath:@"result.recipient_id"];
            reciepientId=[[NSMutableArray alloc] initWithArray:reciepient copyItems:YES];
            NSArray *messageTxt = [json valueForKeyPath:@"result.text"];
            messageText=[[NSMutableArray alloc] initWithArray:messageTxt copyItems:YES];
            NSArray *messageName = [json valueForKeyPath:@"result.username"];
            messageNameArray=[[NSMutableArray alloc] initWithArray:messageName copyItems:YES];
            NSArray *msgSub = [json valueForKeyPath:@"result.subject"];
            msgSubjectArray=[[NSMutableArray alloc] initWithArray:msgSub copyItems:YES];
            NSArray *messageTime = [json valueForKeyPath:@"result.time_stamp"];
            messageTimeArray=[[NSMutableArray alloc] initWithArray:messageTime copyItems:YES];
            NSArray *chatImage = [json valueForKeyPath:@"result.im_Profile_Pic"];
            [chatImageArray addObjectsFromArray:chatImage];
            NSArray *chatgender=[json valueForKeyPath:@"result.im_sex"];
            [chatgenderarray addObjectsFromArray:chatgender];
            NSArray *msggender=[json valueForKeyPath:@"result.msg_sex"];
            [msggenderarray addObjectsFromArray:msggender];
            NSArray *messageImage = [json valueForKeyPath:@"result.Profile_Pic"];
            [messageImageArray addObjectsFromArray:messageImage];
        }
        [table reloadData];
    }
    [self stopLoading];
    [JSWaiter HideWaiter];
}

#pragma mark IBAction

-(IBAction)clickedCloseButton:(id) sender
{
    if(queue)
    {
        dispatch_suspend(queue);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark TableView Delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return chatItemCount;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Create
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell;
    cell = nil;
   
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UIImageView *imgview=[[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)] autorelease];
    [cell addSubview:imgview];
    imgview.layer.cornerRadius=8.0;
    imgview.layer.masksToBounds=YES;
    imgview.layer.borderColor = [UIColor lightGrayColor].CGColor;
    imgview.layer.borderWidth = 1.0;
    
    if (indexPath.section==0) 
    {
        if(chatItemCount<=0)
        {
            return cell;
        }
        
        imgview.image=[UIImage imageNamed:@"ImageLoading.png"];
        
        // Lazy image loading         
        NSString *profilePicURL=[NSString stringWithFormat:@"%@%@",domain,[chatImageArray objectAtIndex:indexPath.row]];
        NSString *imageName=[NSString stringWithFormat:@"%@",[chatImageArray objectAtIndex:indexPath.row]];
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
                    if([chatgenderarray count]>0)
                    {
                        if ( ([chatgenderarray objectAtIndex:indexPath.row] == (id)[NSNull null])
                            || ([chatgenderarray objectAtIndex:indexPath.row] == NULL)
                            || ([[chatgenderarray objectAtIndex:indexPath.row] isEqual:@""])
                            || ([[chatgenderarray objectAtIndex:indexPath.row] length] == 0) )
                        {
                            imgview.image=[UIImage imageNamed:@"man.png"];
                        }
                        else
                        {
                            if ([[chatgenderarray objectAtIndex:indexPath.row] intValue]==1) 
                            {
                                imgview.image=[UIImage imageNamed:@"women.png"];
                            }
                            else if ([[chatgenderarray objectAtIndex:indexPath.row] intValue]==2) 
                            {
                                imgview.image=[UIImage imageNamed:@"man.png"];
                            }
                            else if ([[chatgenderarray objectAtIndex:indexPath.row] intValue]==4) 
                            {
                                imgview.image=[UIImage imageNamed:@"man_women.png"];
                            }
                            else if ([[chatgenderarray objectAtIndex:indexPath.row] intValue]==8) 
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
        
        UIImageView *imgview1=[[[UIImageView alloc]initWithFrame:CGRectMake(125, 5, 190, 50)] autorelease];
        imgview1.image=[UIImage imageNamed:@"dialog_box_left_arrow.png"];
        [cell addSubview:imgview1];
        CGRect frameName =CGRectMake(60,10, 60,20 );
        UILabel *lblOfNamechat=[[UILabel alloc]initWithFrame:frameName];
       
        if ([chatNameArray objectAtIndex:indexPath.row]== (id)[NSNull null]) 
        {
            lblOfNamechat.text=@"";
        }
        else 
        {
            lblOfNamechat.text=[chatNameArray objectAtIndex:indexPath.row];
        }
        
        lblOfNamechat.font=[UIFont fontWithName:@"Ubuntu-Bold" size:15];
        lblOfNamechat.textColor =[UIColor blackColor]; 
        lblOfNamechat.textAlignment=UITextAlignmentLeft;
        [ cell addSubview: lblOfNamechat];
        [lblOfNamechat release];
        CGRect frameName1 =CGRectMake(140,22, 150,20 );
        UILabel *lblOfText=[[UILabel alloc]initWithFrame:frameName1];
        
        if ([chatTextArray objectAtIndex:indexPath.row]== (id)[NSNull null])
        {
            lblOfText.text=@"";
        }
        else
        {
            lblOfText.text=[chatTextArray objectAtIndex:indexPath.row];
        }
        
        lblOfText.font=[UIFont fontWithName:@"Ubuntu-Bold" size:15];
        lblOfText.textColor =[UIColor colorWithRed:98/255.0 green:96/255.0 blue:96/255.0 alpha:1.0];
        lblOfText.textAlignment=UITextAlignmentLeft;
        lblOfText.backgroundColor=[UIColor clearColor];
        [ cell addSubview: lblOfText];
        [lblOfText release];
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    if (indexPath.section==0) 
    {
        ChatMembersView *objChatMembersView =[[ChatMembersView alloc]initWithNibName:@"ChatMembersView" bundle:nil];
        objChatMembersView.receipientProfileId = [chatSenderId objectAtIndex:indexPath.row];
        objChatMembersView.receipientName = [chatNameArray objectAtIndex:indexPath.row];
        objChatMembersView.receipientProfilePic = [chatImageArray objectAtIndex:indexPath.row];
        objChatMembersView.recipientgender=[chatgenderarray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:objChatMembersView animated:YES];
        [objChatMembersView release];
    }
}

#pragma mark AlertView Delegate

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==1&&buttonIndex==0)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}


@end
