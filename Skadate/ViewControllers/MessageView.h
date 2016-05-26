//
//  MessageView.h
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

@interface MessageView : UIViewController<UIAlertViewDelegate>
{
    
    IBOutlet UIButton *btnMailBox;
    IBOutlet UIButton *btnBookMark;
    IBOutlet UIButton *btnReply;
    IBOutlet UIButton *btnDelete;
    IBOutlet UILabel *labelName;
    IBOutlet UILabel *labelDate;
    IBOutlet UILabel *labelSubject;
    IBOutlet UILabel *labelSubject1;
    IBOutlet UITextView *viewMessage;
    IBOutlet UIImageView *profileImg;
    IBOutlet UINavigationBar *navBar;
    IBOutlet UIToolbar *toolBar;
    IBOutlet UISegmentedControl *segmentCtrl;
    
    ProfileResp respProflieDetails;
        
    NSArray *rootMsgIDArray;
    NSArray *rootConNumArray;
    NSArray *rootConIDArray;
    NSInteger index;
    
    NSString *profilePicUrl;
    NSString *domain;
    NSString *strBid;
    NSString *messageID1;
    NSString *profileID;
    NSMutableArray *fullName;
    NSMutableArray *dateTime;
    NSMutableArray *subject;
    NSMutableArray *subject1;
    NSMutableArray *genders;
    NSMutableArray *kissesImagesArray;
    NSMutableArray *winkImagesArray;
    NSMutableArray *is_readableArray;
    NSMutableArray *message;
    NSMutableArray *profilePic;
    NSMutableArray *messageId;
    NSMutableArray *senderIDs;
    NSMutableArray *recipientIDs;
    NSMutableArray *conversationIDs;
    
    UIImageView *smileyImgView;
    UIImageView *kissImageView;
     
    BOOL deleteFlag;
    BOOL bookmarkFlag;
    BOOL fromInbox;
    BOOL isKiss;
    BOOL isWink;
    
    dispatch_queue_t queue;
    float NewXval;
    
    int conversationNumber;
}

@property (nonatomic,assign)float NewXval;

@property(nonatomic,retain) IBOutlet UIButton *btnMailBox;
@property(nonatomic,retain) IBOutlet UIButton *btnBookMark;
@property(nonatomic,retain) IBOutlet UIButton *btnReply;
@property(nonatomic,retain) IBOutlet UIButton *btnDelete;
@property(nonatomic,retain) IBOutlet UILabel *labelName;
@property(nonatomic,retain) IBOutlet UILabel *labelDate;
@property(nonatomic,retain) IBOutlet UILabel *labelSubject;
@property(nonatomic,retain) IBOutlet UILabel *labelSubject1;
@property(nonatomic,retain) IBOutlet UITextView *viewMessage;
@property(nonatomic,retain) IBOutlet UIImageView *profileImg;
@property(nonatomic,retain) IBOutlet UISegmentedControl *segmentCtrl;

@property(nonatomic,readwrite) NSInteger index;

@property(nonatomic,retain) NSString *profileID;
@property(nonatomic,retain) NSString *messageID1;
@property(nonatomic,retain) NSString *domain;
@property(nonatomic,retain) NSArray *rootMsgIDArray;
@property(nonatomic,retain) NSArray *rootConNumArray;
@property(nonatomic,retain) NSArray *rootConIDArray;

@property(nonatomic,retain) NSMutableArray *genders;
@property(nonatomic,retain) NSMutableArray *fullName;
@property(nonatomic,retain) NSMutableArray *dateTime;
@property(nonatomic,retain) NSMutableArray *subject;
@property(nonatomic,retain) NSMutableArray *subject1;
@property(nonatomic,retain) NSMutableArray *message;
@property(nonatomic,retain) NSMutableArray *profilePic;
@property(nonatomic,retain) NSMutableArray *messageId;
@property(nonatomic,retain) NSMutableArray *senderIDs;
@property(nonatomic,retain) NSMutableArray *recipientIDs;
@property(nonatomic,retain) NSMutableArray *conversationIDs;
@property(nonatomic,retain) NSMutableArray *is_readableArray;

@property(nonatomic, readwrite) BOOL fromInbox;
@property(nonatomic, readwrite) BOOL isKiss;
@property(nonatomic, readwrite) BOOL isWink;

@property(nonatomic,readwrite) int conversationNumber;

-(IBAction)clickedMailboxFromMessageButton:(id) sender;
-(IBAction)clickedBookMarkFromMessageButton:(id) sender;
-(IBAction)clickedReplyFromMessageButton:(id) sender;
-(IBAction)clickedDeleteFromMessageButton:(id) sender;


@end
