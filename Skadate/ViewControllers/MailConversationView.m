//
//  MailConversationView.m
//  Skadate
//
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MailConversationView.h"
#import "SkadateAppDelegate.h"
#import "JSON.h"
#import "ReplyMessageView.h"
#import "MailBoxView.h"
#import "MessageView.h"
#import "CommonStaticMethods.h"


@implementation MailConversationView

@synthesize  table,messageViewLabel,nameArray,messageId,senderId,messageContentArray,timeArray,urlReq,messageID,senderID,btnReply,btnDelete,btnMailBox,btnBookMark,subject,conversNum,conversationNom,previousBut,lblOfTxt,thumbPicURLs,imageArr,domain;

@synthesize navBar;
@synthesize toolBar;
@synthesize segmentCtrl;
@synthesize rootConIDArray;
@synthesize rootConNumArray;
@synthesize rootMsgIDArray;
@synthesize index,congenderArray;
@synthesize NewXval;

#pragma mark Memory Management

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc
{
    dispatch_release(queue);
    [super dealloc];
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

-(NSString *)FormatTime:(NSString *)ServerTimeStr
{
    NSString *serverTime =ServerTimeStr;
    NSString * serverTimeZone=((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedTimeZone;
    NSString *TimeZoneName=[[NSTimeZone systemTimeZone] name];
    
    DisplayDateTime *objDisplayDateTime =[[DisplayDateTime alloc]init];
    NSString *result= [objDisplayDateTime ConvertDateTime:serverTime andServerTimeZone:serverTimeZone andDeviceTimeZone:TimeZoneName];
    [objDisplayDateTime release];
    return result;
}

-(void)loadData
{    
    urlReq =[NSString stringWithFormat:@"%@/mobile/Conversation_Details/?id=%@&pid=%@&skey=%@",domain,messageID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedSessionID];
   
    [JSWaiter ShowWaiter:self title:@"Loading..." type:0];
    [self performSelectorOnMainThread:@selector(WebRequest:) withObject:urlReq waitUntilDone:NO];
    
}

#pragma mark View lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    
    setButtonFlag=YES;
    btnMailBox.enabled=NO;
    btnBookMark.enabled=NO;
    btnReply.enabled=NO;
    btnDelete.enabled=NO;
    segmentCtrl.enabled=NO;
    bookmarkFlag=NO;
    deleteFlag=NO;
    segmentCtrl.momentary = YES;
    
    queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    
    [self.view setBackgroundColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redVal/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenVal/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueVal/255.0 alpha:1.0]];
    
    [navBar setTintColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavbar/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavbar/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavbar/255.0 alpha:1.0]];
    [toolBar setTintColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavbar/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavbar/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavbar/255.0 alpha:1.0]];
    navBar.layer.borderColor=[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavBorder/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavBorder/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavBorder/255.0 alpha:1.0].CGColor;
    navBar.layer.borderWidth=1.0f;
    
    toolBar.layer.borderColor=[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavBorder/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavBorder/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavBorder/255.0 alpha:1.0].CGColor;
    toolBar.layer.borderWidth=1.0f;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    domain = [prefs stringForKey:@"URL"];
    fromInbox=[prefs boolForKey:@"Inbox"];
    
    if (fromInbox) 
    {
        btnReply.hidden=NO;
        btnBookMark.hidden=NO;
    }
    else
    {        
        btnReply.hidden=YES;
        btnBookMark.hidden=YES;
    }
    
    conversationNom.font= ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontNavTitle;
    [conversationNom setTextAlignment:UITextAlignmentCenter];
    conversationNom.text=[NSString stringWithFormat:@"%@ Messages",conversNum];
    
    [self loadData];
         
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
		btnMailBox.enabled=YES;
        btnBookMark.enabled=YES;
        btnReply.enabled=YES;
        btnDelete.enabled=YES;
        segmentCtrl.enabled=YES;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Connection failed...Please launch the application again." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
    else
    {
        NSDictionary *parsedData = (NSDictionary *)[ret objectForKey:@"data"];
        NSDictionary* json = [[ret objectForKey:@"text"] JSONValue];
        btnMailBox.enabled=YES;
        btnBookMark.enabled=YES;
        btnReply.enabled=YES;
        btnDelete.enabled=YES;
        segmentCtrl.enabled=YES;
        if(!parsedData)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to retrieve data from the site. Please try after sometime." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            if (bookmarkFlag)
            {
                bookmarkFlag=NO;
            }
            
            if (deleteFlag)
            {
                deleteFlag=NO;
            }
            
            [alertView show];
            [alertView release];
            [JSWaiter HideWaiter];
            return;
        }
        
        if (bookmarkFlag)
        {
            NSString *bookMark=(NSString*)[parsedData objectForKey:@"Message"];
            
            if([bookMark isEqualToString:@"Site suspended"])
            {
                ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Site suspended";
                
                UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Site suspended. Please try after sometime." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
                sessionAlertView.tag=2;
                [sessionAlertView show];
                [sessionAlertView release];
                [JSWaiter HideWaiter];
                return;
            }
            else if ([bookMark isEqualToString:@"Session Expired"])
            {
                bookmarkFlag=NO;
                ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Session Expired";
                
                UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Your session has expired. Please login again." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
                sessionAlertView.tag=2;
                [sessionAlertView show];
                [sessionAlertView release];
                return;
                
            }
            else if([bookMark isEqualToString:@"Membership denied"]||[bookMark isEqualToString:@"Membership Denied"])
            {
                UIAlertView *MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Please upgrade your membership to bookmark the profile." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [MembershipAlertView show];
                [MembershipAlertView release];
                return;
                
            }
            else if ([bookMark isEqualToString:@"Bookmarked"])
            {
                bookmarkFlag=NO;
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[@"Successfully bookmarked the profile." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
                [alertView release];
                
            }
            else if([bookMark isEqualToString:@"Error"])
            {
                bookmarkFlag=NO;
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Failed to bookmark profile, please try again" description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
                [alertView release];
                
            }
            else if([bookMark isEqualToString:@"Already Bookmarked"])
            {
                bookmarkFlag=NO;
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"You had already bookmarked this profile." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
                [alertView release];
                
            }
            
        }
        else if (deleteFlag)
        {
            [JSWaiter HideWaiter];
            deleteFlag=NO;
            NSString *delete=(NSString*)[parsedData objectForKey:@"Message"];
            if([delete isEqualToString:@"Site suspended"])
            {
                ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Site suspended";
                
                UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Site suspended. Please try after sometime." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
                sessionAlertView.tag=2;
                [sessionAlertView show];
                [sessionAlertView release];
                return;
            }
            else if ([delete isEqualToString:@"Session Expired"])
            {
                ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Session Expired";
                
                UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Your session has expired. Please login again." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
                sessionAlertView.tag=2;
                [sessionAlertView show];
                [sessionAlertView release];
                return;
                
            }
            else if ([delete isEqualToString:@"Membership denied"]||[delete isEqualToString:@"Membership Denied"])
            {
                UIAlertView *MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Please upgrade your membership to delete the messages." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [MembershipAlertView show];
                [MembershipAlertView release];
                return;
                
            }
            else if ([delete isEqualToString:@"Success"])
            {
                deleteFlag=NO;
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[@"Successfully deleted the messages." description] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alertView.tag=1;
                [alertView show];
                [alertView release];
                
            }
            else if ([delete isEqualToString:@"Error"])
            {
                deleteFlag=NO;
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Failed to delete the message, try again." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
                [alertView release];
                
            }
            
        }
        else
        {
            imageArr=[[NSMutableArray alloc]init];
            
            NSString *messegeStr=(NSString*)[parsedData objectForKey:@"Message"];
            NSString *resultCount = (NSString*)[parsedData objectForKey:@"count"];
            
            if([messegeStr isEqualToString:@"Site suspended"])
            {
                ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Site suspended";
                
                UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Site suspended. Please try after sometime." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
                sessionAlertView.tag=2;
                [sessionAlertView show];
                [sessionAlertView release];
                [JSWaiter HideWaiter];
                return;
                
            }
            else if ([messegeStr isEqualToString:@"Session Expired"])
            {
                ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Session Expired";
                
                UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Your session has expired. Please login again." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
                sessionAlertView.tag=2;
                [sessionAlertView show];
                [sessionAlertView release];
                [JSWaiter HideWaiter];
                return;
                
            }
            else if ([messegeStr isEqualToString:@"Membership denied"]||[messegeStr isEqualToString:@"Membership Denied"])
            {
                UIAlertView *MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Please upgrade your membership to view the mails." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [MembershipAlertView show];
                [MembershipAlertView release];
                [JSWaiter HideWaiter];
                return;
                
            }
            else if([resultCount intValue]==0)
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"No messages found"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
                [alertView release];
                
            }
            else
            {
                conversationNom.text=[NSString stringWithFormat:@"%@ Messages",resultCount];
                NSArray *senderIds = [json valueForKeyPath:@"result.sender_id"];
                senderId=[[NSMutableArray alloc] initWithArray:senderIds copyItems:YES];
                
                NSArray *messageIds = [json valueForKeyPath:@"result.message_id"];
                messageId=[[NSMutableArray alloc] initWithArray:messageIds copyItems:YES];
                
                NSArray *messageSubjectInfo = [json valueForKeyPath:@"result.subject"];
                subject=[[NSMutableArray alloc] initWithArray:messageSubjectInfo copyItems:YES];
                
                NSArray *messageContentArrayInfo = [json valueForKeyPath:@"result.text"];
                messageContentArray=[[NSMutableArray alloc] initWithArray:messageContentArrayInfo copyItems:YES];
                
                NSArray *timeArrayInfo = [json valueForKeyPath:@"result.Time"];
                timeArray=[[NSMutableArray alloc] initWithArray:timeArrayInfo copyItems:YES];
                
                NSArray *nameArr = [json valueForKeyPath:@"result.username"];
                nameArray=[[NSMutableArray alloc] initWithArray:nameArr copyItems:YES];
                
                NSArray *genderArray = [json valueForKeyPath:@"result.sex"];
                congenderArray=[[NSMutableArray alloc] initWithArray:genderArray copyItems:YES];
                
                NSArray *picURLs = [json valueForKeyPath:@"result.Profile_Pic"];
                thumbPicURLs=[[[NSMutableArray alloc] initWithArray:picURLs copyItems:YES] retain];
                
                messageViewLabel.text=[subject objectAtIndex:0];
                
            }
        }
        
        [table reloadData];
    }
    [JSWaiter HideWaiter];
}


#pragma mark Alert View Delegates

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex 
{
    
    if (actionSheet.tag==1) 
    {
        if (buttonIndex == 0)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else if (actionSheet.tag==2&&buttonIndex==0) 
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else if (actionSheet.tag==3&&buttonIndex==0) 
    {        
        deleteFlag=YES;
        NSString *req = [NSString stringWithFormat:@"%@/mobile/DeleteConversationNew/?pid=%@&cid=%@&skey=%@",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,messageID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID]; 
        
        [JSWaiter ShowWaiter:self title:@"Deleting..." type:0];
        [self performSelectorOnMainThread:@selector(WebRequest:) withObject:req waitUntilDone:NO];
        
    }
    else if(actionSheet.tag==4 && buttonIndex==0)
    {    
        bookmarkFlag=YES;
                
        NSString *req = [NSString stringWithFormat: @"%@/mobile/Bookmark_Profile/?pid=%@&skey=%@&bid=%@",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedSessionID,senderID];
        
        [JSWaiter ShowWaiter:self title:@"Bookmarking..." type:0];
        [self performSelectorOnMainThread:@selector(WebRequest:) withObject:req waitUntilDone:NO];
            
    }
    
}

#pragma mark IBActions

-(IBAction)clickedMailboxButton:(id) sender
{      
    if(queue)
    {
        dispatch_suspend(queue);
    }
        
    NSArray *viewControllers=[[self navigationController] viewControllers];
    for( int i=0;i<[ viewControllers count];i++)
    {
        id obj=[viewControllers objectAtIndex:i];
        if([obj isKindOfClass:[MailBoxView class]] )
        {            
            [[self navigationController] popToViewController:obj animated:YES];
            return;
        }
    }
    
}

-(IBAction)clickedBookMarkButton:(id) sender
{        
    NSString *pid=((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID;
    
    if ([pid isEqualToString:senderID]) 
    {                
        UIAlertView *bookmarkselfAlert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"you are not able to bookmark yourself."  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [ bookmarkselfAlert show];
        [bookmarkselfAlert release];
        
    } 
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Are you sure! You want to bookmark this profile?"  delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
    
        [alertView show];
        alertView.tag=4;
        [alertView release];
    }
    
    
}

-(IBAction)clickedReplyButton:(id) sender
{       
    ReplyMessageView *objReplyFromMessage=[[ReplyMessageView alloc]initWithNibName:@"ReplyMessageView" bundle:nil];
    objReplyFromMessage.messageTextView=[messageContentArray objectAtIndex:0];
    objReplyFromMessage.rplyMessageTxt=[subject objectAtIndex:0];
    objReplyFromMessage.mesageId=[rootMsgIDArray objectAtIndex:index];
    [self.navigationController pushViewController:objReplyFromMessage animated:NO];
    [objReplyFromMessage release];
    
}

-(IBAction)clickedDeleteButton:(id) sender
{      
    UIAlertView *deleteAlert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Are you sure you want to delete?"  delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel",nil];
    
    deleteAlert.tag = 3;
    [deleteAlert show];
    [deleteAlert release];    
}


#pragma mark clickedSegmentContol

-(IBAction) clickedSegmentContol
{
	int selectedsegment=segmentCtrl.selectedSegmentIndex;
	
	if (selectedsegment==0) 
    {       
        index--;
        if (index<0) 
        {
            index=0;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[@"You have reached the first message." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
            return;
        }
        
    }
    
    if (selectedsegment==1)
    {
        index++;
        if (index>=[rootMsgIDArray count]) 
        {
            index=[rootMsgIDArray count]-1;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[@"You have reached the last message." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
            return;
        }
        
    }

    if ([[rootConNumArray objectAtIndex:index] isEqualToString:@"0"] || [[rootConNumArray objectAtIndex:index] isEqualToString:@"1"]) 
    {
        
        NSString *mesgId=[rootMsgIDArray objectAtIndex:index];
              
        MessageView *objMessageView=[[MessageView alloc]initWithNibName:@"MessageView" bundle:nil];
        objMessageView.messageID1=mesgId;
        objMessageView.rootMsgIDArray=rootMsgIDArray;
        objMessageView.rootConIDArray=rootConIDArray;
        objMessageView.rootConNumArray=rootConNumArray;
        objMessageView.index=index;
        [self.navigationController pushViewController:objMessageView animated:NO];
        [objMessageView release];
    }
    else
    {                      
        urlReq =[NSString stringWithFormat:@"%@/mobile/Conversation_Details/?id=%@&pid=%@&skey=%@",domain,[rootConIDArray objectAtIndex:index],((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedSessionID];
        [JSWaiter ShowWaiter:self title:@"Loading..." type:0];
        [self performSelectorOnMainThread:@selector(WebRequest:) withObject:urlReq waitUntilDone:NO];        
    }
  
}



#pragma mark Table View Delegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    // Return the number of sections.
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // returning the no of rows in section
    return [nameArray count];
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    //for creating cell height
    return 125;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
        
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell;
    cell = nil;
    
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
   
    UIView *bgColor = [cell viewWithTag:100];  
   
    if (!bgColor) 
    {          
        CGRect frame = CGRectMake(0, 0, 1200, 130);  
        bgColor = [[UIView alloc] initWithFrame:frame];  
        bgColor.tag = 100; //tag id to access the view later  
        [cell addSubview:bgColor];  
        [cell sendSubviewToBack:bgColor];  
        [bgColor release];  
        
    }  
    
    if (indexPath.row % 2 == 0)
    {         
        bgColor.backgroundColor = [UIColor colorWithRed:226.0/255.0  
                                                  green:226.0/255.0  
                                                   blue:226.0/255.0  
                                                  alpha:1.0]; 
         
    } 
    else 
    {          
        bgColor.backgroundColor = [UIColor clearColor];  
    }  
     
    UIImageView *imgview=[[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)] autorelease];
    imgview.layer.cornerRadius=10.0;
    imgview.layer.masksToBounds=YES;
    imgview.layer.borderColor = [UIColor lightGrayColor].CGColor;
    imgview.layer.borderWidth = 1.0;
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
                if([congenderArray count]>0)
                {
                    if ( ([congenderArray objectAtIndex:indexPath.row] == (id)[NSNull null])
                        || ([congenderArray objectAtIndex:indexPath.row] == NULL)
                        || ([[congenderArray objectAtIndex:indexPath.row] isEqual:@""])
                        || ([[congenderArray objectAtIndex:indexPath.row] length] == 0) )
                    {                                                      
                        imgview.image=[UIImage imageNamed:@"man.png"];
                    }
                    else
                    {                    
                        if ([[congenderArray objectAtIndex:indexPath.row] intValue]==1) 
                        {
                            imgview.image=[UIImage imageNamed:@"women.png"];
                        }
                        else if ([[congenderArray objectAtIndex:indexPath.row] intValue]==2) 
                        {
                            imgview.image=[UIImage imageNamed:@"man.png"];
                        }
                        else if ([[congenderArray objectAtIndex:indexPath.row] intValue]==4) 
                        {
                            imgview.image=[UIImage imageNamed:@"man_women.png"];
                        }
                        else if ([[congenderArray objectAtIndex:indexPath.row] intValue]==8) 
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
        
    
    previousBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [previousBut setFrame:CGRectMake(table.bounds.size.width-50,60,15,15)];
    [previousBut setImage:[UIImage imageNamed:@"Down arrow.png"] forState:UIControlStateNormal];
     previousBut.tag=indexPath.row; 
    [cell addSubview:previousBut];
 
    lblOfTxt = [[[UITextView alloc]init]autorelease];
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) 
    {        
        lblOfTxt.frame=CGRectMake(77,31, 550,70 );
    }
    else
    {       
        lblOfTxt.frame=CGRectMake(77,31, 162,67 );
    }

    lblOfTxt.userInteractionEnabled=NO;
    lblOfTxt.scrollEnabled =NO;
    lblOfTxt.font = [UIFont systemFontOfSize:15.0];
    lblOfTxt.textAlignment = UITextAlignmentLeft;
    lblOfTxt.textColor = [UIColor darkGrayColor];
    lblOfTxt.backgroundColor = [UIColor clearColor]; 

    
    if (([messageContentArray objectAtIndex:indexPath.row]== (id)[NSNull null])||([messageContentArray objectAtIndex:indexPath.row]== NULL))
    {
        lblOfTxt.text=@"";
    }
    else 
    {        
        lblOfTxt.text=[messageContentArray objectAtIndex:indexPath.row];
    }
   
    [cell addSubview:lblOfTxt];
    
    float textViewLineCount=lblOfTxt.contentSize.height/lblOfTxt.font.lineHeight;

    int lineNum=(ceil(textViewLineCount));

    
    if (lineNum <4) 
    {
        previousBut.hidden=NO;
    }
    
    cell.textLabel.textColor=[UIColor whiteColor];
       
    CGRect frame1 =CGRectMake(85,12, 200,18 );
    UILabel *lblOfName=[[UILabel alloc]initWithFrame:frame1];
    lblOfName.font=[UIFont fontWithName:@"Ubuntu-Bold" size:17];;
    lblOfName.textColor =[UIColor blackColor]; 
    lblOfName.backgroundColor = [UIColor clearColor]; 

    
    if (([nameArray objectAtIndex:indexPath.row]== (id)[NSNull null])||([nameArray objectAtIndex:indexPath.row]==NULL)) 
    {
        lblOfName.text=@"";
    }
    else 
    {        
        lblOfName.text=[nameArray objectAtIndex:indexPath.row];
    }
    
    if ([[senderId objectAtIndex:indexPath.row] isEqualToString:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID]) 
    {
        lblOfName.text=@"Me";
    }
       
    [cell addSubview: lblOfName];
    [lblOfName release];
      
    CGRect frame6=CGRectMake(12,105, 170,15 );
    UILabel *lblOfTime=[[UILabel alloc]initWithFrame:frame6];
            
    if (([timeArray objectAtIndex:indexPath.row]== (id)[NSNull null])||([timeArray objectAtIndex:indexPath.row]==NULL)) 
    {
        lblOfTime.text=@"";
    }
    else 
    {        
        NSString *trimstring=[timeArray objectAtIndex:indexPath.row];
        lblOfTime.text=[self FormatTime:trimstring];
    }
        
    lblOfTime.font=[UIFont boldSystemFontOfSize:14];
    lblOfTime.textColor =[UIColor lightGrayColor]; 
    lblOfTime.textAlignment=UITextAlignmentLeft;
    lblOfTime.backgroundColor = [UIColor clearColor];
    [cell addSubview: lblOfTime];
    [lblOfTime release];
        
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{                   
    if (indexPath.section==0 && [nameArray count]>0)
    {
        NSString *mesgId=[messageId objectAtIndex:indexPath.row];
        NSString *sendId=[senderId objectAtIndex:indexPath.row];
        MessageView *objMessageView=[[MessageView alloc]initWithNibName:@"MessageView" bundle:nil];
        objMessageView.messageID1=mesgId;
        objMessageView.profileID=sendId;
        objMessageView.rootMsgIDArray=messageId;
        objMessageView.rootConIDArray=rootConIDArray;
        objMessageView.rootConNumArray=rootConNumArray;
        objMessageView.index=indexPath.row;
        objMessageView.fromInbox=fromInbox;
        objMessageView.conversationNumber=2;
        if (fromInbox)
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
    
}



@end
