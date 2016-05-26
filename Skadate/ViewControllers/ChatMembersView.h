//
//  ChatMembersView.h
//  Skadate
//
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "DisplayDateTime.h"
#import "CommonStaticMethods.h"
#import "ChatAutoUpdationClass.h"
#import "JSWaiter.h"
#import "JSWebManager.h"

@interface ChatMembersView : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,ChatAutoUpdationDelegate>
{
    IBOutlet UITableView *messageList;
    IBOutlet UIButton *btnImage;
    IBOutlet UIButton *btnHome;
    IBOutlet UIButton *btnSend;
    IBOutlet UILabel *lblName;
    IBOutlet UILabel *lblDateTime;
    IBOutlet UITextField *txtFldChat;
    IBOutlet UIToolbar *toolBarBottom;
    IBOutlet UINavigationBar *navBar;

    BOOL sendChat;
    BOOL firstTime;
    BOOL boolHeight;
    
    NSMutableArray *status;
    NSMutableArray *text;
    NSMutableArray *timestamp;
    NSMutableArray *chatMsgId;
    NSMutableArray *arrayCount;
    
    NSTimer *timer;
       
    NSString *recipientgender;
    NSString *urlReq;
    NSString *receipientProfileId;
    NSString *receipientName;
    NSString *receipientProfilePic;
    NSString *resultCount;
    NSString *domain;
    NSString *charCount;

    float NewXval;
    NSInvocation *invocation;
    ChatAutoUpdationClass *objChatAutoUpdationClass;

}
@property (nonatomic, retain) NSInvocation *invocation;
@property (nonatomic,retain) IBOutlet UITableView *messageList;
@property (nonatomic,retain) IBOutlet UIButton *btnImage;
@property (nonatomic,retain) IBOutlet UIButton *btnHome;
@property (nonatomic,retain) IBOutlet UIButton *btnSend;
@property (nonatomic,retain) IBOutlet UILabel *lblName;
@property (nonatomic,retain) IBOutlet UILabel *lblDateTime;
@property (nonatomic,retain) IBOutlet UITextField *txtFldChat;
@property (nonatomic,retain) IBOutlet UINavigationBar *navBar;
@property (nonatomic,retain) IBOutlet UIToolbar *toolBarBottom;
@property (retain,nonatomic) IBOutlet UITextView *sampleTxtView;

@property (nonatomic,retain) NSString *receipientProfileId;
@property (nonatomic,retain) NSString *receipientName;
@property (nonatomic,retain) NSString *receipientProfilePic;
@property (nonatomic,retain) NSString *urlReq;
@property (nonatomic,retain) NSString *resultCount;
@property (nonatomic,retain) NSString *recipientgender;
@property(nonatomic, retain) NSString *domain;
@property (nonatomic,retain) NSMutableArray *chatMsgId;
@property (nonatomic,retain) NSMutableArray *status;
@property (nonatomic,retain) NSMutableArray *text;
@property (nonatomic,retain) NSMutableArray *timestamp;
@property (nonatomic,retain) NSMutableArray *arrayCount;

@property (nonatomic,assign)float NewXval;

-(IBAction)textFieldChatEdited:(id)sender;
-(IBAction)textFieldDidBeginEditing:(UITextField *)textField;
-(IBAction)textFieldDidEndEditing:(UITextField *)textField;
-(IBAction)clickedImageButton:(id)sender;
-(IBAction)clickedHomeButton:(id)sender;
-(IBAction)clickedSendButton:(id)sender;
-(NSString *)FormatTime:(NSString *)ServerTimeStr;
- (void)getNewChats;

@end
