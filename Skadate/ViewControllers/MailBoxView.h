//
//  MailBoxView.h
//  Skadate
//
//  Created by SODTechnologies on 29/09/11.
//  Copyright 2011 Solutions On Demand Australasia Pty Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "DisplayDateTime.h"
#import "JSWaiter.h"
#import "JSWebManager.h"

@class MessageView;

@interface MailBoxView : UIViewController<UITableViewDataSource, UITableViewDelegate,UIAlertViewDelegate> 
{
    NSString *profilePicURL;
    NSString *urlReq;
    NSString *resultCount;
    NSString *domain;
    NSString *textPull;
    NSString *textRelease;
    NSString *textLoading;

    NSMutableArray *thumbPicURLs;
    NSMutableArray *imagearray;
    NSMutableArray *nameArray;
    NSMutableArray *messageSubjectArray;
    NSMutableArray *messageContentArray;
    NSMutableArray *messageId;
    NSMutableArray *conversationId;
    NSMutableArray *senderId;
    NSMutableArray *timeArray;
    NSMutableArray *conversationNumber;
    NSMutableArray *genders;
    NSMutableArray *readMsgs;
    NSMutableArray *kissesImagesArray;
    NSMutableArray *winkImagesArray;
    NSMutableArray *lastRead;

    MessageView *touView;
          
    IBOutlet UITableView *table;
    IBOutlet UIButton *btnMailBox;
    IBOutlet UIButton *btnComposeMessage;
    IBOutlet UISegmentedControl *segmentControl;
    IBOutlet UINavigationBar *navBar;
    IBOutlet UILabel *mailboxlable;
    
    BOOL inboxFlag;
    BOOL sentFlag;
    BOOL loadFlag;
    BOOL isWink;
    BOOL isKiss;
    BOOL isDragging;
    BOOL isLoading;
    
    UILabel *messageLabel;
    UILabel *lblOfSubject;
    UILabel *lblOfName;
    UILabel *refreshLabel;
    UIImage *img1;
	UIImage *img2;
	UIImage *img3;	
	UIImage *img4;
	UIImage *img5;
	UIImage *img6;
	UIImage *img7;
	UIImage *img8;
    UIView *refreshHeaderView;
    UITextView *lblOfTxt;
     
    int countTotal;
    int fromView;
    
    dispatch_queue_t queue;
    
    float NewXval;
}

@property (nonatomic) int fromView;
@property (nonatomic,assign)float NewXval;

@property(nonatomic,retain) NSString *resultCount;
@property(nonatomic,retain) NSString *urlReq;
@property(nonatomic,retain) NSString *domain;
@property (nonatomic, copy) NSString *textPull;
@property (nonatomic, copy) NSString *textRelease;
@property (nonatomic, copy) NSString *textLoading;

@property(nonatomic,retain) NSMutableArray *imageArray;
@property(nonatomic,retain) NSMutableArray *nameArray;
@property(nonatomic,retain) NSMutableArray *messageSubjectArray;
@property(nonatomic,retain) NSMutableArray *messageContentArray;
@property(nonatomic,retain) NSMutableArray *messageId;
@property(nonatomic,retain) NSMutableArray *conversationId;
@property(nonatomic,retain) NSMutableArray *senderId;
@property(nonatomic,retain) NSMutableArray *timeArray;
@property(nonatomic,retain) NSMutableArray *readMsgs;
@property(nonatomic,retain) NSMutableArray *kissesImagesArray;
@property(nonatomic,retain) NSMutableArray *winkImagesArray;
@property(nonatomic,retain) NSMutableArray *conversationNumber;
@property(nonatomic,retain) NSMutableArray *genders;
@property(nonatomic,retain) NSMutableArray *lastRead;


@property(nonatomic,retain) IBOutlet UIButton *btnMailBox;
@property(nonatomic,retain) IBOutlet UIButton *btnComposeMessage;
@property(nonatomic,retain) IBOutlet UITableView *table;
@property(nonatomic,retain) IBOutlet UISegmentedControl *segmentControl;

@property(nonatomic,retain) UITextView *lblOfTxt;
@property(nonatomic,retain) UILabel *lblOfSubject;
@property(nonatomic,retain) UILabel *lblOfName;
@property(nonatomic,retain) UILabel *refreshLabel;

@property (nonatomic,retain) UIView *refreshHeaderView;
@property (nonatomic,retain) UIImageView *refreshArrow;
@property (nonatomic,retain) UIActivityIndicatorView *refreshSpinner;

-(IBAction)clickedMailBoxButton:(id) sender;
-(IBAction)clickedComposeMessageBtn:(id) sender;
-(IBAction)clickedSegmentContol;

// pull down refresh.........//
- (void)setupStrings;
- (void)addPullToRefreshHeader;
- (void)startLoading;
- (void)stopLoading;
- (void)refresh;
/////////////////////

@end
