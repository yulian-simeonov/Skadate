//
//  OnlineMembers.h
//  Skadate
//
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ChatMembersView.h"
#import "ComposeMessageView.h"
#import "SearchMembersView.h"
#import "JSON.h"
#import "JSWaiter.h"
#import "JSWebManager.h"

@interface OnlineMembers : UIViewController <UITabBarDelegate,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate> 
{
   
    NSInteger tagValue;
    NSString *countTotal;
    NSString *urlReq;
    NSString *profilePicUrl;
    NSString *domain; 
    NSIndexPath *prevIndexPath;
    NSMutableArray *imageArray;
    NSMutableArray *nameArray;
    NSMutableArray *ageArray;
    NSMutableArray *placeArray;
    NSMutableArray *countryName;
    NSMutableArray *profileID;
    NSMutableArray *gender;
    NSMutableArray *thumbPicURLs;
    NSMutableArray *genderIdArray;

    UILabel *lblOfName;
    UILabel *lblOfAge;
    UILabel *lblOfPlace;
    UILabel *lblOfCountry;
    UILabel *lblOfAgeNew;
    UILabel *lblOfPlaceNew;
    
    IBOutlet UILabel *lblTabName;
    IBOutlet UITabBar *tabBarItem;
    IBOutlet UILabel *onlinememberslab;
    IBOutlet UINavigationBar *navBar;
    IBOutlet UIButton *btnSearch;
    IBOutlet UIButton *btnHome;
    IBOutlet UITableView *table;
        
    BOOL newFlag;
    BOOL onlineFlag;
    BOOL myWatchesFlag;
    BOOL featuredFlag;
    BOOL bookmarksFlag;
    BOOL saveBookMark;
    BOOL firstTime;
    
    int i;
    int lstRow;
    int selectedtab;
    int selectedRowIndex;
    int totalCounts;
    
    float NewXval;
    
    ComposeMessageView *objComposeMessageView;
    ChatMembersView *objChatMembersView;
    SearchMembersView *objSearchMembersView;
    
    dispatch_queue_t queue;
}

@property (nonatomic,assign)float NewXval;
@property (nonatomic) int selectedtab;

@property (nonatomic, retain) UILabel *lblOfName;
@property (nonatomic, retain) UILabel *lblOfAge;
@property (nonatomic, retain) UILabel *lblOfPlace;
@property (nonatomic, retain) UILabel *lblOfCountry;
@property (nonatomic, retain) UILabel *lblOfAgeNew;
@property (nonatomic, retain) UILabel *lblOfPlaceNew;

@property(nonatomic, retain) NSString *domain;
@property (nonatomic, retain) NSString *countTotal;
@property (nonatomic, retain) NSString *urlReq;
@property (nonatomic, retain) NSIndexPath *prevIndexPath;
@property (nonatomic, retain) NSMutableArray *profileID;
@property (nonatomic, retain) NSMutableArray *imageArray;
@property (nonatomic, retain) NSMutableArray *nameArray;
@property (nonatomic, retain) NSMutableArray *ageArray;
@property (nonatomic, retain) NSMutableArray *placeArray;
@property (nonatomic, retain) NSMutableArray *countryName;
@property (nonatomic, retain) NSMutableArray *gender;
@property (nonatomic, retain) NSMutableArray *thumbPicURLs;
@property (nonatomic, retain) NSMutableArray *genderIdArray;

@property (nonatomic, retain) SearchMembersView *objSearchMembersView;
@property (nonatomic, retain) ComposeMessageView *objComposeMessageView;
@property (nonatomic, retain) ChatMembersView *objChatMembersView;

@property (nonatomic, retain) IBOutlet UITableView *table;
@property (nonatomic, retain) IBOutlet UILabel *lblTabName;
@property (nonatomic, retain) IBOutlet UIButton *btnSearch;
@property (nonatomic, retain) IBOutlet UIButton *btnHome;
@property (nonatomic, retain) IBOutlet UITabBar *tabBarItem;

@property (nonatomic) BOOL newFlag;
@property (nonatomic) BOOL onlineFlag;
@property (nonatomic) BOOL myWatchesFlag;
@property (nonatomic) BOOL featuredFlag;
@property (nonatomic) BOOL bookmarksFlag;

-(NSString *)returnGender:(int)value;
-(IBAction)clickedSearchButton:(id) sender;
-(IBAction)clickedHomeButton:(id) sender;

@end
