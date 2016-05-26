//
//  MyProfileView.h
//  Chk
//
//  Created by SODTechnologies on 14/09/11.
//  Copyright 2011 Solutions On Demand Australasia Pty Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Structures.h"
#import <QuartzCore/QuartzCore.h>
#import "JSWebManager.h"
#import "JSWaiter.h"

@interface MyProfileView : UIViewController
{
 
    ProfileResp respProflieDetails;
       
    NSString *profileID;
    NSString *fullName;
    NSString *sex;
    NSString *matchSex;
    NSString *dob;
    NSString *headline;
    NSString *realName;
    NSString *matchAgeRange;
    NSString *profilePicURL;
    NSString *domain;
    NSNumber *notifications;
    NSUInteger textViewValue;
    
    BOOL loadFlag;
    BOOL notifFlag;
    
    IBOutlet UIButton *btnHome;
    IBOutlet UIButton *btnLogOut;
    IBOutlet UIButton *btnNotify;
    IBOutlet UILabel *lblProfileName;
    IBOutlet UIImageView *imgProfile;
    IBOutlet UITextView *txtInfo;
    IBOutlet UITextView *txtInfoName;
    IBOutlet UITextView *txtInfoAge;
    IBOutlet UITextView *txtViewEssays;
    IBOutlet UIScrollView *tempScrollView;
    IBOutlet UIImageView *imgNotification;
    IBOutlet UILabel *lblNavTitle;
    IBOutlet UIImageView *dividerLineImage;
    IBOutlet UINavigationBar *navBar;
    IBOutlet UIToolbar *toolBar;
    IBOutlet UIImageView *infoimgview;
    IBOutlet UIImageView *essayimgview;
    IBOutlet UITextView *infodettexview;
    
    dispatch_queue_t queue;
   
    float NewXval;
}

@property (nonatomic, retain) IBOutlet UIButton *btnHome;
@property (nonatomic, retain) IBOutlet UIButton *btnLogOut;
@property (nonatomic, retain) IBOutlet UIButton *btnNotify;
@property (nonatomic, retain) IBOutlet UILabel *lblProfileName;
@property (nonatomic, retain) IBOutlet UIImageView *imgProfile;
@property (nonatomic, retain) IBOutlet UITextView *txtInfo;
@property (nonatomic, retain) IBOutlet UITextView *txtInfoName;
@property (nonatomic, retain) IBOutlet UITextView *txtInfoAge;
@property (nonatomic, retain) IBOutlet UITextView *txtViewEssays;
@property (nonatomic, retain) IBOutlet UIScrollView *tempScrollView;
@property (nonatomic, retain) IBOutlet UIToolbar *toolBar;
@property (nonatomic, retain) IBOutlet UIImageView *imgNotification;
@property (nonatomic, retain) IBOutlet UILabel *lblNavTitle;
@property (nonatomic, retain) IBOutlet UINavigationBar *navBar;
@property (nonatomic, retain) IBOutlet UIImageView *dividerLineImage;

@property (nonatomic,assign)float NewXval;

@property(nonatomic, retain) NSString *domain;
@property(nonatomic, retain) NSString *profileID;

-(IBAction)clickedHomeButton:(id) sender;
-(IBAction)clickedLogoutButton:(id) sender;
-(IBAction)clickedNotificationButton:(id)sender;
-(IBAction)closeToolBar:(id)sender;
-(NSString *)returnGender:(int)value;
-(void)textViewFunction;
-(void)SetEssaysFrame;

@end
