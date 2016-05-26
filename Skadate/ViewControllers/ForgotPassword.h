//
//  ForgotPassword.h
//  Chk
//
//  Created by kavitha on 31/08/11.
//  Copyright 2011 Solutions On Demand Australasia Pty Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Structures.h"
#import <QuartzCore/QuartzCore.h>
#import "JSWaiter.h"
#import "JSWebManager.h"

@class SkadateViewController;

@interface ForgotPassword : UIViewController 
{
    
    IBOutlet UIButton *btnClose;
    IBOutlet UITextField *mailID;
    IBOutlet UILabel *lblNavTitle;
    IBOutlet UILabel *lblforgotpass;
    IBOutlet UIImageView *imgView;
    IBOutlet UINavigationBar *navBar;
    IBOutlet UILabel *siteUrlLbl;
    IBOutlet UITextField *siteUrTF;
    IBOutlet UILabel *lblDefaultText;
    
    SkadateViewController *objSignInView;
    ForgotPasswordResp respForgotPw;
    
    NSString *strURL;
    
    float NewXval;
}

@property (retain, nonatomic) IBOutlet UILabel *lblDefaultText;
@property (nonatomic, retain) IBOutlet UIButton *btnClose;
@property (nonatomic, retain) IBOutlet UITextField *mailID;
@property (nonatomic, retain) IBOutlet UILabel *lblNavTitle;
@property (nonatomic, retain) IBOutlet UINavigationBar *navBar;
@property (nonatomic, retain) IBOutlet UIImageView *imgView;
@property (nonatomic, retain) IBOutlet UILabel *siteUrlLbl;
@property (nonatomic, retain) IBOutlet UITextField *siteUrTF;

@property (nonatomic, retain) UILabel *lblforgotpass;

@property (nonatomic,assign)float NewXval;

@property (nonatomic, retain) SkadateViewController *objSignInView;

@property (nonatomic, retain) NSString *strURL;

- (BOOL)validateEmailWithString:(NSString*)email;
- (BOOL)siteUrlEmbedded;
- (NSString *)getSiteUrl;
- (IBAction)clickedCloseButton:(id)sender;
- (BOOL) validateUrl: (NSString *) testURL ;

@end