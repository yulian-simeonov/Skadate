//
//  MyNeighboursSearchResults.m
//  Skadate
//
//  Created by SODTechnologies on 25/08/11.
//  Copyright 2011 Solutions On Demand Australasia Pty Ltd. All rights reserved.
//

#import "MyNeighboursSearchResults.h"
#import "HomeView.h"
#import "JSON.h"
#import "ProfileView.h"
#import "SkadateAppDelegate.h"
#import "CommonStaticMethods.h"
#import "MyProfileView.h"

@implementation MyNeighboursSearchResults
@synthesize imageArray; 
@synthesize nameArray; 
@synthesize ageArray; 
@synthesize placeArray; 
@synthesize lngArray; 
@synthesize table; 
@synthesize btnBack;
@synthesize profileID;
@synthesize gender,genderIdArray;
@synthesize urlReq;
@synthesize txtFldInAlert;
@synthesize myAlert;
@synthesize lblOfAge,lblOfName,lblOfPlace,lblOfCountry,lblOfAgeNew,lblOfPlaceNew;
@synthesize prevIndexPath,domain,parsedData;
@synthesize resultCount,countTotal,latArray;
@synthesize NewXval;


#pragma mark Memory Management

- (void)dealloc
{    
    [profileID release];
    [nameArray release];
    [imageArray release];
    [ageArray release];
    [placeArray release];
    [lngArray release];
    [gender release];
    [latArray release];
    dispatch_release(queue);
    [super dealloc];
    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data; @synthesize  images, etc that aren't in use.
}


#pragma mark Custom Methods


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

#pragma mark View lifecycle


- (void)viewDidLoad
{
       
    [super viewDidLoad];
    
    queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    isLoading=YES;
    self.navigationController.navigationBarHidden=YES;
    selectedRowIndex = 0;
     
    count = 0;
    [navBar setTintColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavbar/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavbar/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavbar/255.0 alpha:1.0]];
    navBar.layer.borderColor=[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavBorder/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavBorder/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavBorder/255.0 alpha:1.0].CGColor;
    navBar.layer.borderWidth=1.0f;

    searchresultslable.font= ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontNavTitle;
    [searchresultslable setTextAlignment:UITextAlignmentCenter];
    searchresultslable.text=@"My Neighbours";
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    domain = [prefs stringForKey:@"URL"];
    
    [urlReq retain];
        
    NSUserDefaults *MyLoc=[NSUserDefaults standardUserDefaults];
    double latVal=[MyLoc doubleForKey:@"lat"];
    double lngVal=[MyLoc doubleForKey:@"lng"];
                
    urlReq = [NSString stringWithFormat: @"%@/mobile/maplocation/?pid=%@&lon=%f&lat=%f&skey=%@",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,lngVal,latVal,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID];
    
    NSString *urlReq1;
    urlReq1=[urlReq stringByAppendingString:@"&start=0&limit=10"]; 
           
    [self performSelectorOnMainThread:@selector(WebRequest:) withObject:urlReq1 waitUntilDone:NO];
    [JSWaiter ShowWaiter:self title:@"Loading..." type:0];
    self.view.userInteractionEnabled=NO;

}

-(void) viewWillDisappear:(BOOL)animated 
{        
    [[NSNotificationCenter defaultCenter]
	 removeObserver:self];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [imageArray release];
    
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


#pragma mark IBActions

-(IBAction)clickedBackButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark Alert View Delegate

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex 
{    
   if(actionSheet.tag==5&&buttonIndex==0)
    {        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
    else if(actionSheet.tag==6&&buttonIndex==0)
    {        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}

#pragma mark Text Field Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField 
{
    if ([textField isFirstResponder]) 
    {
        [textField resignFirstResponder];
    } 
    else 
    {
        [textField becomeFirstResponder];
        [textField resignFirstResponder];
    }
    return YES;
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
        isLoading=NO;
        btnBack.enabled=YES;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Connection failed...Please launch the application again." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
    else
    {
        self.view.userInteractionEnabled=YES;
        isLoading=NO;
        btnBack.enabled=YES;
        parsedData = (NSDictionary *)[ret objectForKey:@"data"];
        imageArray=[[NSMutableArray alloc]init];
        gender=[[NSMutableArray alloc]init];
        NSDictionary *json = [[ret objectForKey:@"text"] JSONValue];
        
        NSString *messegeStr=(NSString*)[parsedData objectForKey:@"Message"];
        resultCount = (NSString*)[parsedData objectForKey:@"count"];
        count=[resultCount intValue];
        countTotal = (NSString*)[parsedData objectForKey:@"Total rows"];
        totalCount=[countTotal intValue];
        
        if([messegeStr isEqualToString:@"Site suspended"])
        {
            ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Site suspended";
            
            UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Site suspended. Please try after sometime." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            sessionAlertView.tag=5;
            [sessionAlertView show];
            [sessionAlertView release];
            return;
            
        }
        else if ([messegeStr isEqualToString:@"Session Expired"])
        {
            ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Session Expired";
            
            UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Your session has expired. Please login again." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            sessionAlertView.tag=5;
            [sessionAlertView show];
            [sessionAlertView release];
            return;
            
        }
        else if ([messegeStr isEqualToString:@"Membership denied"]||[messegeStr isEqualToString:@"Membership Denied"])
        {
            UIAlertView *MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Please upgrade your membership to search members." description] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            MembershipAlertView.tag=6;
            [MembershipAlertView show];
            [MembershipAlertView release];
            return;
            
        }
        else if (([messegeStr isEqualToString:@"Error"])||([messegeStr isEqualToString:@"Failure"]))
        {
            UIAlertView *MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Failed to retrieve data from the site. Kindly try again after some time!" description] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            MembershipAlertView.tag=6;
            [MembershipAlertView show];
            [MembershipAlertView release];
            return;
            
        }
        else if ([resultCount intValue] == 0 )
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[@"No data found." description] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alertView.tag=6;
            [alertView show];
            [alertView release];
            
        }
        else
        {
            profileIDs = [json valueForKeyPath:@"result.profile_id"];
            if (profileID==nil)
                
            {
                profileID=[[NSMutableArray alloc] initWithArray:profileIDs copyItems:YES];
            }
            else
            {
                [profileID addObjectsFromArray:profileIDs];
            }
            
            username = [json valueForKeyPath:@"result.username"];
            if (nameArray==nil)
            {
                nameArray=[[NSMutableArray alloc] initWithArray:username copyItems:YES];
            }
            else
            {
                [nameArray addObjectsFromArray:username];
            }
            
            genders = [json valueForKeyPath:@"result.sex"];
            if (genderIdArray==nil)
            {
                genderIdArray=[[NSMutableArray alloc] initWithArray:genders copyItems:YES];
            }
            else
            {
                [genderIdArray addObjectsFromArray:genders];
            }
            
            picURLs = [json valueForKeyPath:@"result.Profile_Pic"];
            if (thumbPicURLs==nil)
            {
                thumbPicURLs=[[[NSMutableArray alloc] initWithArray:picURLs copyItems:YES] retain];
            }
            else
            {
                [thumbPicURLs addObjectsFromArray:picURLs];
            }
            
            for (int j=0; j<[genderIdArray count]; j++)
            {
                NSString *str=[genderIdArray objectAtIndex:j];
                int intVal=[str intValue];
                str=[self returnGender:intVal];
                [gender addObject:str];
                
            }
            
            NSArray *birthdate = [json valueForKeyPath:@"result.DOB"];
            if (ageArray==nil)
            {
                ageArray=[[NSMutableArray alloc] initWithArray:birthdate copyItems:YES];
            }
            else
            {
                [ageArray addObjectsFromArray:birthdate];
            }
            
            
            NSArray *customLocation = [json valueForKeyPath:@"result.D"];
            if (placeArray==nil)
            {
                placeArray=[[NSMutableArray alloc] initWithArray:customLocation copyItems:YES];
            }
            else
            {
                [placeArray addObjectsFromArray:customLocation];
            }
            
            NSArray *lng_array = [json valueForKeyPath:@"result.longitude"];
            if (lngArray==nil)
            {
                lngArray=[[NSMutableArray alloc] initWithArray:lng_array copyItems:YES];
            }
            else
            {
                [lngArray addObjectsFromArray:lng_array];
            }
            
            NSArray *lat_array = [json valueForKeyPath:@"result.latitude"];
            if (latArray==nil) 
            {                
                latArray=[[NSMutableArray alloc] initWithArray:lat_array copyItems:YES];
            }
            else
            {
                [latArray addObjectsFromArray:lat_array];
            }
            
        }  
        
        [table reloadData];
    }
    [JSWaiter HideWaiter];
}

#pragma mark Table View Delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    
    if (nameArray.count<totalCount)
    {
        return ([nameArray count]+1);
    }
    else if(totalCount==0)
    {
        return 0;
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
    UITableViewCell *cell ;
    cell = nil;
   
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
       
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone ; 
          
    if (indexPath.section==0) 
    {
        int a=[nameArray count];
            
        if (indexPath.row==a) 
        {
            if (a<totalCount) 
            {
                if (totalCount!=0) 
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
        else if(indexPath.row<a)
        {                       
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                                   
            UIImageView *imgview=[[[UIImageView alloc]initWithFrame:CGRectMake(7, 12, 60, 60)] autorelease];
            imgview.layer.cornerRadius=10.0;
            imgview.layer.masksToBounds=YES;
            imgview.layer.borderColor = [UIColor lightGrayColor].CGColor;
            imgview.layer.borderWidth = 1.0;
            [cell.contentView addSubview:imgview ];
                
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
                        if (([genderIdArray objectAtIndex:indexPath.row] == (id)[NSNull null])
                            || ([genderIdArray objectAtIndex:indexPath.row] == NULL)
                            || ([[genderIdArray objectAtIndex:indexPath.row] isEqual:@""])
                            || ([[genderIdArray objectAtIndex:indexPath.row] length] ==0) )
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
                    
                });
            });  
   
         
            CGRect frameName =CGRectMake(75,10, 190,22 );
            lblOfName=[[UILabel alloc]initWithFrame:frameName];
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
            lblOfName.backgroundColor=[UIColor clearColor];
            lblOfName.textAlignment=UITextAlignmentLeft;
            [ cell.contentView addSubview: lblOfName];
            [lblOfName release];
            
            
            CGRect frameAge=CGRectMake(75,35, 190,15 );
            lblOfAge=[[UILabel alloc]initWithFrame:frameAge];
            lblOfAge.tag=1;
                                 
            if (([gender objectAtIndex:indexPath.row]== (id)[NSNull null])||([gender objectAtIndex:indexPath.row]==NULL)) 
            {               
                lblOfAge.text=@"";
            }
            else
            {        
                lblOfAge.text=[gender objectAtIndex:indexPath.row];
            }
    
            lblOfAge.font=[UIFont fontWithName:@"Helvetica" size:14];
            lblOfAge.textColor =[UIColor darkGrayColor];
            lblOfAge.backgroundColor=[UIColor clearColor];
            lblOfAge.textAlignment=UITextAlignmentLeft;
            [ cell.contentView addSubview: lblOfAge];
        
            CGRect framePlace=CGRectMake(75,52, 190,15 );
            lblOfPlace=[[UILabel alloc]initWithFrame:framePlace];
            lblOfPlace.tag = 2;
                                  
            if (([ageArray objectAtIndex:indexPath.row]== (id)[NSNull null])||([ageArray objectAtIndex:indexPath.row]==NULL)) 
            {
                lblOfPlace.text=@"";
            }
            else 
            {                
                lblOfPlace.text=[NSString stringWithFormat:@"%@ years old",[ageArray objectAtIndex:indexPath.row]];
            }
       
            lblOfPlace.font=[UIFont fontWithName:@"Helvetica" size:14];
            lblOfPlace.textColor =[UIColor darkGrayColor]; 
            lblOfPlace.textAlignment=UITextAlignmentLeft;
            lblOfPlace.backgroundColor=[UIColor clearColor];
            [ cell.contentView addSubview: lblOfPlace];
            [lblOfPlace release];
             
            CGRect frameCountry=CGRectMake(75,70, 190,15 );
            lblOfCountry=[[UILabel alloc]initWithFrame:frameCountry];
                             
            if (([placeArray objectAtIndex:indexPath.row]== (id)[NSNull null])||([placeArray objectAtIndex:indexPath.row]==NULL)) 
            {
                 lblOfCountry.text=@"";
            }
            else 
            {             
                 lblOfCountry.text=[NSString stringWithFormat:@"%@ kilometers away",[placeArray objectAtIndex:indexPath.row]];
            }
        
            lblOfCountry.font=[UIFont fontWithName:@"Helvetica-Bold" size:13];
            lblOfCountry.backgroundColor=[UIColor clearColor];
            lblOfCountry.textColor =[UIColor blackColor];
            lblOfCountry.textAlignment=UITextAlignmentLeft;
            [ cell.contentView addSubview: lblOfCountry];
          
        }
        
    }
    return cell;
    
}


- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *profileId=[profileID objectAtIndex:indexPath.row];
    searchResultFlag=YES;
    
    ProfileView *objProfileView=[[ProfileView alloc]initWithNibName:@"ProfileView" bundle:nil];
    objProfileView.profileID=profileId;
    objProfileView.selectImg=7;
    [self.navigationController pushViewController:objProfileView animated:YES];
    [objProfileView release];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{    
    if (indexPath.section==0) 
    {        
        if (indexPath.row==nameArray.count) 
        {           
            isLoading=YES;
                        
            NSUserDefaults *MyLoc=[NSUserDefaults standardUserDefaults];
            double latVal=[MyLoc doubleForKey:@"lat"];
            double lngVal=[MyLoc doubleForKey:@"lng"];
            
             urlReq = [NSString stringWithFormat: @"%@/mobile/maplocation/?pid=%@&lon=%f&lat=%f&skey=%@",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,lngVal,latVal,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID];
            
            NSString *urlStartAndLimits=[NSString stringWithFormat: @"&start=%i&limit=10",[nameArray count]];
            
            NSString *urlReq1;
            urlReq1=[urlReq stringByAppendingString:urlStartAndLimits]; 
                                
            [self performSelectorOnMainThread:@selector(WebRequest:) withObject:urlReq1 waitUntilDone:NO];
            [JSWaiter ShowWaiter:self title:@"Loading..." type:0];
            
            self.view.userInteractionEnabled=NO;
            
        }
        else
        {      
            NSString *profileId=[profileID objectAtIndex:indexPath.row];
            searchResultFlag=YES;
            
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
                objProfileView.selectImg=7;
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
