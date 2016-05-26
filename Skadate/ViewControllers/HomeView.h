//
//  ChkViewController.h
//  Chk
//
//  Created by SODTechnologies on 19/08/10.
//  Copyright 2010 Solutions On Demand Australasia Pty Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonMethods.h"
#import "CommonStaticMethods.h"
#import "LocationGetter.h"
#import "JSWebManager.h"
#import "JSWaiter.h"

@interface HomeView : UIViewController <UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPopoverControllerDelegate,UIAlertViewDelegate,NotificationCountDelegate>
{
    
    CommonMethods *fetchNot;
    LocationGetter *locationGetter;
    
    NSTimer *timer;
    NSTimer *timer1;
    
    NSInvocation *invocation;
    NSInvocation *invocation1;
    
    NSString *profilePic;
    NSString *profileID;
    NSString *msgOrient;
    NSString *domain;
    
    NSNumber *notifications;
    
    NSData * imageData;
    
    IBOutlet UIImageView *logoImgView; 
    IBOutlet UIButton *btnAvatar;
    IBOutlet UIButton *btnNotify;
    IBOutlet UIButton *btnSearch;
    IBOutlet UIButton *btnMyProfile;
    IBOutlet UIButton *btnMyPhoto;
    IBOutlet UIButton *btnInfo;
    IBOutlet UIButton *btnMailBox;
    IBOutlet UIButton *btnMembers;
    IBOutlet UIButton *btNewsFeeds;
    IBOutlet UIButton *btnMapView;
    IBOutlet UIButton *btnCamera;
    IBOutlet UINavigationBar *navBar;
    IBOutlet UIToolbar *toolBar;
    IBOutlet UILabel *lblNearBy;
    IBOutlet UIImageView *imgNotification;
    IBOutlet UILabel *lblMyProfile;
    IBOutlet UILabel *lblMyPhotos;
    IBOutlet UILabel *lblMailBox;
    IBOutlet UILabel *lblMembers;
    IBOutlet UILabel *lblSearch;
    IBOutlet UILabel *newsFeed;
    IBOutlet UIButton *btnMailCount;
    
    UIImage *logoImgage;
    
    BOOL camFlag;
    BOOL notifFlag;

    UIPopoverController *_popover;
      
    dispatch_queue_t queue;
    float NewXval;
    
}
@property (nonatomic,assign)float NewXval;
@property (nonatomic, retain) NSString *profilePic;
@property (nonatomic, retain) NSString *profileID;
@property (nonatomic, retain) NSString *msgOrient;
@property(nonatomic, retain) NSString *domain;

@property (nonatomic, retain) NSNumber *notifications;

@property (nonatomic,retain) NSTimer *timer;
@property (nonatomic,retain) NSTimer *timer1;

@property (nonatomic,retain) NSInvocation *invocation;
@property (nonatomic,retain) NSInvocation *invocation1;

@property (nonatomic, retain) UIImage *logoImgage;
@property (nonatomic, retain) UIPopoverController *_popover;

@property (nonatomic, retain) IBOutlet UIImageView *logoImgView; 
@property (nonatomic, retain) IBOutlet UIImageView *imgNotification;
@property (nonatomic, retain) IBOutlet UIButton *btnAvatar;
@property (nonatomic, retain) IBOutlet UIButton *btnNotify;
@property (nonatomic, retain) IBOutlet UIButton *btnSearch;
@property (nonatomic, retain) IBOutlet UIButton *btnMyProfile;
@property (nonatomic, retain) IBOutlet UIButton *btnMyPhoto;
@property (nonatomic, retain) IBOutlet UIButton *btnInfo;
@property (nonatomic, retain) IBOutlet UIButton *btnMailBox;
@property (nonatomic, retain) IBOutlet UIButton *btnMembers;
@property (nonatomic, retain) IBOutlet UIButton *btNewsFeeds;
@property (nonatomic, retain) IBOutlet UIButton *btnMapView;
@property (nonatomic, retain) IBOutlet UIButton *btnCamera;
@property (nonatomic, retain) IBOutlet UINavigationBar *navBar;
@property (nonatomic, retain) IBOutlet UIToolbar *toolBar;
@property (retain, nonatomic) IBOutlet UILabel *lblNearBy;
@property (nonatomic, retain) IBOutlet UILabel *lblMyProfile;
@property (nonatomic, retain) IBOutlet UILabel *lblMyPhotos;
@property (nonatomic, retain) IBOutlet UILabel *lblMailBox;
@property (nonatomic, retain) IBOutlet UILabel *lblMembers;
@property (nonatomic, retain) IBOutlet UILabel *lblSearch;
@property (nonatomic, retain) IBOutlet UIButton *btnMailCount;

-(IBAction)clickedMapButton:(id)sender;
-(IBAction)openPhotoLibrary:(id)sender;
-(IBAction)openProfileOptions:(id)sender;
-(IBAction)clickedSearchButton:(id)sender;
-(IBAction)clickedMyPhoto:(id)sender;
-(IBAction)clickedMyProfileButton:(id)sender;
-(IBAction)clickedInfoButton:(id)sender;
-(IBAction)clickedNotificationButton:(id)sender;
-(IBAction)clickedMailBoxButton:(id)sender;
-(IBAction)clickedMembersButton:(id)sender;
-(IBAction)clickedNewsFeedsButton:(id)sender;
-(IBAction)clickedMailCountButton:(id)sender;

-(void)GetAvatarChange;
-(void)	invokeCamera;
-(void) Upload: (NSData*) photoData;
-(void)logout;

@end
