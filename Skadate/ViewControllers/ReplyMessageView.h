//
//  ReplyMessageView.h
//  Skadate
//
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "JSWaiter.h"
#import "JSWebManager.h"

@interface ReplyMessageView : UIViewController
{
    IBOutlet UIButton *btnCancel;
    IBOutlet UIButton *btnSend;
    IBOutlet UITextView *messageTxt;
    IBOutlet UITextView *replyMessageTxt;
    IBOutlet UILabel *replyTxtLabel;
    IBOutlet UIScrollView *scroller;
    IBOutlet UINavigationBar *navBar;
    
    NSString *messageTextView;
    NSString *rplyMessageTxt;
    NSString *mesageId;
    NSString *domain; 
   
    float NewXval;
}
@property (nonatomic,retain) IBOutlet UIButton *btnCancel;
@property (nonatomic,retain) IBOutlet UIButton *btnSend;
@property (nonatomic,retain) IBOutlet UITextView *messageTxt;
@property (nonatomic,retain) IBOutlet UITextView *replyMessageTxt;
@property (nonatomic,retain) IBOutlet UILabel *replyTxtLabel; 
@property (nonatomic,retain) IBOutlet UIScrollView *scroller;

@property (nonatomic,assign)float NewXval;

@property (nonatomic,retain) NSString *messageTextView;
@property (nonatomic,retain) NSString *rplyMessageTxt;
@property (nonatomic,retain) NSString *mesageId;
@property(nonatomic, retain) NSString *domain;


-(IBAction)clickedCancelButton:(id) sender;
-(IBAction)clickedSendButton:(id) sender;

@end
