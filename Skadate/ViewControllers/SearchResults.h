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
#import "SearchMembersView.h"
#import "JSWebManager.h"
#import "JSWaiter.h"

@interface SearchResults : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, UITextFieldDelegate> 
{
    
    IBOutlet UILabel *searchresultslable;
    IBOutlet UINavigationBar *navBar;
    IBOutlet UITableView *table;
    IBOutlet UIButton *btnBackForSearchResults;
    IBOutlet UIButton *btnSaved;
    
    NSString *urlReq;
    NSString *resultCount;
    NSString *countTotal;
    NSString *domain;
    NSString *ResultType;
    NSArray *profileIDs;
    NSArray *username;
    NSArray *genders;
    NSArray *picURLs;
    NSIndexPath *prevIndexPath;
    NSInteger tagValue;
    NSMutableData *respData;
    NSMutableArray *thumbPicURLs;
    NSMutableArray *imageArray;
    NSMutableArray *nameArray;
    NSMutableArray *ageArray;
    NSMutableArray *placeArray;
    NSMutableArray *countryName;
    NSMutableArray *profileID;
    NSMutableArray *gender;
    NSMutableArray *genderIdArray;
    NSDictionary *parsedData;

    UIImage *img1;
	UIImage *img2;
	UIImage *img3;	
	UIImage *img4;
	UIImage *img5;
	UIImage *img6;
	UIImage *img7;
	UIImage *img8;
            
    UILabel *lblOfName;
    UILabel *lblOfAge;
    UILabel *lblOfPlace;
    UILabel *lblOfCountry;
    UILabel *lblOfAgeNew;
    UILabel *lblOfPlaceNew;
    UITextField *txtFldInAlert;
    UIAlertView *myAlert;
    
    int i;
    int count;
    int totalCount;
    int selectedRowIndex;
    
    float NewXval;

    BOOL saveFlag;
    BOOL saveBookMark;
    BOOL searchResultFlag;
    BOOL searchsavedflag;
    BOOL isLoading;
    
    SearchMembersView *objSearchMembersView;
    ComposeMessageView *objComposeMessageView;
    ChatMembersView *objChatMembersView;
        
    dispatch_queue_t queue;

}
@property (nonatomic, retain) IBOutlet UITableView *table;
@property (nonatomic, retain) IBOutlet UIButton *btnBackForSearchResults;
@property (nonatomic, retain) IBOutlet UIButton *btnSaved;

@property (nonatomic,assign)float NewXval;
@property (nonatomic, retain) UILabel *lblOfName;
@property (nonatomic, retain) UILabel *lblOfAge;
@property (nonatomic, retain) UILabel *lblOfPlace;
@property (nonatomic, retain) UILabel *lblOfCountry;
@property (nonatomic, retain) UILabel *lblOfAgeNew;
@property (nonatomic, retain) UILabel *lblOfPlaceNew;
@property (nonatomic, retain) UIAlertView *myAlert;
@property (nonatomic, retain) UITextField *txtFldInAlert;

@property (nonatomic, retain) NSString *domain;
@property (nonatomic, retain) NSString *countTotal;
@property (nonatomic, retain) NSString *ResultType;
@property (nonatomic, retain) NSString *urlReq;
@property (nonatomic, retain) NSString *resultCount;
@property (nonatomic, retain) NSMutableArray *imageArray;
@property (nonatomic, retain) NSMutableArray *nameArray;
@property (nonatomic, retain) NSMutableArray *ageArray;
@property (nonatomic, retain) NSMutableArray *placeArray;
@property (nonatomic, retain) NSMutableArray *countryName;
@property (nonatomic, retain) NSMutableArray *profileID;
@property (nonatomic, retain) NSMutableArray *gender;
@property (nonatomic, retain) NSMutableArray *genderIdArray;
@property (nonatomic, retain) NSDictionary *parsedData;
@property (nonatomic, retain) NSIndexPath *prevIndexPath;

@property (nonatomic) BOOL searchsavedflag;

@property (nonatomic, retain) ComposeMessageView *objComposeMessageView;
@property (nonatomic, retain) ChatMembersView *objChatMembersView;
@property (nonatomic, retain) SearchMembersView *objSearchMembersView;

-(NSString *)returnGender:(int)value;
-(IBAction)clickedSavedButton: (id) sender;
-(IBAction)clickedBackForSearchResultsButton:(id)sender;

@end
