//
//  NotificationsView.h
//  Skadate
//
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "DisplayDateTime.h"
#import "JSWebManager.h"
#import "JSWaiter.h"

@interface NotificationsView : UIViewController <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    
    IBOutlet UIButton *btnClose;
    IBOutlet UILabel *lblNotifications;
    IBOutlet UINavigationBar *navBar;
    IBOutlet UITableView *table;
       
    NSString *urlReq;
    NSString *profilePicUrl;
    NSString *domain;
    NSString *textPull;
    NSString *textRelease;
    NSString *textLoading;
    
    NSInteger chatItemCount;
    NSInteger mailItemCount;
    
    NSMutableArray *imageArray;
    NSMutableArray *chatMsgIdArray;
    NSMutableArray *chatSenderId;
    NSMutableArray *chatReciepientId;
    NSMutableArray *msgIdArray;
    NSMutableArray *senderId;
    NSMutableArray *reciepientId;
    NSMutableArray *chatNameArray;
    NSMutableArray *chatImageArray;
    NSMutableArray *chatTextArray;
    NSMutableArray *messageTimeArray;
    NSMutableArray *messageText;
    NSMutableArray *messageImageArray;
    NSMutableArray *messageNameArray;
    NSMutableArray *chatImg;
    NSMutableArray *msgImg;
    NSMutableArray *chatgenderarray;
    NSMutableArray *msggenderarray;
    NSMutableArray *kissesImagesArray;
    NSMutableArray *msgSubjectArray;
    
    UILabel *refreshLabel;
    UILabel *lblOfSub;
    UILabel *lblOfName;
    UILabel *lblOfMsg;
    UILabel *lblOfTime;
    UIView *refreshHeaderView;
    UIImageView *refreshArrow;
    UIImageView *kissImageView;
    UIActivityIndicatorView *refreshSpinner;
         
    BOOL isDragging;
    BOOL isLoading;
   
    dispatch_queue_t queue;
  
    float NewXval;
}

@property (nonatomic,assign)float NewXval;

@property(nonatomic, retain) IBOutlet UIButton *btnClose;
@property(nonatomic, retain) IBOutlet UILabel *lblNotifications;
@property(nonatomic, retain) IBOutlet UITableView *table;
@property(nonatomic, retain) IBOutlet UINavigationBar *navBar;
@property(nonatomic, retain) NSString *urlReq;
@property(nonatomic, retain) NSString *domain;

@property(nonatomic, retain) NSMutableArray *NameArray;
@property(nonatomic, retain) NSMutableArray *ImageArray;
@property(nonatomic, retain) NSMutableArray *msgSubjectArray;
@property(nonatomic, retain) NSMutableArray *messageTimeArray;
@property(nonatomic, retain) NSMutableArray *chatMsgIdArray;
@property(nonatomic, retain) NSMutableArray *typeChat;
@property(nonatomic, retain) NSMutableArray *chatSenderId;
@property(nonatomic, retain) NSMutableArray *chatReciepientId;
@property(nonatomic, retain) NSMutableArray *msgIdArray;
@property(nonatomic, retain) NSMutableArray *senderId;
@property(nonatomic, retain) NSMutableArray *reciepientId;
@property(nonatomic, retain) NSMutableArray *chatNameArray;
@property(nonatomic, retain) NSMutableArray *chatImageArray;
@property(nonatomic, retain) NSMutableArray *chatTextArray;
@property(nonatomic, retain) NSMutableArray *messageText;
@property(nonatomic, retain) NSMutableArray *messageImageArray;
@property(nonatomic, retain) NSMutableArray *messageNameArray;
@property(nonatomic, retain) NSMutableArray *chatImg;
@property(nonatomic, retain) NSMutableArray *msgImg;
@property(nonatomic, retain) NSMutableArray *chatgenderarray;
@property(nonatomic, retain) NSMutableArray *msggenderarray;
@property(nonatomic, retain) NSMutableArray *kissesImagesArray;

@property(nonatomic, retain) UILabel *lblOfSub;
@property(nonatomic, retain) UILabel *lblOfName;
@property(nonatomic, retain) UILabel *lblOfMsg;
@property(nonatomic, retain) UILabel *lblOfTime;
@property(nonatomic, retain) UIImageView *kissImageView;

// pull down refresh.........//
@property (nonatomic, retain) UIView *refreshHeaderView;
@property (nonatomic, retain) UILabel *refreshLabel;
@property (nonatomic, retain) UIImageView *refreshArrow;
@property (nonatomic, retain) UIActivityIndicatorView *refreshSpinner;
@property (nonatomic, copy) NSString *textPull;
@property (nonatomic, copy) NSString *textRelease;
@property (nonatomic, copy) NSString *textLoading;
///////////////////////////////////////////

-(IBAction)clickedCloseButton:(id) sender;

// pull down refresh.........//
- (void)setupStrings;
- (void)addPullToRefreshHeader;
- (void)startLoading;
- (void)stopLoading;
- (void)refresh;
/////////////////////

@end
