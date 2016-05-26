//
//  OnlineMembers.m
//  Skadate
//
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OnlineMembers.h"
#import "HomeView.h"
#import "SearchMembersView.h"
#import "SkadateAppDelegate.h"
#import "JSON.h"
#import "ProfileView.h"
#import "CommonStaticMethods.h"
#import "MyProfileView.h"


@implementation OnlineMembers

@synthesize imageArray,nameArray,ageArray,placeArray,countryName,table,btnSearch,btnHome,tabBarItem,urlReq,profileID, objChatMembersView,objComposeMessageView,objSearchMembersView,gender, lblTabName,thumbPicURLs,newFlag,onlineFlag,myWatchesFlag,featuredFlag,bookmarksFlag;
@synthesize prevIndexPath,genderIdArray,selectedtab,domain;
@synthesize lblOfAge,lblOfCountry,lblOfName,lblOfPlace,lblOfAgeNew,lblOfPlaceNew;
@synthesize countTotal;
@synthesize  NewXval;

#pragma mark Memory Management

- (void)dealloc 
{    
    [imageArray release];
    [nameArray release];
    [placeArray release];
    [countryName release];
    [gender release];
    [thumbPicURLs release];
    [profileID release];
    [ageArray release];
    [super dealloc];
    dispatch_release(queue);

}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(NSString *)returnGender:(int)value
{
    NSString *pGender=@"";
    switch (value)
    {
        case 1:
            pGender=@"Female";
            break;
        case 2:
            pGender=@"Male";
            break;
        case 3:
            pGender=@"Female,Male";
            break;
        case 4:
            pGender=@"Couple";
            break;
        case 5:
            pGender=@"Female,Couple";
            break;
        case 6:
            pGender=@"Male,Couple";
            break;
        case 7:
            pGender=@"Female,Male,Couple";
            break;
        case 8:
            pGender=@"Group";
            break;
        case 9:
            pGender=@"Female,Group";
            break;
        case 10:
            pGender=@"Male,Group";
            break;
        case 11:
            pGender=@"Female,Male,,Group";
            break;
        case 12:
            pGender=@"Couple,Group";
            break;
        case 13:
            pGender=@"Female,Couple,Group";
            break;
        case 14:
            pGender=@"Male,Couple,Group";
            break;
        case 15:
            pGender=@"Female,Male,Couple,Group";
            break;
        default:
            pGender=@"";
            break;
    }
    return pGender;
    
}

- (void)LoadMemberData
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *memberType=  [prefs valueForKey:@"MemberType"];
    
    if([memberType isEqualToString:@"New"])
    {
        if(queue)
        {
            dispatch_suspend(queue);
        }
        
        [JSWaiter HideWaiter];
        newFlag=YES;
        onlineFlag=NO;
        myWatchesFlag=NO;
        featuredFlag=NO;
        bookmarksFlag=NO;
        lblTabName.text = @"New";
        
        nameArray=[[NSMutableArray alloc]init];
        imageArray=[[NSMutableArray alloc]init];
        ageArray=[[NSMutableArray alloc]init];
        placeArray=[[NSMutableArray alloc]init];
        countryName=[[NSMutableArray alloc]init];
        gender=[[NSMutableArray alloc]init];
        thumbPicURLs=[[NSMutableArray alloc]init ];
        profileID=[[NSMutableArray alloc] init];
        genderIdArray=[[NSMutableArray alloc] init];
        [table reloadData];
        selectedtab=3;
        urlReq=[NSString stringWithFormat:@"%@/mobile/New_MembersByLimit/?id=%@&skey=%@&start=0&limit=10",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedSessionID];
    }
    else if([memberType isEqualToString:@"Online"])
    {
        if(queue)
        {
            dispatch_suspend(queue);
        }
        
        [JSWaiter HideWaiter];
        newFlag=NO;
        onlineFlag=YES;
        myWatchesFlag=NO;
        featuredFlag=NO;
        bookmarksFlag=NO;
        lblTabName.text = @"Online";
        
        nameArray=[[NSMutableArray alloc]init];
        imageArray=[[NSMutableArray alloc]init];
        ageArray=[[NSMutableArray alloc]init];
        placeArray=[[NSMutableArray alloc]init];
        countryName=[[NSMutableArray alloc]init];
        gender=[[NSMutableArray alloc]init];
        thumbPicURLs=[[NSMutableArray alloc]init ];
        profileID=[[NSMutableArray alloc] init];
        genderIdArray=[[NSMutableArray alloc] init];
        [table reloadData];
        selectedtab=2;
        urlReq=[NSString stringWithFormat:@"%@/mobile/Online_MembersByLimit/?id=%@&skey=%@&start=0&limit=10",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID];
    }
    else if([memberType isEqualToString:@"My Watches"])
    {
        if(queue)
        {
            dispatch_suspend(queue);
        }
        
        [JSWaiter HideWaiter];
        newFlag=NO;
        onlineFlag=NO;
        myWatchesFlag=YES;
        featuredFlag=NO;
        bookmarksFlag=NO;
        lblTabName.text = @"My Watches";
        
        nameArray=[[NSMutableArray alloc]init];
        imageArray=[[NSMutableArray alloc]init];
        ageArray=[[NSMutableArray alloc]init];
        placeArray=[[NSMutableArray alloc]init];
        countryName=[[NSMutableArray alloc]init];
        gender=[[NSMutableArray alloc]init];
        thumbPicURLs=[[NSMutableArray alloc]init ];
        profileID=[[NSMutableArray alloc] init];
        genderIdArray=[[NSMutableArray alloc] init];
        [table reloadData];
        selectedtab=4;
        urlReq=[NSString stringWithFormat:@"%@/mobile/MyWatches_ByLimit/?id=%@&skey=%@&start=0&limit=10",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID];
    }
    else if([memberType isEqualToString:@"Featured"])
    {
        if(queue)
        {
            dispatch_suspend(queue);
        }
        
        [JSWaiter HideWaiter];
        newFlag=NO;
        onlineFlag=NO;
        myWatchesFlag=NO;
        featuredFlag=YES;
        bookmarksFlag=NO;
        lblTabName.text = @"Featured";
        
        nameArray=[[NSMutableArray alloc]init];
        imageArray=[[NSMutableArray alloc]init];
        ageArray=[[NSMutableArray alloc]init];
        placeArray=[[NSMutableArray alloc]init];
        countryName=[[NSMutableArray alloc]init];
        gender=[[NSMutableArray alloc]init];
        thumbPicURLs=[[NSMutableArray alloc]init ];
        profileID=[[NSMutableArray alloc] init];
        genderIdArray=[[NSMutableArray alloc] init];
        [table reloadData];
        selectedtab=5;
        urlReq=[NSString stringWithFormat:@"%@/mobile/Featured_MembersByLimit/?id=%@&skey=%@&start=0&limit=10",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID];
    }
    else if([memberType isEqualToString:@"Bookmarked"])
    {
        if(queue)
        {
            dispatch_suspend(queue);
        }
        
        [JSWaiter HideWaiter];
        newFlag=NO;
        onlineFlag=NO;
        myWatchesFlag=NO;
        featuredFlag=NO;
        bookmarksFlag=YES;
        lblTabName.text = @"Bookmarked";
        
        nameArray=[[NSMutableArray alloc]init];
        imageArray=[[NSMutableArray alloc]init];
        ageArray=[[NSMutableArray alloc]init];
        placeArray=[[NSMutableArray alloc]init];
        countryName=[[NSMutableArray alloc]init];
        gender=[[NSMutableArray alloc]init];
        thumbPicURLs=[[NSMutableArray alloc]init ];
        profileID=[[NSMutableArray alloc] init];
        genderIdArray=[[NSMutableArray alloc] init];
        [table reloadData];
        selectedtab=6;
        urlReq = [NSString stringWithFormat: @"%@/mobile/BookMarked_MembersByLimit/?pid=%@&skey=%@&start=0&limit=10",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID];
        
    }
    
    i=0;
    [JSWaiter ShowWaiter:self title:@"Loading..." type:0];
    [self performSelectorOnMainThread:@selector(WebRequest:) withObject:urlReq waitUntilDone:NO];
    self.view.userInteractionEnabled=NO;
    
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


#pragma mark View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

- (void)viewDidLoad
{
    [super viewDidLoad];
    [navBar setTintColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavbar/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavbar/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavbar/255.0 alpha:1.0]];
    navBar.layer.borderColor=[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavBorder/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavBorder/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavBorder/255.0 alpha:1.0].CGColor;
    navBar.layer.borderWidth=1.0f;
    
    lblTabName.font= ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontNavTitle;
    [lblTabName setTextAlignment:UITextAlignmentCenter];
    
    lblTabName.text = @"New";
    selectedtab=3;
    self.navigationController.navigationBarHidden=YES;//hiding the navigation bar
    saveBookMark=NO;
    selectedRowIndex = 0;
    [tabBarItem setSelectedItem:[tabBarItem.items objectAtIndex:0]];
    newFlag=YES;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    domain = [prefs stringForKey:@"URL"];
    [prefs setValue:@"New" forKey:@"MemberType"];
    urlReq=[NSString stringWithFormat:@"%@/mobile/New_MembersByLimit/?id=%@&skey=%@&start=0&limit=10",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedSessionID];
    self.view.userInteractionEnabled=NO;
    [JSWaiter ShowWaiter:self title:@"Loading..." type:0];
    [self performSelectorOnMainThread:@selector(WebRequest:) withObject:urlReq waitUntilDone:NO];
    
    onlineFlag=NO;
    myWatchesFlag=NO;
    featuredFlag=NO;
    bookmarksFlag=NO;
    self.navigationController.navigationBarHidden=YES;
    firstTime=YES;
    queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    
}


-(void)viewWillAppear:(BOOL)animated
{
    if (firstTime==YES)
    {
    }
    else
    {
        [self performSelector:@selector(LoadMemberData)];
    }
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    [imageArray release];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
    
    /*if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if (self.interfaceOrientation==UIInterfaceOrientationLandscapeRight||self.interfaceOrientation==UIInterfaceOrientationLandscapeLeft)
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




#pragma mark UITabBarDelegate

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{    
    switch (item.tag)
    {            
        case 1:        
                if(queue)
                {
                    dispatch_suspend(queue);
                }

            [JSWaiter HideWaiter];
                newFlag=YES;
                onlineFlag=NO;
                myWatchesFlag=NO;
                featuredFlag=NO;
                bookmarksFlag=NO;
                lblTabName.text = @"New";
                          
                nameArray=[[NSMutableArray alloc]init];
                imageArray=[[NSMutableArray alloc]init];
                ageArray=[[NSMutableArray alloc]init];
                placeArray=[[NSMutableArray alloc]init];
                countryName=[[NSMutableArray alloc]init];
                gender=[[NSMutableArray alloc]init];
                thumbPicURLs=[[NSMutableArray alloc]init ];
                profileID=[[NSMutableArray alloc] init];
                genderIdArray=[[NSMutableArray alloc] init];
                [table reloadData];
                selectedtab=3;
                urlReq=[NSString stringWithFormat:@"%@/mobile/New_MembersByLimit/?id=%@&skey=%@&start=0&limit=10",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedSessionID];
                break;
            
        case 2:
                if(queue)
                {
                    dispatch_suspend(queue);
                }

            [JSWaiter HideWaiter];
                newFlag=NO;
                onlineFlag=YES;
                myWatchesFlag=NO;
                featuredFlag=NO;
                bookmarksFlag=NO;
                lblTabName.text = @"Online";
                        
                nameArray=[[NSMutableArray alloc]init];
                imageArray=[[NSMutableArray alloc]init];
                ageArray=[[NSMutableArray alloc]init];
                placeArray=[[NSMutableArray alloc]init];
                countryName=[[NSMutableArray alloc]init];
                gender=[[NSMutableArray alloc]init];
                thumbPicURLs=[[NSMutableArray alloc]init ];
                profileID=[[NSMutableArray alloc] init];
                genderIdArray=[[NSMutableArray alloc] init];
                [table reloadData];
                selectedtab=2;
                urlReq=[NSString stringWithFormat:@"%@/mobile/Online_MembersByLimit/?id=%@&skey=%@&start=0&limit=10",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID];
                
                break;
            
        case 3:
                if(queue)
                {
                    dispatch_suspend(queue);
                }

            [JSWaiter HideWaiter];
                newFlag=NO;
                onlineFlag=NO;
                myWatchesFlag=YES;
                featuredFlag=NO;
                bookmarksFlag=NO;
                lblTabName.text = @"My Watches";
                            
                nameArray=[[NSMutableArray alloc]init];
                imageArray=[[NSMutableArray alloc]init];
                ageArray=[[NSMutableArray alloc]init];
                placeArray=[[NSMutableArray alloc]init];
                countryName=[[NSMutableArray alloc]init];
                gender=[[NSMutableArray alloc]init];
                thumbPicURLs=[[NSMutableArray alloc]init ];
                profileID=[[NSMutableArray alloc] init];
                genderIdArray=[[NSMutableArray alloc] init];
                [table reloadData];
                selectedtab=4;
                urlReq=[NSString stringWithFormat:@"%@/mobile/MyWatches_ByLimit/?id=%@&skey=%@&start=0&limit=10",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID];
                break;
            
        case 4:
            
                if(queue)
                {
                    dispatch_suspend(queue);
                }

            [JSWaiter HideWaiter];
                newFlag=NO;
                onlineFlag=NO;
                myWatchesFlag=NO;
                featuredFlag=YES;
                bookmarksFlag=NO;   
                lblTabName.text = @"Featured";
                        
                nameArray=[[NSMutableArray alloc]init];
                imageArray=[[NSMutableArray alloc]init];
                ageArray=[[NSMutableArray alloc]init];
                placeArray=[[NSMutableArray alloc]init];
                countryName=[[NSMutableArray alloc]init];
                gender=[[NSMutableArray alloc]init];
                thumbPicURLs=[[NSMutableArray alloc]init ];
                profileID=[[NSMutableArray alloc] init];
                genderIdArray=[[NSMutableArray alloc] init];
                [table reloadData]; 
                selectedtab=5;
                urlReq=[NSString stringWithFormat:@"%@/mobile/Featured_MembersByLimit/?id=%@&skey=%@&start=0&limit=10",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID];
                break;
            
        case 5:    
            
                if(queue)
                {
                    dispatch_suspend(queue);
                }

            [JSWaiter HideWaiter];
                newFlag=NO;
                onlineFlag=NO;
                myWatchesFlag=NO;
                featuredFlag=NO;
                bookmarksFlag=YES;
                lblTabName.text = @"Bookmarked";
            
                            
                nameArray=[[NSMutableArray alloc]init];
                imageArray=[[NSMutableArray alloc]init];
                ageArray=[[NSMutableArray alloc]init];
                placeArray=[[NSMutableArray alloc]init];
                countryName=[[NSMutableArray alloc]init];
                gender=[[NSMutableArray alloc]init];
                thumbPicURLs=[[NSMutableArray alloc]init ];
                profileID=[[NSMutableArray alloc] init];
                genderIdArray=[[NSMutableArray alloc] init];
                [table reloadData];
                selectedtab=6;
                urlReq = [NSString stringWithFormat: @"%@/mobile/BookMarked_MembersByLimit/?pid=%@&skey=%@&start=0&limit=10",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID];
                break;
            
        default:
                break;
    }
    
    i=0;
      
    [JSWaiter ShowWaiter:self title:@"Loading..." type:0];
    [self performSelectorOnMainThread:@selector(WebRequest:) withObject:urlReq waitUntilDone:NO];
    self.view.userInteractionEnabled=NO;
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
        self.view.userInteractionEnabled=YES;
        
        NSDictionary *json = [[ret objectForKey:@"data"] JSONValue];
        NSString *messegeStr=(NSString*)[parsedData objectForKey:@"Message"];
        NSString *alertTitle = @"";
        
        if (newFlag)
        {
            newFlag = NO;
            alertTitle = @"New";
        }
        else if (onlineFlag)
        {
            onlineFlag = NO;
            alertTitle = @"Online";
        }
        else if (myWatchesFlag)
        {
            myWatchesFlag = NO;
            alertTitle = @"My Watches";
        }
        else if (featuredFlag)
        {
            featuredFlag = NO;
            alertTitle = @"Featured";
        }
        else if (bookmarksFlag)
        {
            bookmarksFlag = NO;
            alertTitle = @"Bookmarked";
        }
        
        if([messegeStr isEqualToString:@"Site suspended"])
        {
            ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Site suspended";
            UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Site suspended. Please try after sometime." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            sessionAlertView.tag=4;
            [sessionAlertView show];
            [sessionAlertView release];
            return;
        }
        else if ([messegeStr isEqualToString:@"Session Expired"])
        {
            ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Session Expired";
            
            UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Your session has expired. Please login again." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            sessionAlertView.tag=4;
            [sessionAlertView show];
            [sessionAlertView release];
            return;
        }
        else if ([messegeStr isEqualToString:@"Membership denied"]||[messegeStr isEqualToString:@"Membership Denied"])
        {
            NSString *alertstr=[NSString stringWithFormat:@"Please upgrade your membership to view the %@ members",alertTitle];
            
            UIAlertView *MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[alertstr description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [MembershipAlertView show];
            [MembershipAlertView release];
            return;
        }
        
        NSString *resultCount = (NSString*)[parsedData objectForKey:@"count"];
        countTotal = (NSString*)[parsedData objectForKey:@"Total rows"];
        totalCounts=[countTotal intValue];
        
        if ([resultCount intValue] == 0 )
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle message:[@"No members found." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
        }
        else
        {
            imageArray=[[NSMutableArray alloc]init];
            NSArray *profileIDs = [json valueForKeyPath:@"result.profile_id"];
            
            if (profileID!=nil)
            {
                [profileID addObjectsFromArray:profileIDs];
            }
            else
            {
                profileID=[[NSMutableArray alloc] initWithArray:profileIDs copyItems:YES];
            }
            
            NSArray *username = [json valueForKeyPath:@"result.username"];
            if (nameArray!=nil)
            {
                [nameArray addObjectsFromArray:username];
            }
            else
            {
                nameArray=[[NSMutableArray alloc] initWithArray:username copyItems:YES];
            }
            
            gender=[[NSMutableArray alloc]init];
            NSArray *genders = [json valueForKeyPath:@"result.sex"];
            if (genderIdArray!=nil)
            {
                [genderIdArray addObjectsFromArray:genders];
            }
            else
            {
                genderIdArray=[[NSMutableArray alloc] initWithArray:genders copyItems:YES];
            }
            
            for (int j=0; j<[genderIdArray count]; j++)
            {
                NSString *str=[genderIdArray objectAtIndex:j];
                if (([genderIdArray objectAtIndex:j]== (id)[NSNull null])||([genderIdArray objectAtIndex:j]==NULL)||([[genderIdArray objectAtIndex:j] isEqual:@""])||([[genderIdArray objectAtIndex:j] length]==0))
                {
                    str=@"";
                }else{
                    int intVal=[str intValue];
                    str=[self returnGender:intVal];
                }
                [gender addObject:str];
            }
            
            NSArray *birthdate = [json valueForKeyPath:@"result.DOB"];
            if (ageArray!=nil)
            {
                [ageArray addObjectsFromArray:birthdate];
            }
            else
            {
                ageArray=[[NSMutableArray alloc] initWithArray:birthdate copyItems:YES];
            }
            
            NSArray *customLocation = [json valueForKeyPath:@"result.custom_location"];
            if (placeArray!=nil)
            {
                [placeArray addObjectsFromArray:customLocation];
            }
            else
            {
                placeArray=[[NSMutableArray alloc] initWithArray:customLocation copyItems:YES];
            }
            
            NSArray *countryId = [json valueForKeyPath:@"result.Country_str_name"];
            if (countryName!=nil)
            {
                [countryName addObjectsFromArray:countryId];
            }
            else
            {
                countryName=[[NSMutableArray alloc] initWithArray:countryId copyItems:YES];
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
            [table reloadData];
            
        }
    }
    [JSWaiter HideWaiter];
}

#pragma mark Alert View Delegate

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{         
    if(actionSheet.tag==4&&buttonIndex==0)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark IBActions

-(IBAction)clickedSearchButton:(id) sender
{    
    firstTime=NO;
    objSearchMembersView=[[SearchMembersView alloc]initWithNibName:@"SearchMembersView" bundle:nil];
    
    if ([lblTabName.text isEqualToString:@"New"])
    {
        objSearchMembersView.fromView=2;
    }
    else if ([lblTabName.text isEqualToString:@"Online"])
    {
        objSearchMembersView.fromView=3;
    }
    else if ([lblTabName.text isEqualToString:@"My Watches"])
    {
        objSearchMembersView.fromView=4;
    }
    else if ([lblTabName.text isEqualToString:@"Featured"])
    {
        objSearchMembersView.fromView=5;
    }
    else if ([lblTabName.text isEqualToString:@"Bookmarked"])
    {
        objSearchMembersView.fromView=6;
    }
    
    if(queue)
    {
        dispatch_suspend(queue);
    }
    
    [self.navigationController pushViewController:objSearchMembersView animated:NO];
    [objSearchMembersView release];
    
} 

-(IBAction)clickedHomeButton:(id) sender
{    
    if(queue)
    {
        dispatch_suspend(queue);
    }
    
    NSArray *viewControllers=[[self navigationController] viewControllers];
    for(int j=0;j<[ viewControllers count];j++)
    {
        id obj=[viewControllers objectAtIndex:j];
        if([obj isKindOfClass:[HomeView class]] )
        {
            [[self navigationController] popToViewController:obj animated:YES];
            return;
        }
    }
    
}

#pragma mark Table View Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (nameArray.count==0)
    {
        return  totalCounts;
    }
    else if (nameArray.count<totalCounts) 
    {
        return ([nameArray count]+1);
    }
    else
        return [nameArray count];
}


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell;
    cell = nil;
          
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone ; 
    
    if (indexPath.section==0) 
    {
        lstRow= [nameArray count];
        if (indexPath.row==lstRow) 
        {
            if (lstRow<totalCounts) 
            {
                 if (lstRow!=0) 
                 {
                     CGRect frameName =CGRectMake(115,35, 120,22 );
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
                     CGRect frameName1 =CGRectMake(115,((35+lblOfName.frame.size.height)-4), expectedLabelSize.width, 1);
                     UIView *viewUnderline=[[UIView alloc]initWithFrame:frameName1];
                     viewUnderline.backgroundColor=[UIColor darkGrayColor];
                     [ cell.contentView addSubview: viewUnderline];
                     [viewUnderline release];
                 }
                
            }
            
        }
        else if(indexPath.row<lstRow)
        {
            if (nameArray!=NULL) 
            {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                UIImageView *imgview=[[[UIImageView alloc]initWithFrame:CGRectMake(7, 12, 60, 60)] autorelease];        
                [cell addSubview:imgview];
                imgview.layer.cornerRadius=10.0;
                imgview.layer.masksToBounds=YES;
                imgview.image=[UIImage imageNamed:@"ImageLoading.png"];
                [imageArray addObject:imgview.image];
          
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
                            if([genderIdArray count]>0)
                            {
                                if ( ([genderIdArray objectAtIndex:indexPath.row] == (id)[NSNull null])
                                    || ([genderIdArray objectAtIndex:indexPath.row] == NULL)
                                    || ([[genderIdArray objectAtIndex:indexPath.row] isEqual:@""])
                                    || ([[genderIdArray objectAtIndex:indexPath.row] length] == 0) )
                                {                                                      
                                    imgview.image=[UIImage imageNamed:@"man.png"];
                                }
                                else
                                {
                                    if ([[genderIdArray objectAtIndex:indexPath.row] intValue]==1) 
                                    {
                                        imgview.image=[UIImage imageNamed:@"women.png"];
                                    }
                                    else if ([[genderIdArray objectAtIndex:indexPath.row] intValue]==2) 
                                    {
                                        imgview.image=[UIImage imageNamed:@"man.png"];
                                    }
                                    else if ([[genderIdArray objectAtIndex:indexPath.row] intValue]==4) 
                                    {
                                        imgview.image=[UIImage imageNamed:@"man_women.png"];
                                    }
                                    else if ([[genderIdArray objectAtIndex:indexPath.row] intValue]==8) 
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
                
                CGRect frameName =CGRectMake(75,10, 190,22 );
                lblOfName=[[UILabel alloc]initWithFrame:frameName];
                lblOfName.backgroundColor=[UIColor clearColor];
               
                if (([nameArray objectAtIndex:indexPath.row]== (id)[NSNull null])||([nameArray objectAtIndex:indexPath.row]==NULL))
                {
                    lblOfName.text=@"";
                }
                else
                {
                    lblOfName.text=[nameArray objectAtIndex:indexPath.row];
                }
                
                lblOfName.font=[UIFont fontWithName:@"Ubuntu-Bold" size:17];
                lblOfName.textColor =[UIColor blackColor]; 
                lblOfName.textAlignment=UITextAlignmentLeft;
                [ cell.contentView addSubview: lblOfName];
                [lblOfName release];
                CGRect frameAge=CGRectMake(75,35, 190,17 );
                lblOfAge=[[UILabel alloc]initWithFrame:frameAge];
                lblOfAge.backgroundColor=[UIColor clearColor];
                lblOfAge.tag=1;
               
                if (([ageArray objectAtIndex:indexPath.row]== (id)[NSNull null])||([ageArray objectAtIndex:indexPath.row]==NULL))
                {
                    lblOfAge.text=@"";
                }
                else 
                {
                    lblOfAge.text=[ageArray objectAtIndex:indexPath.row];
                }
                
                if (([gender objectAtIndex:indexPath.row]== (id)[NSNull null])||([gender objectAtIndex:indexPath.row]==NULL))
                {
                    lblOfAge.text=[NSString stringWithFormat:@"%@ years old",lblOfAge.text];
                }
                else 
                {
                    lblOfAge.text=[NSString stringWithFormat:@"%@, %@ years old",[gender objectAtIndex:indexPath.row],lblOfAge.text];
                }
                
                lblOfAge.font=[UIFont boldSystemFontOfSize:13];
                lblOfAge.textColor =[UIColor darkGrayColor]; 
                lblOfAge.textAlignment=UITextAlignmentLeft;
                [ cell.contentView addSubview: lblOfAge];
                CGRect framePlace=CGRectMake(75,52, 190,17 );
                lblOfPlace=[[UILabel alloc]initWithFrame:framePlace];
                lblOfPlace.backgroundColor=[UIColor clearColor];
                lblOfPlace.tag = 2;
               
                if (([placeArray objectAtIndex:indexPath.row]== (id)[NSNull null])||([placeArray objectAtIndex:indexPath.row]==NULL)) 
                {
                    lblOfPlace.text=@"";
                }
                else 
                {
                    lblOfPlace.text=[NSString stringWithFormat:@"%@,",[placeArray objectAtIndex:indexPath.row]];
                }
    
    
                lblOfPlace.font=[UIFont fontWithName:@"Helvetica" size:14];
                lblOfPlace.textColor =[UIColor darkGrayColor]; 
                lblOfPlace.textAlignment=UITextAlignmentLeft;
                [ cell.contentView addSubview: lblOfPlace];
                [lblOfPlace release];
                CGRect frameCountry=CGRectMake(75,70, 190,17 );
                lblOfCountry=[[UILabel alloc]initWithFrame:frameCountry];
                lblOfCountry.backgroundColor=[UIColor clearColor];

                if (([countryName objectAtIndex:indexPath.row]== (id)[NSNull null])||([countryName objectAtIndex:indexPath.row]==NULL)) 
                {
                    lblOfCountry.text=@"";
                }
                else 
                {
                    lblOfCountry.text=[countryName objectAtIndex:indexPath.row];
                }
                
                lblOfCountry.font=[UIFont fontWithName:@"Helvetica" size:14];
                lblOfCountry.textColor =[UIColor darkGrayColor]; 
                lblOfCountry.textAlignment=UITextAlignmentLeft;
                [ cell.contentView addSubview: lblOfCountry];
            }
            
        }
        
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{    
    firstTime=YES;
    NSString *profileId=[profileID objectAtIndex:indexPath.row];
    ProfileView *objProfileView=[[ProfileView alloc]initWithNibName:@"ProfileView" bundle:nil];
    objProfileView.profileID=profileId;
    objProfileView.selectImg=selectedtab;
    [self.navigationController pushViewController:objProfileView animated:YES];
    [objProfileView release];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    if (indexPath.section==0) 
    {
        lstRow= [nameArray count];
        
        if (indexPath.row==lstRow)
        {
            if ( selectedtab==3)
            {
                urlReq=[NSString stringWithFormat:@"%@/mobile/New_MembersByLimit/?id=%@&skey=%@&start=%i&limit=10",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedSessionID,lstRow];
            }
            else if( selectedtab==2)
            {
                urlReq=[NSString stringWithFormat:@"%@/mobile/Online_MembersByLimit/?id=%@&skey=%@&start=%i&limit=10",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID,lstRow];   
            }
            else if( selectedtab==4)
            {
                urlReq=[NSString stringWithFormat:@"%@/mobile/MyWatchesByLimit/?id=%@&skey=%@&start=%i&limit=10",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID,lstRow];  
            }
            else if(selectedtab==5)
            {
                urlReq=[NSString stringWithFormat:@"%@/mobile/Featured_MembersByLimit/?id=%@&skey=%@&start=%i&limit=10",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID,lstRow];
            }
            else if( selectedtab==6)
            {
                urlReq = [NSString stringWithFormat: @"%@/mobile/BookMarked_MembersByLimit/?pid=%@&skey=%@&start=%i&limit=10",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID,lstRow];
            }
            
            i=0;
            [JSWaiter ShowWaiter:self title:@"Loading..." type:0];
            [self performSelectorOnMainThread:@selector(WebRequest:) withObject:urlReq waitUntilDone:NO];
        }
        else
        {            
            firstTime=YES;
            NSString *profileId=[profileID objectAtIndex:indexPath.row];
            
            NSString *loggedProfileID=((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID ;
            
            if ([profileId  isEqualToString:loggedProfileID])
            {
                MyProfileView *objMyProfileView=[[MyProfileView alloc]initWithNibName:@"MyProfileView" bundle:nil];
                objMyProfileView.profileID=loggedProfileID;
                [self.navigationController pushViewController:objMyProfileView animated:YES];
                [objMyProfileView release];
            }
            else
            {
                ProfileView *objProfileView=[[ProfileView alloc]initWithNibName:@"ProfileView" bundle:nil];
                objProfileView.profileID=profileId;
                objProfileView.selectImg=selectedtab;
                [self.navigationController pushViewController:objProfileView animated:YES];
                [objProfileView release];
            }
                        
        }
        
    }
    
}


#pragma mark Scroll View Delegate

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView 
{    
    i=0;
    prevIndexPath = nil;
    selectedRowIndex = 0;
}




@end
