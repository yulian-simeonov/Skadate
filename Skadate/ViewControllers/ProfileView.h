//
//  ProfileView.h
//  Chk
//
//  Created by SODTechnologies on 22/08/11.
//  Copyright 2011 Solutions On Demand Australasia Pty Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Structures.h"
#import <QuartzCore/QuartzCore.h>
#import "JSWaiter.h"
#import "JSWebManager.h"

@interface ProfileView : UIViewController <UIActionSheetDelegate,UIAlertViewDelegate>
{
       
    ProfileResp respProflieDetails;
    
    BOOL bookMarkFlag;
    BOOL OnlineFlag;
    BOOL isloading;
       
    NSString *fullName;
    NSString *sex;
    NSString *matchSex;
    NSString *dob;
    NSString *headline;
    NSString *realName;
    NSString *matchAgeRange;
    NSString *profilePicURL;
    NSString *profilenamestring;
    NSString *profileID;
    NSString *domain;
    NSString *imgstring;
    NSString *resultType;
    NSUInteger textViewValue;
    NSMutableString *genderstring;

    int selectImg;
    float NewXval;
       
    IBOutlet UIImageView *infoimgview;
    IBOutlet UIImageView *essayimgview;
    IBOutlet UITextView *infodettexview;
    IBOutlet UIButton *btnHome;
    IBOutlet UIButton *btnChat;
    IBOutlet UIButton *btnBookmark;
    IBOutlet UIButton *btnComposeMail;
    IBOutlet UIButton *actionsheetBtn;
    IBOutlet UILabel *lblProfileName;
    IBOutlet UIImageView *imgProfile;
    IBOutlet UITextView *txtInfo;
    IBOutlet UITextView *txtInfoName;
    IBOutlet UITextView *txtInfoAge;
    IBOutlet UITextView *txtViewEssays;
    IBOutlet UIScrollView *tempScrollView;
    IBOutlet UISegmentedControl *segmentCtrl;
    IBOutlet UINavigationBar *navBar;
    IBOutlet UIToolbar *toolBar;
    IBOutlet UILabel *profilelab;

    UIImage *myimage;
   
    dispatch_queue_t queue;
   
}

@property (nonatomic, retain) IBOutlet UIButton *btnHome;
@property (nonatomic, retain) IBOutlet UIButton *btnChat;
@property (nonatomic, retain) IBOutlet UIButton *btnBookmark;
@property (nonatomic, retain) IBOutlet UIButton *btnComposeMail;
@property (nonatomic, retain) IBOutlet UIButton *actionsheetBtn;
@property (nonatomic, retain) IBOutlet UILabel *lblProfileName;
@property (nonatomic, retain) IBOutlet UIImageView *imgProfile;
@property (nonatomic, retain) IBOutlet UITextView *txtInfo;
@property (nonatomic, retain) IBOutlet UITextView *txtInfoName;
@property (nonatomic, retain) IBOutlet UITextView *txtInfoAge;
@property (nonatomic, retain) IBOutlet UITextView *txtViewEssays;
@property (nonatomic, retain) IBOutlet UIScrollView *tempScrollView;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentCtrl;

@property (nonatomic,assign)float NewXval;
@property (nonatomic) int selectImg;


@property (nonatomic,retain) NSString *profileID;
@property (nonatomic,retain) NSString *imgstring;
@property (nonatomic,retain) NSString *profilenamestring;
@property (nonatomic,retain) NSString *domain;
@property (nonatomic,retain) NSString *resultType;
@property (nonatomic,retain) NSMutableString *genderstring;

-(NSString *)returnGender:(int)value;
-(IBAction) clickedSegmentContol;
-(IBAction)clickedOnlineButton:(id) sender;
-(IBAction)clickedChatButton:(id) sender;
-(IBAction)clickedMailButton:(id) sender;
-(IBAction)clickedBookmarkButton:(id) sender;
-(IBAction)clickedActionSheetButton:(id) sender;
-(void)textViewFunction;
-(void)SetEssaysFrame;

@end
