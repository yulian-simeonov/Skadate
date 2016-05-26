//
//  MailConversationView.h
//  Skadate
//
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Structures.h"
#import "DisplayDateTime.h"
#import "JSWaiter.h"
#import "JSWebManager.h"

@interface MailConversationView : UIViewController<UIAlertViewDelegate> 
{
    
    NSString *profilePicUrl;
    NSString *urlReq;
    NSString *messageID;
    NSString *senderID;
    NSString *conversNum;
    NSString *domain;
    
    NSArray *rootMsgIDArray;
    NSArray *rootConNumArray;
    NSArray *rootConIDArray;
    NSInteger index;

    NSMutableArray *nameArray;
    NSMutableArray *messageContentArray;
    NSMutableArray *messageId;
    NSMutableArray *senderId;
    NSMutableArray *timeArray;
    NSMutableArray *subject;
    NSMutableArray *thumbPicURLs;
    NSMutableArray *imageArr;
    NSMutableArray *congenderArray;
    
    ProfileResp respProflieDetails;
    
    UIImage *img1;
	UIImage *img2;
	UIImage *img3;	
	UIImage *img4;
	UIImage *img5;
	UIImage *img6;
	UIImage *img7;
	UIImage *img8;
    UIButton *previousBut;
    UITextView *lblOfTxt;
    
    IBOutlet UIButton *btnMailBox;
    IBOutlet UIButton *btnBookMark;
    IBOutlet UIButton *btnReply;
    IBOutlet UIButton *btnDelete;
    IBOutlet UINavigationBar *navBar;
    IBOutlet UIToolbar *toolBar;
    IBOutlet UISegmentedControl *segmentCtrl;
    IBOutlet UITableView *table;
    IBOutlet UILabel *messageViewLabel;
    IBOutlet UILabel *conversationNom;

    BOOL bookmarkFlag;
    BOOL deleteFlag;
    BOOL setButtonFlag;
    BOOL fromInbox;
    
    dispatch_queue_t queue;
    
    float NewXval;
    
}
@property (nonatomic,assign)float NewXval;

@property(nonatomic, retain) IBOutlet UIButton *btnMailBox;
@property(nonatomic, retain) IBOutlet UIButton *btnBookMark;
@property(nonatomic, retain) IBOutlet UIButton *btnReply;
@property(nonatomic, retain) IBOutlet UIButton *btnDelete;
@property(nonatomic, retain) IBOutlet UITableView *table;
@property(nonatomic, retain) IBOutlet UILabel *messageViewLabel;
@property(nonatomic, retain) IBOutlet UILabel *conversationNom;
@property(nonatomic, retain) IBOutlet UINavigationBar *navBar;
@property(nonatomic, retain) IBOutlet UIToolbar *toolBar;
@property(nonatomic, retain) IBOutlet UISegmentedControl *segmentCtrl;


@property(nonatomic, retain) NSArray *rootMsgIDArray;
@property(nonatomic, retain) NSArray *rootConNumArray;
@property(nonatomic, retain) NSArray *rootConIDArray;

@property(nonatomic, readwrite)  NSInteger index;

@property(nonatomic, retain)  NSMutableArray *thumbPicURLs;
@property(nonatomic, retain)  NSMutableArray *imageArr;
@property(nonatomic, retain)  NSMutableArray *senderId;
@property(nonatomic, retain)  NSMutableArray *timeArray;
@property(nonatomic, retain)  NSMutableArray *congenderArray;
@property(nonatomic, retain)  NSMutableArray *nameArray;
@property(nonatomic, retain)  NSMutableArray *messageContentArray;
@property(nonatomic, retain)  NSMutableArray *messageId;
@property(nonatomic, retain)  NSMutableArray *subject;

@property(nonatomic,retain) UIButton *previousBut;
@property(nonatomic,retain) UITextView *lblOfTxt;

@property(nonatomic,retain) NSString *urlReq;
@property(nonatomic,retain) NSString *messageID;
@property(nonatomic,retain) NSString *senderID;
@property(nonatomic,retain) NSString *conversNum;
@property(nonatomic,retain) NSString *domain;


-(IBAction)clickedMailboxButton:(id) sender;
-(IBAction)clickedBookMarkButton:(id) sender;
-(IBAction)clickedReplyButton:(id) sender;
-(IBAction)clickedDeleteButton:(id) sender;
-(IBAction) clickedSegmentContol;

-(void)loadData;

@end
