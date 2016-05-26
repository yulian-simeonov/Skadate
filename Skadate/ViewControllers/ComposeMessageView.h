//
//  ComposeMessageView.h
//  Skadate
//
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSWebManager.h"
#import "JSWaiter.h"

@interface ComposeMessageView : UIViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UIAlertViewDelegate>

{
      
    IBOutlet UIButton *btnCancel;
    IBOutlet UIButton *btnSend;
    IBOutlet UITextView *txtViewReply;
    IBOutlet UITextField *txtFldTo;
    IBOutlet UITextField *txtFldSubject;
    IBOutlet UILabel *tolab;
    IBOutlet UINavigationBar *navBar;
    IBOutlet UILabel *newmessagelab;
    
    UIImage *userImage;
    UIImageView *toimageview;
    UITableView *table;
    UILabel *lblOfName;

    NSString * val;
    NSString *profilenamestring;
    NSString *urlReq;
    NSString *firstchar;
    NSString *profilePicUrl;
    NSString *domain;
    NSString *userImageUrl;
    NSString *userGender;

    NSMutableArray *thumbPicURLs;
    NSMutableArray *imagearray;
    NSMutableArray *sortedProfileImageArray;
    NSMutableArray *searchedSortedProfileImageArray;
    NSMutableArray *samplearray;
    NSMutableArray *profileIdArray;
    NSMutableArray *sortedprofileIdArray;
    NSMutableArray *searchedprofileIdArray;
    NSMutableArray *genderArray;
    NSMutableArray *resultArray;
    NSMutableArray *sortedProfilePicImageArray;
    NSMutableArray *searchedSortedProfilePicImageArray;
    NSMutableArray *sortedgenderArray;
    NSMutableArray *searchedsortedgenderArray;
    NSMutableArray *profilePicImageArray;
    NSArray *sortedArray;
    
    int selectedprofileid;
         
    BOOL clear;
    BOOL selec;
    BOOL sendFlag;
    BOOL decision;
    BOOL picFlag;
    BOOL loading;
    
    dispatch_queue_t queue;
    dispatch_queue_t imgQueue;
    
    float NewXval;
}
@property (nonatomic,assign)float NewXval;
@property(nonatomic,assign) int selectedprofileid;

@property(retain,nonatomic) IBOutlet UILabel *lblCharCount;
@property(nonatomic,retain) IBOutlet UIButton *btnCancel;
@property(nonatomic,retain) IBOutlet UIButton *btnSend;
@property(nonatomic,retain) IBOutlet UITextView *txtViewReply;
@property(nonatomic,retain) IBOutlet UITextField *txtFldTo;
@property(nonatomic,retain) IBOutlet UITextField *txtFldSubject;

@property(nonatomic,retain) UIImage *userImage;
@property(nonatomic,retain) UILabel *tolab;

@property(nonatomic,retain) NSArray *sortedArray;
@property(nonatomic,retain) NSString *profilePicUrl;
@property(nonatomic,retain) NSString *userImageUrl;
@property(nonatomic,retain) NSString *userGender;
@property(nonatomic,retain) NSString *profilenamestring;
@property(nonatomic,retain) NSString *domain;
@property(nonatomic,retain) NSMutableArray *samplearray;

@property(nonatomic,retain) NSMutableArray *profileIdArray;
@property(nonatomic,retain) NSMutableArray *resultArray;
@property(nonatomic,retain) NSMutableArray *sortedprofileIdArray;
@property(nonatomic,retain) NSMutableArray *sortedProfilePicImageArray;
@property(nonatomic,retain) NSMutableArray *thumbPicURLs;
@property(nonatomic,retain) NSMutableArray *imagearray;
@property(nonatomic,retain) NSMutableArray *sortedProfileImageArray;
@property(nonatomic,retain) NSMutableArray *searchedSortedProfileImageArray;
@property(nonatomic,retain) NSMutableArray *searchedprofileIdArray;
@property(nonatomic,retain) NSMutableArray *searchedSortedProfilePicImageArray;
@property(nonatomic,retain) NSMutableArray *genderArray;
@property(nonatomic,retain) NSMutableArray *sortedgenderArray;
@property(nonatomic,retain) NSMutableArray *searchedsortedgenderArray;
@property(nonatomic,retain) NSMutableArray *profilePicImageArray;

@property(nonatomic)BOOL decision;

-(IBAction)clickedCancelButton:(id) sender;
-(IBAction)clickedSendButton:(id) sender;
-(IBAction)sortingTextClick;



@end
