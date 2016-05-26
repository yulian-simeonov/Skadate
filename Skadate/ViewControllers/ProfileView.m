//
//  ProfileView.m
//  Chk
//
//  Created by SODTechnologies on 22/08/11.
//  Copyright 2011 Solutions On Demand Australasia Pty Ltd. All rights reserved.
//

#import "ProfileView.h"
#import "JSON.h"
#import "SkadateAppDelegate.h"
#import "ComposeMessageView.h"
#import "ChatMembersView.h"
#import "ProfilePhotoView.h"
#import "HomeView.h"
#import "CommonStaticMethods.h"



@implementation ProfileView

@synthesize btnHome;
@synthesize btnChat,imgstring;
@synthesize lblProfileName;
@synthesize imgProfile,selectImg;
@synthesize txtInfo,txtInfoName,txtInfoAge;
@synthesize segmentCtrl;
@synthesize txtViewEssays,genderstring;
@synthesize tempScrollView,btnBookmark,btnComposeMail,domain;
@synthesize profileID,profilenamestring;
@synthesize actionsheetBtn,resultType;
@synthesize  NewXval;

#pragma mark Memory Management

- (void)dealloc
{
    [genderstring release];
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
    txtViewEssays.text=@"";
    btnHome.enabled=NO;
    btnChat.enabled=NO;
    btnBookmark.enabled=NO;
    btnComposeMail.enabled=NO;
    actionsheetBtn.enabled=NO;
    txtViewEssays.editable=NO;
    [btnHome setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    isloading=YES;
    btnHome.tag = 2;
    segmentCtrl.segmentedControlStyle = UISegmentedControlStyleBar;
    segmentCtrl.frame = CGRectMake (10, 10, 300,35);
    UIColor *newTintColor = [UIColor colorWithRed: 245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    segmentCtrl.tintColor = newTintColor;
    UIColor *newSelectedTintColor = [UIColor colorWithRed: 245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    [[[segmentCtrl subviews] objectAtIndex:0] setTintColor:newSelectedTintColor];
   
    txtViewEssays.layer.cornerRadius = 10;
    txtViewEssays.layer.borderWidth = 1.0f;
    txtViewEssays.layer.borderColor = [UIColor grayColor].CGColor;
    txtViewEssays.clipsToBounds = YES; 
    txtViewEssays.scrollEnabled=NO;
    
    tempScrollView.backgroundColor=[UIColor clearColor];
    [navBar setTintColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavbar/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavbar/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavbar/255.0 alpha:1.0]];
    [toolBar  setTintColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavbar/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavbar/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavbar/255.0 alpha:1.0]];
    navBar.layer.borderColor=[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavBorder/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavBorder/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavBorder/255.0 alpha:1.0].CGColor;
    navBar.layer.borderWidth=1.0f;
    toolBar.layer.borderColor=[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavBorder/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavBorder/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavBorder/255.0 alpha:1.0].CGColor;
    toolBar.layer.borderWidth=1.0f;
    profilelab.font= ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontNavTitle;
    [profilelab setTextAlignment:UITextAlignmentCenter];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    domain = [prefs stringForKey:@"URL"];
    
    lblProfileName.font=[UIFont fontWithName:@"Ubuntu-Bold" size:20];
    imgProfile.layer.cornerRadius=15.0;
    imgProfile.layer.masksToBounds=YES;
    bookMarkFlag=NO;
    OnlineFlag=NO;
    
    NSString *req = [NSString stringWithFormat:@"%@/mobile/Profile_View/index.php?id=%@&skey=%@&vid=%@",domain,profileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID];
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:req, @"url", @"Profile_ViewUrlConnection", @"meta", nil];
    [JSWaiter ShowWaiter:self title:@"Loading..." type:0];
    [self performSelectorOnMainThread:@selector(WebRequest:) withObject:params waitUntilDone:NO];
    self.view.userInteractionEnabled=NO;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        infodettexview.font=[UIFont fontWithName:@"Helvetica-Bold" size:23];
        txtInfo.font=[UIFont fontWithName:@"Helvetica" size:23];
        txtInfoName.font=[UIFont fontWithName:@"Helvetica" size:23];
        txtInfoAge.font=[UIFont fontWithName:@"Helvetica" size:21];
        lblProfileName.font=[UIFont fontWithName:@"Ubuntu-Bold" size:30];
        txtViewEssays.font=[UIFont fontWithName:@"Helvetica" size:20];
    }
    txtViewEssays.userInteractionEnabled=NO;
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
    
    // Return YES for supported orientations
    /*if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        infodettexview.font=[UIFont fontWithName:@"Helvetica-Bold" size:23];
        
        if([txtInfo.text length]>26) 
        {
            txtInfo.font=[UIFont fontWithName:@"Helvetica" size:19];
        }
        else
        {
            txtInfo.font=[UIFont fontWithName:@"Helvetica" size:23];
        } 
        
        txtInfoName.font=[UIFont fontWithName:@"Helvetica" size:23];
        txtInfoAge.font=[UIFont fontWithName:@"Helvetica" size:21];
        lblProfileName.font=[UIFont fontWithName:@"Ubuntu-Bold" size:30];
        txtViewEssays.font=[UIFont fontWithName:@"Helvetica" size:20];
      
        if(interfaceOrientation==UIInterfaceOrientationLandscapeLeft||interfaceOrientation==UIInterfaceOrientationLandscapeRight)
        {
            indicatorView.frame =CGRectMake((412+NewXval), 344, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30), 40);
            tempScrollView.frame=CGRectMake(0, 44, 1024, 724);
            tempScrollView.contentSize=CGSizeMake(1024,938);
            imgProfile.frame=CGRectMake(289, 82, 180, 150);
            lblProfileName.frame=CGRectMake(500, 130, 100, 40);
            infoimgview.frame=CGRectMake(289, 291, 483, 250);
            infodettexview.frame=CGRectMake(297, 343, 225, 190);
            txtInfo.frame=CGRectMake(522, 346, 250, 60);
            txtInfoName.frame=CGRectMake(522, 402, 200, 60);
            txtInfoAge.frame=CGRectMake(522, 458, 200, 60);
            essayimgview.frame=CGRectMake(289, 575, 483, 50);
            txtViewEssays.frame=CGRectMake(289, 617, 483, 130);
        }
        else
        {
            indicatorView.frame =CGRectMake((284+NewXval), 471, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30), 40);
            tempScrollView.frame=CGRectMake(0, 44, 768, 936);
            tempScrollView.contentSize=CGSizeMake(768,938);
            imgProfile.frame=CGRectMake(150, 82, 180, 150);
            lblProfileName.frame=CGRectMake(360, 130, 100, 40);
            infoimgview.frame=CGRectMake(150, 290, 483, 250);
            infodettexview.frame=CGRectMake(160, 343, 225, 190);
            txtInfo.frame=CGRectMake(385, 346, 250, 60);
            txtInfoName.frame=CGRectMake(385, 402, 200, 60);
            txtInfoAge.frame=CGRectMake(385, 458, 200, 60);
            essayimgview.frame=CGRectMake(150, 575, 483, 50);
            txtViewEssays.frame=CGRectMake(150, 617, 483, 130);
        }
        
        [self textViewFunction];
        [self SetEssaysFrame];
        return YES;
    }
    else
    {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    }*/ 
}

#pragma mark Custom Methods

-(void)SetEssaysFrame
{
    if ([txtViewEssays.text isEqualToString:@""])
    {
    }
    else
    {               
        textViewValue = txtViewEssays.text.length;
        if(textViewValue>1)
        {
            CGRect frame = txtViewEssays.frame;
            frame.size = txtViewEssays.contentSize;
            if(frame.size.height>txtViewEssays.frame.size.height)
            {
                txtViewEssays.frame = frame;
            }
        }
        NSUInteger TotlScroll = (txtViewEssays.frame.size.height) + (txtViewEssays.frame.origin.y) + 250;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            if(self.interfaceOrientation==UIInterfaceOrientationLandscapeLeft||
               self.interfaceOrientation==UIInterfaceOrientationLandscapeRight)
            {
                if(textViewValue > 1)
                {
                    tempScrollView.contentSize=CGSizeMake(1024,TotlScroll);
                }
                else
                {
                    tempScrollView.contentSize=CGSizeMake(1024,938);
                }
                
            }
            else
            {
                if(textViewValue > 1)
                {
                    tempScrollView.contentSize=CGSizeMake(768,TotlScroll);
                }
                else
                {
                    tempScrollView.contentSize=CGSizeMake(768,938);
                }
            }
        }   
        else
        {
            if(textViewValue > 1)
            {
                tempScrollView.contentSize=CGSizeMake(320,TotlScroll);
            }
            else
            {
                tempScrollView.contentSize=CGSizeMake(320,620);
            }
        }
    }
}

-(NSString *)returnGender:(int)value
{
    
    NSString *gender=@""; 
    switch (value) 
    {
        case 1:
            gender=@"Female";
            break;
        case 2:
            gender=@"Male";
            break; 
        case 3:
            gender=@"Female,Male";
            break; 
        case 4:
            gender=@"Couple";
            break; 
        case 5:
            gender=@"Female,Couple";
            break;
        case 6:
            gender=@"Male,Couple";
            break; 
        case 7:
            gender=@"Female,Male,Couple";
            break; 
        case 8:
            gender=@"Group";
            break;
        case 9:
            gender=@"Female,Group";
            break;
        case 10:
            gender=@"Male,Group";
            break; 
        case 11:
            gender=@"Female,Male,,Group";
            break; 
        case 12:
            gender=@"Couple,Group";
            break;
        case 13:
            gender=@"Female,Couple,Group";
            break;
        case 14:
            gender=@"Male,Couple,Group";
            break; 
        case 15:
            gender=@"Female,Male,Couple,Group";
            break; 
            
        default:
            gender=@"";
            
            break;
            
    }
    return gender;
}

-(void)textViewFunction
{
    
    CGRect frame = txtViewEssays.frame;
    frame.size = txtViewEssays.contentSize;
    txtViewEssays.frame = frame;
    NSUInteger TotlScroll = (txtViewEssays.frame.size.height) + (txtViewEssays.frame.origin.y) + 250;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if(self.interfaceOrientation==UIInterfaceOrientationLandscapeLeft||
           self.interfaceOrientation==UIInterfaceOrientationLandscapeRight)
        {
            if(textViewValue > 1)
            {
                tempScrollView.contentSize=CGSizeMake(1024,TotlScroll);
            }
            else
            {
                tempScrollView.contentSize=CGSizeMake(1024,938);
                txtViewEssays.frame=CGRectMake(289, 617, 483, 130);
            }
        }
        else
        {
            if(textViewValue > 1)
            {
                tempScrollView.contentSize=CGSizeMake(768,TotlScroll);
            }
            else
            {
                tempScrollView.contentSize=CGSizeMake(768,938);
                txtViewEssays.frame=CGRectMake(150, 617, 483, 130);
            }
        }
    }   
}

#pragma mark IBActions

-(IBAction)clickedActionSheetButton:(id) sender
{    
    /*if (selectImg==6)
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:nil
                                      delegate:self
                                      cancelButtonTitle:@"Cancel"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"Send Kiss",nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        actionSheet.tag=0;
        [actionSheet showInView:self.view];
        [actionSheet release];
    }
    else
    {*/
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:nil
                                      delegate:self
                                      cancelButtonTitle:@"Cancel"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"Bookmark",nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        actionSheet.tag=0;
        [actionSheet showInView:self.view];
        [actionSheet release];
    //}
}

-(IBAction) clickedSegmentContol
{
	int selectedsegment=segmentCtrl.selectedSegmentIndex;
   
    if (selectedsegment==0) 
	{
	}
    
	if (selectedsegment==1)
	{
        if (isloading)
        {
            return;
        }
		ProfilePhotoView *objProfilePhotoView=[[ProfilePhotoView alloc]initWithNibName:@"ProfilePhotoView" bundle:nil];
        segmentCtrl.selectedSegmentIndex=0;
        [segmentCtrl setImage:[UIImage imageNamed:@"Info_tab_over.png"] forSegmentAtIndex:0];
        [segmentCtrl setImage:[UIImage imageNamed:@"Photos_tab.png"] forSegmentAtIndex:1];
        objProfilePhotoView.backbtnimgId=selectImg;
        objProfilePhotoView.profileId=profileID;
        objProfilePhotoView.profileName=profilenamestring;
        objProfilePhotoView.photoimgstring=imgstring;
        objProfilePhotoView.profilegenderId=genderstring;
        [self.navigationController pushViewController:objProfilePhotoView animated:NO];
        [objProfilePhotoView release];
    }
    
}


-(IBAction)clickedOnlineButton:(id) sender
{    
    OnlineFlag=YES;
    [self.navigationController popViewControllerAnimated:YES];
}


-(IBAction)clickedChatButton:(id) sender
{    
    NSUserDefaults *val = [NSUserDefaults standardUserDefaults];
    realName=[val valueForKey:@"RealName"];
    ChatMembersView *objChatMembersView=[[ChatMembersView alloc]initWithNibName:@"ChatMembersView" bundle:nil];
    objChatMembersView.receipientProfileId = profileID;
    objChatMembersView.receipientName = realName;
    objChatMembersView.receipientProfilePic =imgstring;
    objChatMembersView.recipientgender =genderstring;
    [self.navigationController pushViewController:objChatMembersView animated:YES];
    [objChatMembersView release];
}


-(IBAction)clickedMailButton:(id) sender
{    
    ComposeMessageView *objComposeMessageView=[[ComposeMessageView alloc]initWithNibName:@"ComposeMessageView" bundle:nil];
    objComposeMessageView.selectedprofileid=[profileID integerValue];
    objComposeMessageView.profilenamestring=lblProfileName.text;
    objComposeMessageView.userImage=myimage;
    objComposeMessageView.decision=YES;
    [self.navigationController pushViewController:objComposeMessageView animated:YES];
    [objComposeMessageView release];
    
}

-(IBAction)clickedBookmarkButton:(id) sender
{
    NSString *pid=((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID;
    if([pid isEqualToString:profileID])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"you are not able to bookmark yourself." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return;
    }
    else
    {
        bookMarkFlag=YES;
        NSString *req = [NSString stringWithFormat:@"%@/mobile/Bookmark_Profile/?pid=%@&skey=%@&bid=%@",domain,(((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID),((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID ,profileID];
        [JSWaiter ShowWaiter:self title:@"Bookmarking..." type:0];
        [self performSelectorOnMainThread:@selector(WebRequest:) withObject:req waitUntilDone:NO];
    }
}


#pragma mark ActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        bookMarkFlag=YES;
        NSString *req = [NSString stringWithFormat:@"%@/mobile/Bookmark_Profile/?pid=%@&skey=%@&bid=%@",domain,(((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID),((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID ,profileID];
        [JSWaiter ShowWaiter:self title:@"Loading..." type:0];
        [self performSelectorOnMainThread:@selector(WebRequest:) withObject:req waitUntilDone:NO];
        self.view.userInteractionEnabled=NO;
    }
}


#pragma mark Managing API Calls
-(void)WebRequest:(NSDictionary*)params
{
	NSString* url = [params valueForKey:@"url"];
	NSString* meta = [params valueForKey:@"meta"];
    JSWebManager* webMgr = [[[JSWebManager alloc] initWithAsyncOption:NO] autorelease];
    NSDictionary* ret = [webMgr GetDataFromUrl:url];
    NSError* error = [ret objectForKey:@"error"];
    if (error)
    {
		self.view.userInteractionEnabled=YES;
        isloading=NO;
        btnHome.enabled=YES;
        btnChat.enabled=YES;
        btnBookmark.enabled=YES;
        btnComposeMail.enabled=YES;
        actionsheetBtn.enabled=YES;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Connection failed...Please launch the application again." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        tempScrollView.contentSize=CGSizeMake(320,620);
    }
    else
    {
        NSDictionary *parsedData = (NSDictionary *)[ret objectForKey:@"data"];
        self.view.userInteractionEnabled=YES;
        isloading=NO;
        btnHome.enabled=YES;
        btnChat.enabled=YES;
        btnBookmark.enabled=YES;
        btnComposeMail.enabled=YES;
        actionsheetBtn.enabled=YES;
        imgProfile.layer.cornerRadius=12.0;
        imgProfile.layer.masksToBounds=YES;
        imgProfile.layer.borderColor = [UIColor lightGrayColor].CGColor;
        imgProfile.layer.borderWidth = 1.0;
        
        if (bookMarkFlag)
        {
            bookMarkFlag=NO;
            NSString *bookMark=(NSString*)[parsedData objectForKey:@"Message"];
            
            if ((bookMark==(id)[NSNull null]) || [bookMark isEqualToString:@""] || [bookMark isEqualToString:@"0"])
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[@"Cannot bookmark the profile now. Please try after sometime." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
                [alertView release];
            }
            else if([bookMark isEqualToString:@"Site suspended"])
            {
                ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Site suspended";
                UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Site suspended. Please try after sometime." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
                sessionAlertView.tag=1;
                [sessionAlertView show];
                [sessionAlertView release];
            }
            else if([bookMark isEqualToString:@"Session Expired"])
            {
                ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Session Expired";
                UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Your session has expired. Please login again." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
                sessionAlertView.tag=1;
                [sessionAlertView show];
                [sessionAlertView release];
            }
            else if ([bookMark isEqualToString:@"Membership Denied"])
            {
                UIAlertView *MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Please upgrade your membership to bookmark  the profile." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [MembershipAlertView show];
                [MembershipAlertView release];
            }
            else if ([bookMark isEqualToString:@"Bookmarked Failed"])
            {
                UIAlertView *MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[@"You already bookmarked the profile." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [MembershipAlertView show];
                [MembershipAlertView release];
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
        
        if ([meta isEqualToString:@"Profile_ViewUrlConnection"])
        {
            NSString *messegeStr=(NSString*)[parsedData objectForKey:@"Message"];
            
            if([messegeStr isEqualToString:@"Site suspended"])
            {
                ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Site suspended";
                UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Site suspended. Please try after sometime." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
                sessionAlertView.tag=1;
                [sessionAlertView show];
                [sessionAlertView release];
                [JSWaiter HideWaiter];
                return;
            }
            else if ([messegeStr isEqualToString:@"Session Expired"])
            {
                ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Session Expired";
                UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Your session has expired. Please login again." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
                sessionAlertView.tag=1;
                [sessionAlertView show];
                [sessionAlertView release];
                [JSWaiter HideWaiter];
                return;
            }
            else if ([messegeStr isEqualToString:@"Membership Denied"])
            {
                UIAlertView *MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Please upgrade your membership to view  the profile." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [MembershipAlertView show];
                [MembershipAlertView release];
                [JSWaiter HideWaiter];
                return;
            }
            else if ([messegeStr isEqualToString:@"Incorrect ID"])
            {
                
                UIAlertView *MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Connection failed...Please launch the application again." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [MembershipAlertView show];
                [MembershipAlertView release];
                tempScrollView.contentSize=CGSizeMake(320,620);
                [JSWaiter HideWaiter];
                return;
            }
            respProflieDetails.profileID=(NSString*)[parsedData objectForKey:@"profile_id"];
            
            if ( ([respProflieDetails.profileID isEqualToString:@""])
                || (respProflieDetails.profileID == (id)[NSNull null])
                || (respProflieDetails.profileID == NULL)
                || ([respProflieDetails.profileID isEqualToString:@""])
                || ([respProflieDetails.profileID length] == 0) )
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Connection failed...Please launch the application again." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
                [alertView release];
                tempScrollView.contentSize=CGSizeMake(320,620);
                [JSWaiter HideWaiter];
                return;
            }
            else
            {
                respProflieDetails.bgImageURL=(NSString*)[parsedData objectForKey:@"Profile_Image"];
                respProflieDetails.fullName=(NSString*)[parsedData objectForKey:@"username"];
                NSString *Val=(NSString*)[parsedData objectForKey:@"sex"];
                genderstring=[[NSMutableString alloc]initWithString:Val];
                int intVal=[Val intValue];
                respProflieDetails.sex=[self returnGender:intVal];
                NSString *ValLooking=(NSString*)[parsedData objectForKey:@"match_sex"];
                int intValLooking;
                
                @try
                {
                    intValLooking=[ValLooking intValue];
                }
                @catch (NSException *e)
                {
                }
                
                respProflieDetails.match_sex=[self returnGender:intValLooking];
                respProflieDetails.dob=(NSString*)[parsedData objectForKey:@"birthdate"];
                respProflieDetails.matchAge=(NSString*)[parsedData objectForKey:@"match_agerange"];
                respProflieDetails.headline=(NSString*)[parsedData objectForKey:@"headline"];
                respProflieDetails.realName=(NSString*)[parsedData objectForKey:@"real_name"];
                respProflieDetails.essays=(NSString*)[parsedData objectForKey:@"general_description"];
                realName=(NSString*)[parsedData objectForKey:@"username"];
                NSUserDefaults *val = [NSUserDefaults standardUserDefaults];
                [val setValue:realName forKey:@"RealName"];
                
                if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
                {
                    imgProfile.layer.cornerRadius=25.0;
                }
                
                imgProfile.image=[UIImage imageNamed:@"Loading large.PNG"];
                
                // Lazy image loading
                NSString *profilePicURL1=[NSString stringWithFormat:@"%@%@",domain,respProflieDetails.bgImageURL];
                
                if ( (respProflieDetails.bgImageURL == (id)[NSNull null])
                    || respProflieDetails.bgImageURL == NULL
                    || [respProflieDetails.bgImageURL isEqual:@""] )
                {
                }
                else
                {
                    imgstring=[[NSString alloc]initWithString:respProflieDetails.bgImageURL];
                }
                
                NSString *imageName=[NSString stringWithFormat:@"%@",respProflieDetails.bgImageURL];
                //imageName=[imageName stringByReplacingOccurrencesOfString:@"/$userfiles/" withString:@""];   // for old version
                imageName=[imageName stringByReplacingOccurrencesOfString:@"/userfiles/" withString:@""];   // for new version
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
                            myimage=image;
                        }
                        else
                        {
                            if ( (Val == (id)[NSNull null])
                                || (Val == NULL)
                                || ([Val isEqualToString:@""])
                                || ([Val length] == 0) )
                            {
                                myimage =[UIImage imageNamed:@"man.png"];
                            }
                            else
                            {
                                if (intVal==1)
                                {
                                    myimage=[UIImage imageNamed:@"women.png"];
                                }
                                else if (intVal==2)
                                {
                                    myimage=[UIImage imageNamed:@"man.png"];
                                }
                                else if (intVal==4)
                                {
                                    myimage=[UIImage imageNamed:@"man_women.png"];
                                }
                                else if (intVal==8)
                                {
                                    myimage=[UIImage imageNamed:@"man_women_a.png"];
                                }
                                else
                                {
                                    myimage=[UIImage imageNamed:@"man.png"];
                                }
                            }
                        }
                        
                        imgProfile.image=myimage;
                        
                    });
                });
                
                dispatch_release(queue);
                
                if ( (respProflieDetails.headline == (id)[NSNull null])
                    || respProflieDetails.headline == NULL
                    || [respProflieDetails.headline isEqualToString:@""] )
                {
                    respProflieDetails.headline = @" ";
                }
                
                if ( (respProflieDetails.realName==(id)[NSNull null])
                    || respProflieDetails.realName == NULL
                    || [respProflieDetails.realName isEqualToString:@""] )
                {
                    respProflieDetails.realName = @" ";
                }
                
                if ( (respProflieDetails.essays==(id)[NSNull null])
                    || respProflieDetails.essays == NULL
                    || [respProflieDetails.essays isEqualToString:@""] )
                {
                    respProflieDetails.essays = @" ";
                }
                
                if ( (respProflieDetails.sex == (id)[NSNull null])
                    || respProflieDetails.sex == NULL
                    || [respProflieDetails.sex isEqualToString:@""] )
                {
                    respProflieDetails.sex = @" ";
                }
                
                if ( (respProflieDetails.match_sex == (id)[NSNull null])
                    || respProflieDetails.match_sex == NULL
                    || [respProflieDetails.match_sex isEqualToString:@""] )
                {
                    respProflieDetails.match_sex = @" ";
                }
                
                if ( (respProflieDetails.dob == (id)[NSNull null])
                    || respProflieDetails.dob == NULL
                    || [respProflieDetails.dob isEqualToString:@""] )
                {
                    respProflieDetails.dob = @" ";
                }
                
                if ( (respProflieDetails.matchAge == (id)[NSNull null])
                    || respProflieDetails.matchAge == NULL
                    || [respProflieDetails.matchAge isEqualToString:@""] )
                {
                    respProflieDetails.matchAge = @" ";
                }
                
                profilePicURL=[NSString stringWithFormat:@"%@%@",domain,respProflieDetails.bgImageURL];
                NSString *infoText=[NSString stringWithFormat:@"%@\r%@",respProflieDetails.sex,respProflieDetails.match_sex];
                NSString *infoTextMiddle=[NSString stringWithFormat:@"%@\r%@",respProflieDetails.realName,respProflieDetails.headline];
                
                
                NSString *strDob;
                NSArray* strDOB = [respProflieDetails.dob componentsSeparatedByString: @"-"];
                
                if ([strDOB count]>0)
                {
                    NSString * day = [strDOB objectAtIndex: 2];
                    NSString *year = [strDOB objectAtIndex: 0];
                    NSString *seperator=@"-";
                    NSString * monthName= [CommonStaticMethods GetMonthName:[strDOB objectAtIndex: 1]];
                    NSString *strdob1=[monthName stringByAppendingString:seperator];
                    NSString *strdob2=[strdob1 stringByAppendingString:day];
                    NSString *strdob3=[strdob2 stringByAppendingString:seperator];
                    strDob=[strdob3 stringByAppendingString:year];
                }
                
                NSString *infoTextLast=[NSString stringWithFormat:@"%@\r%@",strDob,respProflieDetails.matchAge];
                
                lblProfileName.text=respProflieDetails.fullName;
                
                if(respProflieDetails.fullName==NULL)
                {
                    [profilelab setText:@""];
                    profilenamestring=[[NSString alloc]initWithString:@""];
                }
                else
                {
                    NSString *profnamestr=[NSString stringWithFormat:@"%@'s Profile",respProflieDetails.fullName];
                    profilenamestring=[[NSString alloc]initWithString:respProflieDetails.fullName];
                    [profilelab setText:profnamestr];
                }
                
                txtInfo.text=infoText;
                
                if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
                {
                    if([txtInfo.text length]>26)
                    {
                        txtInfo.font=[UIFont fontWithName:@"Helvetica" size:19];
                    }
                    else
                    {
                        txtInfo.font=[UIFont fontWithName:@"Helvetica" size:23];
                    }
                }
                
                txtInfoName.text=infoTextMiddle;
                txtInfoAge.text=infoTextLast;
                
                
                
                if (![respProflieDetails.essays isEqualToString:@""])
                {
                    txtViewEssays.text=respProflieDetails.essays;
                    textViewValue = respProflieDetails.essays.length;
                    
                    if(textViewValue>1)
                    {
                        CGRect frame = txtViewEssays.frame;
                        frame.size = txtViewEssays.contentSize;
                        if(frame.size.height>txtViewEssays.frame.size.height)
                        {
                            txtViewEssays.frame = frame;
                        }
                    }
                    
                    NSUInteger TotlScroll = (txtViewEssays.frame.size.height) + (txtViewEssays.frame.origin.y) + 125;
                    
                    if(textViewValue > 1)
                    {
                        tempScrollView.contentSize=CGSizeMake(320,TotlScroll);
                    }
                    else
                    {
                        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
                        {
                            tempScrollView.contentSize=CGSizeMake(320,938);
                        }
                        else
                        {
                            tempScrollView.contentSize=CGSizeMake(320,540);
                        }
                    }
                    
                }
                else
                {
                    NSUInteger TotlScroll = (txtViewEssays.frame.size.height) + (txtViewEssays.frame.origin.y) + 125;
                    tempScrollView.contentSize=CGSizeMake(320,TotlScroll);
                }
                
            }
            
        }
        /*else if(connection==kissUrlConnection)
         {
         
         NSString *messegeStr=(NSString*)[parsedData objectForKey:@"Message"];
         
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
         else if ([messegeStr isEqualToString:@"Membership Denied"])
         {
         NSString *Membership=(NSString*)[parsedData objectForKey:@"Description"];
         NSString *strAlert=@"";
         if ([Membership isEqualToString:@"Recipient"])
         {
         strAlert=@"You are not able to send kiss to free members.";
         }
         else
         {
         strAlert=@"Please upgrade your membership to send kiss.";
         }
         UIAlertView *MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[strAlert description] delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
         [MembershipAlertView show];
         [MembershipAlertView release];
         return;
         
         }
         else if([messegeStr isEqualToString:@"Success"])
         {
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success" message:[@"Successfully sent the kiss." description] delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
         [alertView show];
         [alertView release];
         return;
         
         }
         else
         {
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Failed to send kisse.Please try later." description] delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
         [alertView show];
         [alertView release];
         return;
         }
         }
         else if(connection==winkUrlConnection)
         {
         
         NSString *messegeStr=(NSString*)[parsedData objectForKey:@"Message"];
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
         else if ([messegeStr isEqualToString:@"Membership Denied"]) 
         {
         UIAlertView *MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Wink sent only from paid to paid members only." description] delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
         [MembershipAlertView show];
         [MembershipAlertView release];
         return;
         }
         else if([messegeStr isEqualToString:@"Success"])
         {
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success" message:[@"Successfully sent the Wink." description] delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
         [alertView show];
         [alertView release];
         return;
         }
         else
         {
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Failed to send Wink.Please try later." description] delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
         [alertView show];
         [alertView release];
         return;
         }
         
         }*/
    }
    [JSWaiter HideWaiter];
}

#pragma mark Alert View Delegate

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex 
{    
    if (actionSheet.tag==1&&buttonIndex==0)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}



@end
