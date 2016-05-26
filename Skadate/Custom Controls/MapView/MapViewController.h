//
//  MapViewController.h
//  Skadate
//
//  Created by Heinz Vallonthaiel on 25/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@class MyAnnotation;

@interface MapViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate,UINavigationBarDelegate,UINavigationControllerDelegate>{
    
    IBOutlet MKMapView* mapView;
    IBOutlet UIButton *btnBack;
    IBOutlet UINavigationBar *navBar;
    
    MyAnnotation *newLocations;
       
    UILabel *indicatorLabel;
    UIView *indicatorView;
    UIActivityIndicatorView *objIndicatorView;
    
    CLLocationManager *locationManager;
    CLLocationCoordinate2D nUserLocation;
    
    NSURLConnection *connectionForMap;
    NSString *domain;
    NSString *urlReq;
    NSString *profilePicUrl;
    NSString *resultCount;
    
    NSNumber *nUserLattitude;
    NSNumber *nUserLongitude;
    UIImage *nImage;
       
    NSArray *nearByUserLattitude;
    NSArray *nearByUserLongitude;
    NSArray *titleArray;
    
    NSMutableData *respData;

    NSMutableArray *thumbPicURLs;
    NSMutableArray *imageArray;
    NSMutableArray* annotations;
    NSMutableArray *nearByUserProfileId;
        
    BOOL flag;
    
    int index;
 
}

@property (nonatomic, retain) IBOutlet MKMapView* mapView;
@property (retain, nonatomic) IBOutlet UILabel *navLable;
@property (retain, nonatomic) IBOutlet UINavigationBar *navBar;
@property (retain, nonatomic) IBOutlet UIButton *btnBack;

@property(nonatomic,retain) NSArray *imageArray;
@property(nonatomic,retain) CLLocationManager *locationManager;

@property (nonatomic,assign) int index;

-(IBAction)showDetails:(id)sender;
- (IBAction)clickedBackButton:(id)sender;


@end
