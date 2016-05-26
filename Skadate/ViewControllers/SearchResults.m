//
//  SearchResults.m
//  Skadate
//
//  Created by SODTechnologies on 25/08/11.
//  Copyright 2011 Solutions On Demand Australasia Pty Ltd. All rights reserved.
//

#import "SearchResults.h"
#import "HomeView.h"
#import "JSON.h"
#import "ProfileView.h"
#import "SkadateAppDelegate.h"
#import "CommonStaticMethods.h"

@implementation SearchResults
@synthesize imageArray; 
@synthesize nameArray; 
@synthesize ageArray; 
@synthesize placeArray; 
@synthesize countryName; 
@synthesize table; 
@synthesize btnSaved; 
@synthesize btnBackForSearchResults;
@synthesize profileID;
@synthesize gender,genderIdArray;
@synthesize urlReq,objChatMembersView,objSearchMembersView,objComposeMessageView;
@synthesize txtFldInAlert;
@synthesize myAlert;
@synthesize lblOfAge,lblOfName,lblOfPlace,lblOfCountry,lblOfAgeNew,lblOfPlaceNew;
@synthesize prevIndexPath,searchsavedflag,domain,parsedData;
@synthesize resultCount,countTotal;
@synthesize ResultType;
@synthesize  NewXval;

#pragma mark Memory Management

- (void)dealloc
{
    [profileID release];
    [nameArray release];
    [imageArray release];
    [ageArray release];
    [placeArray release];
    [countryName release];
    [gender release];
    dispatch_release(queue);
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data; @synthesize  images, etc that aren't in use.
}

- (void) doesAlertViewExist 
{        
    for (UIWindow* window in [UIApplication sharedApplication].windows) 
    {
        for (UIView* view in window.subviews) 
        {
            BOOL alert = [view isKindOfClass:[UIAlertView class]];
                        
            if (alert )
            {    
                if(view.tag==4)
                {
                    [(UIAlertView *)view dismissWithClickedButtonIndex:0 animated:YES];
                }
                                  
            }
            
        }
    }
    
}


-(void)DismissSaveAlertView:(id)sender
{   
    [self doesAlertViewExist ];    
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

#pragma mark View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

- (void)viewDidLoad
{
    [super viewDidLoad];
    queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    isLoading=YES;
    btnSaved.enabled=NO;
    btnBackForSearchResults.enabled=NO;
    self.navigationController.navigationBarHidden=YES;
    selectedRowIndex = 0;
    saveFlag=NO;
    saveBookMark=NO;    
    count = 0;
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(DismissSaveAlertView:)
     name:@"DismissSaveResultsAlertView" object:nil];
        
    respData = [[NSMutableData data] retain];
    [navBar setTintColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavbar/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavbar/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavbar/255.0 alpha:1.0]];
    navBar.layer.borderColor=[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavBorder/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavBorder/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavBorder/255.0 alpha:1.0].CGColor;
    navBar.layer.borderWidth=1.0f;
    searchresultslable.font= ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontNavTitle;
    [searchresultslable setTextAlignment:UITextAlignmentCenter];
    searchresultslable.text=@"Search Results";
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    domain = [prefs stringForKey:@"URL"];
   
    if (searchsavedflag)
    {
        btnSaved.hidden=YES;
        searchsavedflag=NO;
        ResultType=@"Result";
    }
    else
    {
        ResultType=@"Search";  
    }
    
    [urlReq retain];
    NSString *urlReq1;
    urlReq1=[urlReq stringByAppendingString:@"&start=0&limit=10"]; 

    [JSWaiter ShowWaiter:self title:@"Loading..." type:0];
    [self performSelectorOnMainThread:@selector(WebRequest:) withObject:urlReq1 waitUntilDone:NO];
    self.view.userInteractionEnabled=NO;
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
        
        [self doesAlertViewExist];
              
        return YES;
    }
    else
    {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    }*/
}

#pragma mark AlertView Delegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex 
{        
    if (buttonIndex == 1) 
    {
        [txtFldInAlert resignFirstResponder];
    }
}



#pragma mark AlertView Delegate


//to set the alertView frame size.
- (void)willPresentAlertView:(UIAlertView *)alertView
{
    if (alertView.tag==4) 
    {      
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            //[alertView setFrame:CGRectMake(10, 100, 300, 150)];
            [alertView setFrame:CGRectMake(10, 100, 300, 150)];
        }
        else
        {              
            if (self.interfaceOrientation==UIDeviceOrientationLandscapeRight || self.interfaceOrientation==UIDeviceOrientationLandscapeLeft)
            {            
                [alertView setFrame:CGRectMake(380, 100, 300, 150)];
            }
            else
            {           
                [alertView setFrame:CGRectMake(230, 100, 300, 150)];
            }
        }
    
        for ( UIView *views in [alertView subviews])
        {        
            if (views.tag == 1 || views.tag == 2)
            {
                [views setFrame:CGRectMake(views.frame.origin.x+8, views.frame.origin.y+30, views.frame.size.width, views.frame.size.height)];
            }
        }
    
    }
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{    
    if (actionSheet.tag == 4)
    {
        if (buttonIndex == 0) 
        {
            NSString *rawString = [txtFldInAlert text];
            NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
            NSString *trimmed = [rawString stringByTrimmingCharactersInSet:whitespace];
            if ([trimmed length] == 0) 
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[@"Search cannot be saved without a name. Kindly retry with a name." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
                [alertView release];
                return;
            }
            else
            {
                // For checking white space
                NSString *trimmedString = [txtFldInAlert.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                if ([trimmedString length]==0) 
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[@"Search cannot be saved using blank space. Kindly retry with a name for search." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alertView show];
                    [alertView release];
                    return;
                }
                // For removing leading and ending white space
                NSString *trimmedText = [txtFldInAlert.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                if ([trimmedText length]>25) 
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[@"Name should not exceed 25 characters." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alertView show];
                    [alertView release];
                    return;
                }
                txtFldInAlert.text=@"";
                txtFldInAlert.text=trimmedText;
                isLoading=YES;
                saveFlag=YES;
                
                // replacing the string with new string
                NSString *urlReqSave = [urlReq stringByReplacingOccurrencesOfString:@"SearchByLimit"
                                                                         withString:@"SaveSearch"];
                //appending the new string to the existing string
                urlReqSave=[NSString stringWithFormat:@"%@&name=%@",urlReqSave, txtFldInAlert.text];
                [JSWaiter ShowWaiter:self title:@"Loading..." type:0];
                [self performSelectorOnMainThread:@selector(WebRequest:) withObject:urlReqSave waitUntilDone:NO];
                self.view.userInteractionEnabled=NO;
            }
        }
    }
    else if(actionSheet.tag==5&&buttonIndex==0)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else if(actionSheet.tag==6&&buttonIndex==0)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark IBActions

-(IBAction)clickedBackForSearchResultsButton:(id)sender
{
    if(queue)
    {
        dispatch_suspend(queue);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)clickedSavedButton: (id) sender
{
    if (isLoading) 
    {
        return;
    }
    
    myAlert = [[UIAlertView alloc] initWithTitle:@"Save This Result" message:nil delegate:self cancelButtonTitle:@"Save" otherButtonTitles:@"Cancel", nil];
 
    txtFldInAlert = [[UITextField alloc] initWithFrame:CGRectMake(15, 50, 270, 20)];
    
      
    CGAffineTransform myTransform = CGAffineTransformMakeTranslation(0, 60);
          
    [myAlert setTransform:myTransform];
    myAlert.tag = 4;
    txtFldInAlert.placeholder = @"Title";
    txtFldInAlert.keyboardAppearance = UIKeyboardAppearanceAlert;
    txtFldInAlert.autocorrectionType = UITextAutocorrectionTypeNo;
    txtFldInAlert.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtFldInAlert.returnKeyType = UIReturnKeyDone;
    txtFldInAlert.delegate = self;    
    [txtFldInAlert becomeFirstResponder];
    [txtFldInAlert setBackgroundColor:[UIColor whiteColor]];
    txtFldInAlert.delegate = self;
    [myAlert becomeFirstResponder];
    [myAlert addSubview:txtFldInAlert];
    [myAlert show];
    [myAlert release];
    [txtFldInAlert retain];  
    
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
        btnSaved.enabled=YES;
        isLoading=NO;
        btnBackForSearchResults.enabled=YES;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Connection failed...Please launch the application again." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
    else
    {
        parsedData = (NSDictionary *)[ret objectForKey:@"data"];
        self.view.userInteractionEnabled=YES;
        btnSaved.enabled=YES;
        isLoading=NO;
        btnBackForSearchResults.enabled=YES;
        if (saveFlag)
        {
            saveFlag=NO;
            NSString *criterion=(NSString*)[parsedData objectForKey:@"Criterion"];
            NSString *messegeStr=(NSString*)[parsedData objectForKey:@"Message"];
            if ((criterion==(id)[NSNull null]) || [criterion isEqualToString:@""] || [criterion isEqualToString:@"0"])
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[@"Cannot save the search now. Please try after sometime." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
                [alertView release];
            }
            else if([messegeStr isEqualToString:@"Site suspended"])
            {
                ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Site suspended";
                UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Site suspended. Please try after sometime." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
                sessionAlertView.tag=5;
                [sessionAlertView show];
                [sessionAlertView release];
                return;
            }
            else if([messegeStr isEqualToString:@"Session Expired"])
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
                UIAlertView *MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Please upgrade your membership to save  the search." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [MembershipAlertView show];
                [MembershipAlertView release];
                return;
            }
            else if([messegeStr isEqualToString:@"Name already exist"])
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[@"Name already exist. Please save with another name" description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
                [alertView release];
                return;
            }
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[@"Successfully saved the Search." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
                [alertView release];
            }
        }
        else
        {
            imageArray=[[NSMutableArray alloc]init];
            gender=[[NSMutableArray alloc]init];
            NSDictionary *json = [[ret objectForKey:@"text"] JSONValue];
            NSString *messegeStr=(NSString*)[parsedData objectForKey:@"Message"];
            
            //For checking session validation
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
            else if ([resultCount intValue] == 0 )
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[@"No results for this search." description] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
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
                
                NSArray *customLocation = [json valueForKeyPath:@"result.custom_location"];
                if (placeArray==nil)
                {
                    placeArray=[[NSMutableArray alloc] initWithArray:customLocation copyItems:YES];
                }
                else
                {
                    [placeArray addObjectsFromArray:customLocation];
                }
                
                NSArray *countryId = [json valueForKeyPath:@"result.Country_str_name"];
                if (countryName==nil) 
                {
                    countryName=[[NSMutableArray alloc] initWithArray:countryId copyItems:YES];
                }
                else
                {
                    [countryName addObjectsFromArray:countryId];
                }
                
            }  
            
            [table reloadData];
        }
    }
    [JSWaiter HideWaiter];
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{    
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{    
    
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
            lblOfAge.backgroundColor=[UIColor clearColor];
            lblOfAge.textAlignment=UITextAlignmentLeft;
            [ cell.contentView addSubview: lblOfAge];
            CGRect framePlace=CGRectMake(75,52, 190,15 );
            lblOfPlace=[[UILabel alloc]initWithFrame:framePlace];
            lblOfPlace.tag = 2;
            
            if (([placeArray objectAtIndex:indexPath.row]== (id)[NSNull null])||([placeArray objectAtIndex:indexPath.row]==NULL)) 
            {
                lblOfPlace.text=@"";
            }
            else
            {
                lblOfPlace.text=[placeArray objectAtIndex:indexPath.row];
            }
            
            lblOfPlace.font=[UIFont fontWithName:@"Helvetica" size:14];
            lblOfPlace.textColor =[UIColor darkGrayColor]; 
            lblOfPlace.textAlignment=UITextAlignmentLeft;
            lblOfPlace.backgroundColor=[UIColor clearColor];
            [ cell.contentView addSubview: lblOfPlace];
            [lblOfPlace release];
            CGRect frameCountry=CGRectMake(75,70, 190,15 );
            lblOfCountry=[[UILabel alloc]initWithFrame:frameCountry];
            
            if (([countryName objectAtIndex:indexPath.row]== (id)[NSNull null])||([countryName objectAtIndex:indexPath.row]==NULL))
            {
                lblOfCountry.text=@"";
            }
            else
            {
                lblOfCountry.text=[countryName objectAtIndex:indexPath.row];
            }
            
            lblOfCountry.font=[UIFont fontWithName:@"Helvetica" size:14];
            lblOfCountry.backgroundColor=[UIColor clearColor];
            lblOfCountry.textColor =[UIColor darkGrayColor]; 
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
    objProfileView.selectImg=1;
   
    if ([ResultType isEqualToString:@"Result"]) 
    {
        objProfileView.resultType=@"Result";
    }
    else
    {
        objProfileView.resultType=@"Search";        
    }
    
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
            NSString *urlReq1;
            NSString *urlStartAndLimits=[NSString stringWithFormat: @"&start=%i&limit=10",[nameArray count]];
            urlReq1=[urlReq stringByAppendingString:urlStartAndLimits]; 
            [urlReq retain];
            [JSWaiter ShowWaiter:self title:@"Loading..." type:0];
            [self performSelectorOnMainThread:@selector(WebRequest:) withObject:urlReq waitUntilDone:NO];
            self.view.userInteractionEnabled=NO;
        }
        else
        {
            NSString *profileId=[profileID objectAtIndex:indexPath.row];
            searchResultFlag=YES;
            ProfileView *objProfileView=[[ProfileView alloc]initWithNibName:@"ProfileView" bundle:nil];
            objProfileView.profileID=profileId;
            objProfileView.selectImg=1;
           
            if ([ResultType isEqualToString:@"Result"]) 
            {
                objProfileView.resultType=@"Result";
            }
            else
            {
                objProfileView.resultType=@"Search";        
            }
            
            [self.navigationController pushViewController:objProfileView animated:YES];
            [objProfileView release];
        }
        
    }
    
}


#pragma mark ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView 
{    
    i=0;
    prevIndexPath = nil;
    selectedRowIndex = 0;
}



@end
