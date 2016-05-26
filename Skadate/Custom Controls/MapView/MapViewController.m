//
//  MapViewController.m
//  Skadate
//
//  Created by Heinz Vallonthaiel on 25/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "MyAnnotation.h"
#import "JSON.h"
#import "SkadateAppDelegate.h"
#import "ProfileView.h"


@implementation MapViewController

@synthesize btnBack;
@synthesize navLable;
@synthesize navBar;
@synthesize index;
@synthesize mapView,imageArray,locationManager;

static CLLocationCoordinate2D location;

#pragma mark initWithNibName

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
    
    
    [annotations release];
    [objIndicatorView release];
    [connectionForMap release];
    [nImage release];
    [thumbPicURLs release];
    [titleArray release];
    [nearByUserLattitude release];
    [nearByUserLongitude release];
    [nearByUserProfileId release];
    [imageArray release];
    [locationManager release];
    
    [btnBack release];
    [super dealloc];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    btnBack.enabled=NO;
    
    flag=YES;
    
    annotations=[[NSMutableArray alloc] init];    
    
    [navBar setTintColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavbar/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavbar/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavbar/255.0 alpha:1.0]];
    navBar.layer.borderColor=[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavBorder/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavBorder/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavBorder/255.0 alpha:1.0].CGColor;
   
    navLable.font= ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontNavTitle;
    
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        indicatorView = [[UIView alloc] initWithFrame:CGRectMake(75, 155, 170, 170)];
    }
    else
    {
        
        if (self.interfaceOrientation==UIDeviceOrientationLandscapeRight || self.interfaceOrientation==UIDeviceOrientationLandscapeLeft) 
        {
            indicatorView = [[UIView alloc] initWithFrame:CGRectMake(364, 234, 300, 300)];
        }
        else
        {
            indicatorView = [[UIView alloc] initWithFrame:CGRectMake(250, 310, 300, 300)];
        }
    }
    indicatorView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    indicatorView.clipsToBounds = YES;
    indicatorView.layer.cornerRadius = 10.0;
    
    objIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        
        objIndicatorView.frame = CGRectMake(65, 40, objIndicatorView.bounds.size.width, objIndicatorView.bounds.size.height); 
    }
    else 
    {
        
        objIndicatorView.frame = CGRectMake(130, 100, objIndicatorView.bounds.size.width, objIndicatorView.bounds.size.height); 
        
    }
    [indicatorView addSubview:objIndicatorView];
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        indicatorLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 115, 130, 22)];
    }
    else 
    {
        indicatorLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 200, 150, 30)];
    }
    indicatorLabel.backgroundColor = [UIColor clearColor];
    indicatorLabel.textColor = [UIColor whiteColor];
    indicatorLabel.adjustsFontSizeToFitWidth = YES;
    indicatorLabel.textAlignment = UITextAlignmentCenter;
    indicatorLabel.text = @"Contacting server...";
    [indicatorView addSubview:indicatorLabel];
    
    [self.view addSubview:indicatorView];
    [self.view bringSubviewToFront:indicatorView];
    [objIndicatorView startAnimating];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setBtnBack:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    flag=YES;
    
    
    locationManager=[[CLLocationManager alloc] init];
    locationManager.delegate = self;
    //Make it kCLLocationAccuracyThreeKilometers for battery life; 
    
    [locationManager startUpdatingLocation];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if (interfaceOrientation==UIDeviceOrientationLandscapeRight || interfaceOrientation==UIDeviceOrientationLandscapeLeft) 
        {
            indicatorView.frame =CGRectMake(364, 234, 300, 300);
        }
        else
        {
            indicatorView.frame =CGRectMake(250, 310, 300, 300);
        }
        
        return YES;
        
    }
    else
    {
        indicatorView.frame =CGRectMake(75, 155, 170, 170);
        
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
        
    }
}


#pragma mark IBAction

- (IBAction)clickedBackButton:(id)sender
{
    [self.mapView setDelegate:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(IBAction)showDetails:(id)sender
{
    
    ProfileView *personalProfile=[[ProfileView alloc]initWithNibName:@"ProfileView" bundle:nil];
    personalProfile.profileID=[nearByUserProfileId objectAtIndex:[sender tag]];
    personalProfile.selectImg=10;
    
    [self.navigationController pushViewController:personalProfile animated:YES];
    
    [personalProfile release];
    
}

#pragma mark Managing API Calls

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response 
{
	[respData setLength:0 ];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{
	[respData appendData:data];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error 
{
    indicatorView.hidden=YES;
    btnBack.enabled=YES;
    
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Connection failed...Please launch the application again." description] delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
	[alertView show];
	[alertView release];
	return;
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{
    
    indicatorView.hidden=YES;
    btnBack.enabled=YES;
    NSString *responseString = [[NSString alloc] initWithData:respData encoding:NSUTF8StringEncoding];
    
    NSError *error;
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    
    NSDictionary *parsedData = (NSDictionary *)[parser objectWithString:responseString error:&error];
    [respData release];
    [responseString release];
    CFRelease((CFTypeRef) parser);
        
    resultCount = (NSString*)[parsedData objectForKey:@"count"];
    if([resultCount intValue]==0)
    {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"No Forums found"  delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        
        
    }
    NSArray *picURLs = [parsedData valueForKeyPath:@"result.Profile_Pic"];
    thumbPicURLs=[[NSMutableArray alloc]initWithArray:picURLs];
    NSArray *genders = [parsedData valueForKeyPath:@"result.sex"];
    
    imageArray=[[NSMutableArray alloc]init];
    
    for (int k=0; k<[thumbPicURLs count]; k++)
    {
        if (([thumbPicURLs objectAtIndex:k]== (id)[NSNull null])||([thumbPicURLs objectAtIndex:k]==NULL)||([thumbPicURLs objectAtIndex:k]==@"")||([[thumbPicURLs objectAtIndex:k] length]==0))
        {
            
            if(([genders objectAtIndex:k]== (id)[NSNull null])||([genders objectAtIndex:k]==NULL)||([genders objectAtIndex:k]==@"")||([[genders objectAtIndex:k] length]==0))
            {
                UIImage *myimage =[UIImage imageNamed:@"man.png"];
                [imageArray addObject:myimage];
                
                
            }
            else
            {
                
                if ([[genders objectAtIndex:k] intValue]==1) 
                {
                    UIImage *myimage =[UIImage imageNamed:@"women.png"];
                    [imageArray addObject:myimage];
                }
                else if ([[genders objectAtIndex:k] intValue]==2)
                {
                    UIImage *myimage =[UIImage imageNamed:@"man.png"];
                    [imageArray addObject:myimage];
                    
                }
                else if ([[genders objectAtIndex:k] intValue]==4) 
                {
                    UIImage *myimage =[UIImage imageNamed:@"man_women.png"];
                    [imageArray addObject:myimage];
                    
                }
                else if ([[genders objectAtIndex:k] intValue]==8) 
                {
                    UIImage *myimage =[UIImage imageNamed:@"man_women_a.png"];
                    [imageArray addObject:myimage];
                }
                else 
                {
                    UIImage *myimage =[UIImage imageNamed:@"man.png"];
                    [imageArray addObject:myimage];
                    
                } 
            }
         
        }
        else
        {
            
            profilePicUrl=[NSString stringWithFormat:@"%@/%@",domain,[thumbPicURLs objectAtIndex:k]];
            
            NSData *mydata = [[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:profilePicUrl]] autorelease];
            if (mydata)
            {
                UIImage *myimage = [[[UIImage alloc] initWithData:mydata] autorelease];
                if (myimage) 
                {
                    [imageArray addObject:myimage];
                }
                else
                {
                    if(([genders objectAtIndex:k]== (id)[NSNull null])||([genders objectAtIndex:k]==NULL)||([genders objectAtIndex:k]==@"")||([[genders objectAtIndex:k] length]==0))
                    {
                        UIImage *myimage =[UIImage imageNamed:@"man.png"];
                        [imageArray addObject:myimage];
                        
                        
                    }
                    else
                    {
                        
                        if ([[genders objectAtIndex:k] intValue]==1) 
                        {
                            UIImage *myimage =[UIImage imageNamed:@"women.png"];
                            [imageArray addObject:myimage];
                        }
                        else if ([[genders objectAtIndex:k] intValue]==2) 
                        {
                            UIImage *myimage =[UIImage imageNamed:@"man.png"];
                            [imageArray addObject:myimage];
                            
                        }
                        else if ([[genders objectAtIndex:k] intValue]==4) 
                        {
                            UIImage *myimage =[UIImage imageNamed:@"man_women.png"];
                            [imageArray addObject:myimage];
                            
                        }
                        else if ([[genders objectAtIndex:k] intValue]==8)
                        {
                            UIImage *myimage =[UIImage imageNamed:@"man_women_a.png"];
                            [imageArray addObject:myimage];
                        }
                        else 
                        {
                            UIImage *myimage =[UIImage imageNamed:@"man.png"];
                            [imageArray addObject:myimage];
                            
                        } 
                    }
                    
                }
                
            }
            else 
            {
                if(([genders objectAtIndex:k]== (id)[NSNull null])||([genders objectAtIndex:k]==NULL)||([genders objectAtIndex:k]==@"")||([[genders objectAtIndex:k] length]==0))
                {
                    UIImage *myimage =[UIImage imageNamed:@"man.png"];
                    [imageArray addObject:myimage];
                    
                    
                }
                else
                {
                    
                    if ([[genders objectAtIndex:k] intValue]==1)
                    {
                        UIImage *myimage =[UIImage imageNamed:@"women.png"];
                        [imageArray addObject:myimage];
                    }
                    else if ([[genders objectAtIndex:k] intValue]==2)
                    {
                        UIImage *myimage =[UIImage imageNamed:@"man.png"];
                        [imageArray addObject:myimage];
                        
                    }
                    else if ([[genders objectAtIndex:k] intValue]==4) 
                    {
                        UIImage *myimage =[UIImage imageNamed:@"man_women.png"];
                        [imageArray addObject:myimage];
                        
                    }
                    else if ([[genders objectAtIndex:k] intValue]==8) {
                        UIImage *myimage =[UIImage imageNamed:@"man_women_a.png"];
                        [imageArray addObject:myimage];
                    }
                    else 
                    {
                        UIImage *myimage =[UIImage imageNamed:@"man.png"];
                        [imageArray addObject:myimage];
                        
                    } 
                }
            }
        }
        
    }
    NSArray *title=[parsedData valueForKeyPath:@"result.username"];
    titleArray=[[NSArray alloc]initWithArray:title];
    
    
    NSArray *nearByUserLatitudes=[parsedData valueForKeyPath:@"result.latitude"];
    nearByUserLattitude=[[NSArray alloc]initWithArray:nearByUserLatitudes];
    
    NSArray *nearByUserLongitudes=[parsedData valueForKeyPath:@"result.longitude"];
    nearByUserLongitude=[[NSArray alloc]initWithArray:nearByUserLongitudes];
    
    NSArray *userID=[parsedData valueForKeyPath:@"result.profile_id"];
    nearByUserProfileId=[[NSMutableArray alloc]initWithArray:userID];
        
    for (int i=0; i<[titleArray count]; i++)
    {
        
        newLocations=[[MyAnnotation alloc]init];
        
        
        nUserLattitude=[nearByUserLattitude objectAtIndex:i];
        
        nUserLongitude=[nearByUserLongitude objectAtIndex:i];
        
        newLocations.title=[titleArray objectAtIndex:i];
        
        nImage=[[UIImage alloc]init];
        nImage=[imageArray objectAtIndex:i];
        
        newLocations.userProfileId=[nearByUserProfileId objectAtIndex:i];
                
        nUserLocation.latitude=nUserLattitude.doubleValue;
        nUserLocation.longitude=nUserLongitude.doubleValue;
        
        newLocations.coordinate=nUserLocation;
        newLocations.image1=nImage;
        [annotations addObject:newLocations];
        
        [mapView addAnnotation:newLocations];
              
    }
    
    mapView.delegate=self;
          
    MKMapRect flyTo = MKMapRectNull;
	for (id <MKAnnotation> annotation in annotations) 
    {
              
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        if (MKMapRectIsNull(flyTo))
        {
            flyTo = pointRect;
            
        } else 
        {
            flyTo = MKMapRectUnion(flyTo, pointRect);
        }
    }
    
    // Position the map so that all overlays and annotations are visible on screen.
    mapView.visibleMapRect = flyTo;
	
    //[self gotoLocation];//to catch perticular area on screen
    
    
}
#pragma mark Location Magement

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    //Getting New Updated Location
    location=newLocation.coordinate;    
    
    //Getting the Region
    MKCoordinateRegion region;
	region.center=location;
    
    MKPointAnnotation *annot = [[MKPointAnnotation alloc] init];
    annot.coordinate=location;
	
    //Set Zoom level using Span
	MKCoordinateSpan span;
	span.latitudeDelta=.008;
	span.longitudeDelta=.008;
	region.span=span;
    
    [mapView addAnnotation:annot];
    [annot release];
    
    
    if(flag==YES)
    {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        domain = [prefs stringForKey:@"URL"];
        urlReq =[NSString stringWithFormat:@"%@/mobile/maplocation/?pid=%@&lon=%f&lat=%f",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,location.longitude,location.latitude];
        
        respData = [[NSMutableData data]retain];
        //imageArray=[[NSMutableArray alloc]init];
        
        NSURL *url = [NSURL URLWithString:[urlReq stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSURLRequest *urlrequest = [NSURLRequest requestWithURL:url];
        connectionForMap=[[NSURLConnection alloc] initWithRequest:urlrequest delegate:self];
    }
    
    flag=NO;
    locationManager.delegate=nil;
    
}

#pragma mark Custom Methods

- (void)zoomIn: (id)sender
{
    MKUserLocation *userLocation = mapView.userLocation;
    MKCoordinateRegion region =
    MKCoordinateRegionMakeWithDistance (
                                        userLocation.location.coordinate, 50, 50);
    [mapView setRegion:region animated:NO];
}


- (void) changeMapType: (id)sender
{
    if(mapView.mapType == MKMapTypeStandard)
    {
        mapView.mapType = MKMapTypeSatellite;
        return;
    }
    if (mapView.mapType == MKMapTypeSatellite)
    {
        mapView.mapType = MKMapTypeHybrid;
        return;
    }
    
    else
        mapView.mapType = MKMapTypeStandard;
} 

#pragma mark MapView

- (void)mapView:(MKMapView *)mapView 
didUpdateUserLocation:
(MKUserLocation *)userLocation
{
    self.mapView.centerCoordinate =  userLocation.location.coordinate;
} 

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    
	// if it's the user location, just return nil.
    
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
   	// try to dequeue an existing pin view first
    static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
    MKAnnotationView* pinView= [[[MKAnnotationView alloc]
                                 initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier] autorelease];
    UIImageView *myPinImageView = [[UIImageView alloc]init];
    
        
    myPinImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    NSString *tstr = [annotation title];         
    if ( [titleArray containsObject:tstr] ) 
        
    {
        
        index = [titleArray indexOfObject:[annotation title]];
        myPinImageView.image = [imageArray objectAtIndex:index];
        CGSize newSize = CGSizeMake(30, 30);
        
        UIGraphicsBeginImageContext( newSize );// a CGSize that has the size you want
        [myPinImageView.image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
               
        //image is the original UIImage
        
        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        
        pinView.image=newImage;
        
    }
    
    pinView.canShowCallout=YES; 
        
	UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	[rightButton setTitle:annotation.title forState:UIControlStateNormal];
    rightButton.tag=index;
    
	[rightButton addTarget:self
					action:@selector(showDetails:)
		  forControlEvents:UIControlEventTouchUpInside];
	pinView.rightCalloutAccessoryView = rightButton;
	
    UIImageView *myImageView = [[UIImageView alloc]init];
    myImageView.image=pinView.image;
    myImageView.frame = CGRectMake (0,0,30,30);
    pinView.leftCalloutAccessoryView = myImageView;
    
    [myImageView release];
    myImageView = nil;
    [myPinImageView release];
    myPinImageView = nil;
    
    return pinView;
    
    
}


@end
