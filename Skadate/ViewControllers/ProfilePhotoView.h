//
//  ProfilePhotoView.h
//  Chk
//
//  Created by SODTechnologies on 23/08/11.
//  Copyright 2011 Solutions On Demand Australasia Pty Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonMethods.h"
#import "JSWaiter.h"
#import "JSWebManager.h"

@interface ProfilePhotoView : UIViewController<UIAlertViewDelegate,NotificationCountDelegate> 
{
    
    IBOutlet UISegmentedControl *segmentControl;
    IBOutlet UIButton *btnHome;
    IBOutlet UIButton *btnChat;
    IBOutlet UIButton *btnBookmark;
    IBOutlet UIButton *btnComposeMail;
    IBOutlet UIScrollView *tempScrollView;
    IBOutlet UINavigationBar *navBar;
    IBOutlet UIToolbar *toolBar;
    IBOutlet UILabel *photoslab;
    
    BOOL bookMarkFlag;
    BOOL OnlineFlag;
    BOOL picFlag;
    BOOL loadFlag;  
    
    int backbtnimgId;
    
    NSString *profileId;
    NSString *profileName;
    NSString *profilegenderId;
    NSString *photoimgstring;
    NSString *domain;
    
    NSOperationQueue *queue;
    NSTimer *timer;
    NSInvocation *invocation;
    NSMutableArray *addedPicURLs;
    NSMutableArray *thumbPicURLs;

    UIImageView *imageView;
    UIButton *imgBtn;
  
    CommonMethods *fetchNot;
    
    float NewXval;
   
}

@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentControl;
@property (nonatomic, retain) IBOutlet UIButton *btnHome;
@property (nonatomic, retain) IBOutlet UIButton *btnChat;
@property (nonatomic, retain) IBOutlet UIButton *btnBookmark;
@property (nonatomic, retain) IBOutlet UIButton *btnComposeMail;
@property (nonatomic, retain) IBOutlet UIScrollView *tempScrollView;

@property (nonatomic,assign)float NewXval;
@property (nonatomic, retain) NSMutableArray *thumbPicURLs;
@property (nonatomic, retain) NSString *profileId;
@property (nonatomic, retain) NSString *profileName;
@property (nonatomic, retain) NSString *profilegenderId;
@property (nonatomic, retain) NSString *photoimgstring;

@property (nonatomic) int backbtnimgId;
@property (nonatomic, retain) NSString *domain;
@property (nonatomic, retain) NSOperationQueue *queue;
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain) NSInvocation *invocation;
@property (nonatomic, retain) NSMutableArray *addedPicURLs;

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UIButton *imgBtn;

-(IBAction)clickedSegmentControllerSearchedSaved;
-(IBAction)clickedOnlineButton:(id) sender;
-(IBAction)clickedChatButton:(id) sender;
-(IBAction)clickedMailButton:(id) sender;
-(IBAction)clickedBookmarkButton:(id) sender;
-(void)loadDefaultImage;
-(void)RefreshProfilePhotos;

@end
