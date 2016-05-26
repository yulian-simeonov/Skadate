//
//  SearchResults.h
//  Skadate
//
//  Created by SODTechnologies on 26/09/11.
//  Copyright 2011 Solutions On Demand Australasia Pty Ltd. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ComposeMessageView.h"
#import "ChatMembersView.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "LocationGetter.h"
#import "JSWaiter.h"
#import "JSWebManager.h"

@class myAnnotation;

@interface MyNeighboursSearchResults : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate,UINavigationBarDelegate,UINavigationControllerDelegate,UIAlertViewDelegate,LocationGetterDelegate,UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate>  
{
    float NewXval;
    
    NSIndexPath *prevIndexPath;
    
    NSString *urlReq;
    NSString *resultCount;
    NSString *countTotal;
    NSString *domain;
    
    NSInteger tagValue;
    
    NSMutableArray *thumbPicURLs;
    NSMutableArray *imageArray;
    NSMutableArray *nameArray;
    NSMutableArray *ageArray;
    NSMutableArray *placeArray;
    NSMutableArray *lngArray;
    NSMutableArray *profileID;
    NSMutableArray *gender;
    NSMutableArray *genderIdArray;
    NSMutableArray *latArray;
    NSArray *profileIDs;
    NSArray *username;
    NSArray *genders;
    NSArray *picURLs ;
          
    NSDictionary *parsedData;
    
    UIAlertView *myAlert;
    
    UIImage *img1;
	UIImage *img2;
	UIImage *img3;	
	UIImage *img4;
	UIImage *img5;
	UIImage *img6;
	UIImage *img7;
	UIImage *img8;
    
    int count;
    int totalCount;
    int selectedRowIndex;
    int i;
           
    BOOL searchResultFlag;
    BOOL isLoading;
                      
    IBOutlet UITableView *table;
    IBOutlet UIButton *btnBack;
    IBOutlet UILabel *searchresultslable;
    IBOutlet UINavigationBar *navBar;
    
    UILabel *lblOfName;
    UILabel *lblOfAge;
    UILabel *lblOfPlace;
    UILabel *lblOfCountry;
    
    UILabel *lblOfAgeNew;
    UILabel *lblOfPlaceNew;
    
    UITextField *txtFldInAlert;
        
    CGPoint  offset;
     
    dispatch_queue_t queue;
        
}

@property (nonatomic,assign)float NewXval;

@property (nonatomic, retain) NSIndexPath *prevIndexPath;

@property(nonatomic, retain) NSString *domain;
@property(nonatomic, retain)    NSString *countTotal;
@property (nonatomic, retain) NSString *urlReq;
@property (nonatomic, retain) NSString *resultCount;

@property (nonatomic, retain) NSMutableArray *imageArray;
@property (nonatomic, retain) NSMutableArray *nameArray;
@property (nonatomic, retain) NSMutableArray *ageArray;
@property (nonatomic, retain) NSMutableArray *placeArray;
@property (nonatomic, retain) NSMutableArray *lngArray;
@property (nonatomic, retain) NSMutableArray *profileID;
@property (nonatomic, retain) NSMutableArray *gender;
@property (nonatomic, retain) NSMutableArray *genderIdArray;
@property (nonatomic, retain) NSMutableArray *latArray;

@property (nonatomic, retain) NSDictionary *parsedData;

@property (nonatomic, retain) UIAlertView *myAlert;

@property (nonatomic, retain) UILabel *lblOfName;
@property (nonatomic, retain) UILabel *lblOfAge;
@property (nonatomic, retain) UILabel *lblOfPlace;
@property (nonatomic, retain) UILabel *lblOfCountry;
@property (nonatomic, retain) UILabel *lblOfAgeNew;
@property (nonatomic, retain) UILabel *lblOfPlaceNew;
@property (nonatomic, retain) UITextField *txtFldInAlert;

@property (nonatomic, retain) IBOutlet UITableView *table;
@property (nonatomic, retain) IBOutlet UIButton *btnBack;


-(NSString *)returnGender:(int)value;
-(IBAction)clickedBackButton:(id)sender;

@end
