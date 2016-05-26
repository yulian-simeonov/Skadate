//
//  SkadateAppDelegate.h
//  Skadate
//
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "JSON.h"
#import "CommonStaticMethods.h"


@class SkadateViewController;

@interface SkadateAppDelegate : NSObject <UIApplicationDelegate,UIAlertViewDelegate> {
    
    UIWindow *window;
    UIImageView *splashView;
    UINavigationController *navigation;
    UIImage *loggedUserImg;
    UIImage *loggedUserChatImg;
    UIFont *fontNavTitle;
    UIFont *fontHomeTitle;

    SkadateViewController *viewController;
        
    NSNumber *loggedNotifications;
    NSNumber *loggedMailCount;
    
    NSString *loggedProfilePic;
    NSString *loggedProfileID;
    NSString *loggedSessionID;
    NSString *loggedTimeZone;
    NSString *loggedUserStatus;
    NSString *loggedUserUnRegistered;
    NSString *loggedUserMessage;
    NSString *username;
    NSString *password;
    //NSString *salt;
    NSString *siteURL;
    NSString * genderValue;
    NSString *domain;
    NSMutableData *respData;
    NSURLConnection *NotificationCountConnection;
    NSURLConnection *LocationUpdateConnection;
    NSTimer *appDelegateTimer;
    NSInvocation *appDelegateinvocation;
       
    float redVal;
    float greenVal;
    float blueVal;
    float redNavbar;
    float greenNavbar;
    float blueNavbar;
    float redNavBorder;
    float greenNavBorder;
    float blueNavBorder;
    float redOrangeText;
    float greenOrangeText;
    float blueOrangeText;
    
    BOOL fromCommentView;
    BOOL fromlikesView_liked;
    BOOL fromlikesView_Unliked;
     
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SkadateViewController *viewController;

@property (nonatomic, retain) NSNumber *loggedNotifications;
@property (nonatomic, retain) NSNumber *loggedMailCount;
@property (nonatomic, retain) NSString *loggedUserMessage;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;
//@property (nonatomic, retain) NSString *salt;
@property (nonatomic, retain) NSString *siteURL;
@property (nonatomic, retain) NSString * genderValue;
@property (nonatomic, retain) NSString *loggedProfilePic;
@property (nonatomic, retain) NSString *loggedProfileID;
@property (nonatomic, retain) NSString *loggedSessionID;
@property (nonatomic, retain) NSString *loggedTimeZone;
@property (nonatomic, retain) NSString *loggedUserStatus;
@property (nonatomic, retain) NSString *loggedUserUnRegistered;
@property (nonatomic, retain) NSString *domain;
@property (nonatomic, retain) NSMutableData *respData;
@property (nonatomic, retain) NSURLConnection *NotificationCountConnection;
@property (nonatomic, retain) NSTimer *appDelegateTimer;
@property (nonatomic, retain) NSInvocation *appDelegateinvocation;

@property (nonatomic, retain) UIImageView *splashView;
@property (nonatomic, retain) UINavigationController *navigation;
@property (nonatomic, retain) UIImage *loggedUserImg;
@property (nonatomic, retain) UIImage *loggedUserChatImg;
@property (nonatomic, retain) UIFont *fontNavTitle;
@property (nonatomic, retain) UIFont *fontHomeTitle;

@property (nonatomic, assign) BOOL fromCommentView;
@property (nonatomic, assign) BOOL fromlikesView_liked;
@property (nonatomic, assign) BOOL fromlikesView_Unliked;

@property (nonatomic, readwrite) float redVal;
@property (nonatomic, readwrite) float greenVal;
@property (nonatomic, readwrite) float blueVal;
@property (nonatomic, readwrite) float redNavbar;
@property (nonatomic, readwrite) float greenNavbar;
@property (nonatomic, readwrite) float blueNavbar;
@property (nonatomic, readwrite) float redNavBorder;
@property (nonatomic, readwrite) float greenNavBorder;
@property (nonatomic, readwrite) float blueNavBorder;

-(void )fetchNotificationData;

@end
