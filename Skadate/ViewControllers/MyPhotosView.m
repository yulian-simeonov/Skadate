//
//  MyPhotosView.m
//  Chk
//
//  Copyright 2011 Solutions On Demand Australasia Pty Ltd. All rights reserved.
//

#import "MyPhotosView.h"
#import "MyProfileView.h"
#import "PhotoFullView.h"
#import "JSON.h"
#import "NotificationsView.h"
#import "SkadateAppDelegate.h"
#import "CommonStaticMethods.h"


@implementation MyPhotosView

@synthesize btnCamera,btnHome,btnNotify,btnEdit,btnDelete;
@synthesize tempScrollView;
@synthesize dividerLineImage;
@synthesize flagHome;
@synthesize profileID;
@synthesize toolBar;
@synthesize imgNotification;
@synthesize thumbPicURLs;
@synthesize navBar;
@synthesize msgOrient,domain;
@synthesize _popover;
@synthesize imgBtn;
@synthesize queue;
@synthesize imageView;
@synthesize imgIDArr,selectedThumbPicURLs,selectedUrlArray;
@synthesize NewXval;

#pragma mark Memory Management

- (void)dealloc
{
    [imgIDArr release];
    [selectedThumbPicURLs release];
    [selectedUrlArray release];
    [thumbPicURLs release];
    [queue release];
    [deleteQueue release];
    imageData=nil;
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

-(void)loadImageAfterDeletion
{
    int imgX=4;
    int imgY=4;
    int colCount=1;
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    { 
        imgY=20;
        imgX=22;
    }
    for (int i=0; i<[thumbPicURLs count]; i++)
    {
        if(![queue isSuspended]) 
        {
            NSString *profilePicURL=[NSString stringWithFormat:@"%@%@",domain,[thumbPicURLs objectAtIndex:i]];
            NSString *imageName=[NSString stringWithFormat:@"%@",[thumbPicURLs objectAtIndex:i]];
            //imageName=[imageName stringByReplacingOccurrencesOfString:@"/$userfiles/" withString:@""]; // for old version
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
}

-(void)loadDefaultImage
{
    int imgX=4;
    int imgY=4;
    int colCount=1;
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        imgX=22;
        imgY=20;
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

-(void)loadImage 
{    
    int imgX=4;
    int imgY=4;
    int colCount=1;
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    { 
        imgX=22;
        imgY=20;
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

- (void)AllowEdit 
{
    if(![queue isSuspended]) 
    {
        [queue setSuspended:YES];
    }
    btnEdit.hidden=NO;
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

-(void)deletePhotos
{
    loadFlag=NO;
    notifFlag=0;
    NSString *selectedPhotoIdsToSend=[selectedThumbPicURLs componentsJoinedByString:@","];
    NSString *req = [NSString stringWithFormat:@"%@/mobile/Delete_photos/?pid=%@&skey=%@&Count=%d&photo_id=%@",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedSessionID,[selectedThumbPicURLs count],selectedPhotoIdsToSend];

    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:req, @"url", @"deletePhotoCon", @"meta", nil];
    [JSWaiter ShowWaiter:self title:@"Deleting..." type:0];
    [self performSelectorOnMainThread:@selector(WebRequest:) withObject:params waitUntilDone:NO];
}

-(void) Upload: (NSData*) photoData
{
    [myphotolab setText:@"My Photos"];
    [btnEdit setTitle:@"Edit" forState:normal];
    [btnEdit setImage:[UIImage imageNamed:@"Edit_myphoto.png"] forState:normal];
    btnDelete.hidden=YES;
    btnCamera.hidden=YES;
    toolBar.hidden=YES;
    btnDelete.enabled=NO;
    btnHome.hidden=NO;
    NSString *urlString =[NSString stringWithFormat:@"%@/mobile/UploadImage/index.php",domain];
    
    //Setting up the request object 
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    //Generate a random boundary
    NSString *boundary = @"M!M#b0UnD@RY!@#$%^&*936924809";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    //Create the body of the post
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[@"Content-Disposition: form-data; name=\"id\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"%@",profileID] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[@"Content-Disposition: form-data; name=\"skey\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"%@",((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: form-data; name=\"orientation\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"%@",msgOrient] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data;name=\"image\"; filename=\"%@\"\r\n",@"Image.jpg"] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:photoData]];
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];       
    
    // Setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // Make the connection to the web
    NSURLResponse *theResponse = [[NSURLResponse alloc]init];
    NSData *responseUpload = [NSURLConnection sendSynchronousRequest:request returningResponse:&theResponse error:nil];
    NSString *returnString = [[NSString alloc] initWithData:responseUpload encoding:NSUTF8StringEncoding];
    NSError *error;
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *parsedData = (NSDictionary *)[parser objectWithString:returnString error:&error];
    CFRelease((CFTypeRef) parser); 
    NSString *response=(NSString*)[parsedData objectForKey:@"Message"];
    if([response isEqualToString:@"Site suspended"])
    {
        ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Site suspended";
        UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Site suspended. Please try after sometime." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
        [sessionAlertView show];
        [sessionAlertView release];
    }
    else if ([response isEqualToString:@"Session Expired"]) 
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Your session has expired. Please login again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alertView.tag=1;
        [alertView show];
        [alertView release];
    }
    else if ([response isEqualToString:@"Image Uploaded"]) 
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Upload" message:@"Image uploaded successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alertView.tag=2;
        [alertView show];
        [alertView release];
    }
    else if([response isEqualToString:@"Reached maximum limit"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"You have reached the maximum limit." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
    else 
    {        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Upload" message:@"Uploading failed." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
    [returnString release];
    [JSWaiter HideWaiter];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad && !camFlag)
    {
        [_popover dismissPopoverAnimated:YES];
        [_popover release];
    }
    else 
    {
        [self dismissModalViewControllerAnimated:NO];
    }
    [self invokeCamera];
}

-(void)	invokeCamera
{
   	//Invoke View for Camera
    if (!camFlag)
	{
        UIImagePickerController *imagePicker = [[[UIImagePickerController alloc] init] autorelease];
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        }
		imagePicker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
        camFlag=NO;
        imagePicker.delegate = self;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) 
        {
            _popover = [[[UIPopoverController alloc] initWithContentViewController:imagePicker] retain];
            [_popover setDelegate:self];
            [_popover setPopoverContentSize:CGSizeMake(320, 480) animated:NO];
            
            [_popover presentPopoverFromRect:[btnCamera frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:NO];
        }
        else 
        {
            [self presentModalViewController:imagePicker animated:YES];
        }
    }
    else 
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
        camFlag=YES;
        imagePicker.delegate = self;
        [self presentModalViewController:imagePicker animated:YES];
        [imagePicker release];
		imagePicker = nil;
    }
}

-(void)reloadPhotos
{
    loadFlag=NO;
    notifFlag=0;
    for(UIView *subview in [tempScrollView subviews]) 
    {
        [subview removeFromSuperview];
    }    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    domain = [prefs stringForKey:@"URL"];
    NSString *req = [NSString stringWithFormat:@"%@/mobile/ViewPhotos/?id=%@&skey=%@",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedSessionID];
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:req, @"url", @"loadPhotoCon", @"meta", nil];
    [JSWaiter ShowWaiter:self title:@"Loading..." type:0];
    [self performSelectorOnMainThread:@selector(WebRequest:) withObject:params waitUntilDone:NO];
    btnEdit.hidden=YES;
}

-(void)DisplayPhotoAfterDeletion
{
    [myphotolab setText:@"My Photos"];
    [btnEdit setTitle:@"Edit" forState:normal];
    [btnEdit setImage:[UIImage imageNamed:@"Edit_myphoto.png"] forState:normal];
    btnDelete.hidden=YES;
    btnCamera.hidden=YES;
    toolBar.hidden=YES;
    btnDelete.enabled=NO;
    btnHome.hidden=NO;
    for (NSString *photoUrl in selectedUrlArray)
    {
        BOOL isTheObjectThere = [thumbPicURLs containsObject: photoUrl];
        if(isTheObjectThere)
        {            
            NSUInteger indexOfTheObject = [thumbPicURLs indexOfObject:photoUrl];
            [thumbPicURLs removeObjectAtIndex:indexOfTheObject];
        }
    }
    for(UIView *subview in [tempScrollView subviews]) 
    {
        [subview removeFromSuperview];
    }  
    [self performSelectorOnMainThread:@selector(loadDefaultImage) withObject:nil waitUntilDone:YES];
    queue = [[NSOperationQueue alloc] init];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] 
                                        initWithTarget:self
                                        selector:@selector(loadImage) 
                                        object:nil]; 
    [queue addOperation:operation]; 
    [operation release];
}

-(void)ios6ipad{
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        if (([[UIDevice currentDevice] orientation])==UIInterfaceOrientationLandscapeRight||([[UIDevice currentDevice] orientation])==UIInterfaceOrientationLandscapeLeft)
        {
            btnNotify.frame=CGRectMake(528, 714, 25, 25);
            imgNotification.frame=CGRectMake(416, 714, 140, 25);
		}
        else
        {        
            btnNotify.frame=CGRectMake(432, 972, 25, 25);
            imgNotification.frame=CGRectMake(320, 972, 140, 25);
        }
        
        if (btnEdit.hidden==NO)
        {
            [self ChangeImageOrientation];
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


#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    loadFlag=NO;
    imgurl=[[NSMutableArray alloc]init];
    [tempScrollView setBackgroundColor:[UIColor colorWithRed:252/255.0 green:251/255.0 blue:251/255.0 alpha:1.0]];
    [self.view setBackgroundColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redVal/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenVal/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueVal/255.0 alpha:1.0]];
    [navBar setTintColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavbar/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavbar/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavbar/255.0 alpha:1.0]];
    [toolBar setTintColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavbar/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavbar/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavbar/255.0 alpha:1.0]];
    navBar.layer.borderColor=[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavBorder/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavBorder/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavBorder/255.0 alpha:1.0].CGColor;
    navBar.layer.borderWidth=1.0f;
    toolBar.layer.borderColor=[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavBorder/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavBorder/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavBorder/255.0 alpha:1.0].CGColor;
    toolBar.layer.borderWidth=1.0f;
   
    myphotolab.font= ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontNavTitle;
    [myphotolab setText:@"My Photos"];
    [btnEdit setTitle:@"Edit" forState:normal];
    [btnEdit setImage:[UIImage imageNamed:@"Edit_myphoto.png"] forState:normal];
   
    btnDelete.hidden=YES;
    btnDelete.enabled=NO;
    btnNotify.hidden=YES;
    imgNotification.hidden=YES;
    btnCamera.hidden=YES;
    toolBar.hidden=YES;
    
    selectedThumbPicURLs=[[NSMutableArray alloc]init];
    selectedUrlArray=[[NSMutableArray alloc]init];
    [tempScrollView flashScrollIndicators];
    
    [btnNotify setTitleColor:[UIColor colorWithRed:251/255.0 green:102/255.0 blue:36/255.0 alpha:1.0] forState:normal];
    btnNotify.titleLabel.font=[UIFont fontWithName:@"Ubuntu-Bold" size:12];
    [btnNotify setTitle:[NSString stringWithFormat:@"%@",((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedNotifications] forState:normal];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    domain = [prefs stringForKey:@"URL"];
    
    NSString *req = [NSString stringWithFormat:@"%@/mobile/ViewPhotos/?id=%@&skey=%@",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedSessionID];
    
    notifFlag=0;
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:req, @"url", @"loadPhotoCon", @"meta", nil];
    [JSWaiter ShowWaiter:self title:@"Loading..." type:0];
    [self performSelectorOnMainThread:@selector(WebRequest:) withObject:params waitUntilDone:NO];
    btnEdit.hidden=YES;
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)ChangeImageOrientation
{
    for(UIView *subview in [tempScrollView subviews]) 
    {
        [subview removeFromSuperview];
    }  
    
    int imgX=4;
    int imgY=4;
    int colCount=1;
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        imgX=22;
        imgY=20;
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
    
    // Return YES for supported orientations
    /*if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        if (interfaceOrientation==UIInterfaceOrientationPortrait || interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) 
        {
            btnNotify.frame=CGRectMake(432, 972, 25, 25);
            imgNotification.frame=CGRectMake(320, 972, 140, 25);
            indicatorView.frame =CGRectMake((284+NewXval), 471, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30), 40);
        }
        else if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft || interfaceOrientation==UIInterfaceOrientationLandscapeRight)
        {
            btnNotify.frame=CGRectMake(528, 714, 25, 25);
            imgNotification.frame=CGRectMake(416, 714, 140, 25);           
            indicatorView.frame =CGRectMake((412+NewXval), 344, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30), 40);
        } 
        if (btnEdit.hidden==NO)
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

-(void)WebRequest:(NSDictionary*)params
{
	NSString* url = [params valueForKey:@"url"];
    NSString* meta = [params valueForKey:@"meta"];
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
        
        if (notifFlag == 1 && loadFlag)
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
            else
            {
                notifications = (NSNumber*)[parsedData objectForKey:@"chatcount"];
                ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedNotifications=notifications;
                [btnNotify setTitle:[NSString stringWithFormat:@"%@",notifications] forState:normal];
            }
        }
        else
        {
            if([meta isEqualToString:@"loadPhotoCon"])
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
                NSString *resultCount = (NSString*)[parsedData objectForKey:@"count"];
                if ([resultCount intValue] == 0 )
                {
                    btnEdit.hidden=NO;
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
                    loadFlag=YES;
                }
            }
            else if([meta isEqualToString:@"deletePhotoCon"])
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
                    UIAlertView *MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Please upgrade your membership to delete the photo(s)." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [MembershipAlertView show];
                    [MembershipAlertView release];
                }
                else if ([messegeStr isEqualToString:@"Success"])
                {
                    UIAlertView *MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[@"Selected photo(s) deleted successfully." description] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    MembershipAlertView.tag=3;
                    [MembershipAlertView show];
                    [MembershipAlertView release];
                }
                else 
                {
                    UIAlertView *MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Failed to retrieve data from the site." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [MembershipAlertView show];
                    [MembershipAlertView release];
                }   
            }
        }
    }
    [JSWaiter HideWaiter];
}


#pragma mark IBAction

-(IBAction)buttonAction:(id)sender
{
    if([myphotolab.text isEqualToString:@"My Photos"])
    {
        UIButton *clickedBtnImage=(UIButton*)sender;
        PhotoFullView *objPhotoFullView=[[PhotoFullView alloc]initWithNibName:@"PhotoFullView" bundle:nil];
        objPhotoFullView.resultCount=[thumbPicURLs count];
        objPhotoFullView.imgURLs=thumbPicURLs;
        objPhotoFullView.imgIndex=clickedBtnImage.tag;
        objPhotoFullView.fromMyphotos=YES;
        [self.navigationController pushViewController:objPhotoFullView animated:YES];
        [objPhotoFullView release];
    }
    else 
    {
        UIButton *clickedBtnImage=(UIButton*)sender;
        for(UIView *subview in [tempScrollView subviews]) 
        {
            if([subview isKindOfClass:[UIButton class]])
            {
                UIButton *btn = (UIButton*)subview; 
                
                if ( btn.tag ==clickedBtnImage.tag)
                {
                    [[btn layer] setBorderWidth:4.0f];
                    [[btn layer] setBorderColor:[UIColor colorWithRed:251/255.0 green:102/255.0 blue:36/255.0 alpha:1.0].CGColor];
                    NSString *fullPath=(NSString*)[thumbPicURLs objectAtIndex:btn.tag];
                    fullPath=[fullPath stringByReplacingOccurrencesOfString:@"thumb_" withString:@"full_size_"];
                    NSArray *arrSplit = [fullPath componentsSeparatedByString:@"_"];
                    imgIDArr=[[NSMutableArray alloc] initWithArray:arrSplit copyItems:YES];
                   
                    if([[imgIDArr objectAtIndex:1]isEqualToString:@"size"])
                    {
                        NSString * photoId=[imgIDArr objectAtIndex:3];
                        BOOL isTheObjectThere = [selectedThumbPicURLs containsObject: photoId];
                        if(isTheObjectThere)
                        {
                            [[btn layer] setBorderWidth:0.0f];
                            NSUInteger indexOfTheObject = [selectedThumbPicURLs indexOfObject:photoId];
                            [selectedThumbPicURLs removeObjectAtIndex:indexOfTheObject];
                            [selectedUrlArray removeObjectAtIndex:indexOfTheObject];
                        }
                        else
                        {
                            [selectedThumbPicURLs addObject:photoId];
                            [selectedUrlArray addObject:[thumbPicURLs objectAtIndex:btn.tag]];
                        }
                    }
                    
                    break;
                }
                
            }
            
        }  
        
        if([selectedThumbPicURLs count]>0)
        {
            btnDelete.enabled=YES;
            if([selectedThumbPicURLs count]==1)
            {
                [myphotolab setText:[NSString stringWithFormat:@"%d Item Selected",[selectedThumbPicURLs count]]];
            }
            else
            {
                [myphotolab setText:[NSString stringWithFormat:@"%d Items Selected",[selectedThumbPicURLs count]]];
            }
        }
        else
        {
            [myphotolab setText:@"Select Items"];
            btnDelete.enabled=NO;
        }
        
    }
}

-(IBAction)clickedHomeButton:(id)sender
{
    if(![queue isSuspended]) 
    {
        [queue setSuspended:YES];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)DeletePhotos:(id)sender 
{           
    if (btnDelete.enabled) 
    {               
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Delete Photo" message:[@"Are you sure you want to delete the selected photo(s) ?" description] delegate:self cancelButtonTitle:@"Delete" otherButtonTitles:@"Cancel",nil]; 
        alert.tag=4;
        [alert show];
        [alert release];
    }
}

-(IBAction)openPhotoLibrary:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
								  initWithTitle:nil
								  delegate:self
								  cancelButtonTitle:@"Cancel"
								  destructiveButtonTitle:@"Photo Library"
								  otherButtonTitles:@"Take Photo",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [actionSheet showInView:self.view];
	[actionSheet release];
}

-(IBAction)closeToolBar:(id)sender
{
    if([selectedThumbPicURLs count]>0)
    {
        [selectedThumbPicURLs removeAllObjects];
    }
    
    if([selectedUrlArray count]>0)
    {
        [selectedUrlArray removeAllObjects];
    }
    
    if([btnEdit.titleLabel.text isEqualToString:@"Edit"])
    {
        [btnEdit setTitle:@"Cancel" forState:normal];
        [btnEdit setImage:[UIImage imageNamed:@"cancel.png"] forState:normal];
        [myphotolab setText:@"Select Items"];
        btnDelete.hidden=NO;
        btnDelete.enabled=NO;
        btnHome.hidden=YES;
        btnCamera.hidden=NO;
        toolBar.hidden=NO;
    }
    else if([btnEdit.titleLabel.text isEqualToString:@"Cancel"])
    {
        [myphotolab setText:@"My Photos"];
        [btnEdit setTitle:@"Edit" forState:normal];
        [btnEdit setImage:[UIImage imageNamed:@"Edit_myphoto.png"] forState:normal];
        btnDelete.hidden=YES;
        btnDelete.enabled=NO;
        btnHome.hidden=NO;
        btnCamera.hidden=YES;
        toolBar.hidden=YES;
        [self DisplayPhotoAfterDeletion];
    }
}

-(IBAction)clickedNotificationButton:(id)sender
{
    NotificationsView *objNotificationsView=[[NotificationsView alloc]initWithNibName:@"NotificationsView" bundle:nil];
    [self.navigationController pushViewController:objNotificationsView animated:YES];
    [objNotificationsView release];
}

#pragma mark ActionSheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
	{
        UIImagePickerController * picker1 = [[[UIImagePickerController alloc] init] autorelease];
		picker1.delegate = self;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) 
        {
            picker1.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        }
        else
            picker1.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            camFlag=NO;
		if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            _popover = [[[UIPopoverController alloc] initWithContentViewController:picker1] retain];
            [_popover setDelegate:self];
            [_popover setPopoverContentSize:CGSizeMake(320, 480) animated:NO];
            [_popover presentPopoverFromRect:[btnCamera frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:NO];
        }
        else 
        {
            [self presentModalViewController:picker1 animated:YES];
        }
    }
    if(buttonIndex == 1)
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        camFlag=YES;
        // Set source to the camera
        imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
        
        // Delegate is self
        imagePicker.delegate = self;
        
        // Show image picker
        [self presentModalViewController:imagePicker animated:YES];
        [imagePicker release];
    }
}

#pragma mark -ImagePickerController Delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{

    NewXval=0;
            
    // Access the uncropped image from info dictionary
    UIImage *img = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    //Compress photosss
    
    float actualHeight = img.size.height;
    float actualWidth = img.size.width;
    float maxHeight = 600.0;
    float maxWidth = 800.0;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = maxWidth/maxHeight;
    float compressionQuality = 0.5;//50 percent compression
    
    if (actualHeight > maxHeight || actualWidth > maxWidth) {
        if(imgRatio < maxRatio){
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        }
        else if(imgRatio > maxRatio){
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
        }else{
            actualHeight = maxHeight;
            actualWidth = maxWidth;
        }
    }
    
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [img drawInRect:rect];
    img = UIGraphicsGetImageFromCurrentImageContext();
   imageData = UIImageJPEGRepresentation(img, compressionQuality);
    UIGraphicsEndImageContext();
    
    NSDictionary *dictData=[info objectForKey:@"UIImagePickerControllerMediaMetadata"]; 
    id orientation = [dictData objectForKey:@"Orientation"];
    msgOrient=[[NSString stringWithFormat:@"%d",[orientation integerValue]] retain];
    imageData = UIImageJPEGRepresentation(img, 0.5);
    [JSWaiter ShowWaiter:self title:@"Uploading..." type:0];
    [self performSelector:@selector(Upload:) withObject:imageData afterDelay:0.01];   
}

#pragma mark-UIAlertViewDelegate

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==1&&buttonIndex==0) 
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else if (actionSheet.tag==2&&buttonIndex==0) 
    {
        [self reloadPhotos];
    }
    else if (actionSheet.tag==3&&buttonIndex==0) 
    {
        [self DisplayPhotoAfterDeletion];
    }
    else if (actionSheet.tag==4&&buttonIndex==0) 
    {
        [self deletePhotos];
    }
}

@end
