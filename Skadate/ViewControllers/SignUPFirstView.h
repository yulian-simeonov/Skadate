//
//  SignUPFirstView.h
//  Chk
//
//  Created by SODTechnologies on 29/08/11.
//  Copyright 2011 Solutions On Demand Australasia Pty Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Structures.h"
#import <QuartzCore/QuartzCore.h>
#import "JSWaiter.h"
#import "JSWebManager.h"

@class SkadateViewController;
@class SignUPSecondView;


@interface SignUPFirstView : UIViewController 
{    
    SkadateViewController *objSkadateViewController;
    SignUPSecondView *objSignUPSecondView;
    SignUpInitialResp signUpResp;
    
    IBOutlet UIButton *btnSignIn;
    IBOutlet UIButton *btnNext;
    IBOutlet UIView *subView;
    IBOutlet UIImageView *imgView;
    IBOutlet UITextField *txtUsername;
    IBOutlet UITextField *txtPassword;
    IBOutlet UITextField *txtConfirmPassword;
    IBOutlet UITextField *txtSiteURL;
    IBOutlet UINavigationBar *navBar;
    IBOutlet UILabel *signuplab;
    IBOutlet UILabel *usernamelab;
    IBOutlet UILabel *passwordlab1;
    IBOutlet UILabel *passwordlab2;
    IBOutlet UILabel *siteurllab;
    IBOutlet UIScrollView *scrollview;
    
    NSString *strUsername;
    NSString *strPassword;
    NSString *strURL;
    NSString *strEncryptedPass;
    NSString *SALT;

    float NewXval;

}

@property (nonatomic, retain) SkadateViewController *objSkadateViewController;
@property (nonatomic, retain) SignUPSecondView *objSignUPSecondView;

@property (nonatomic, retain) IBOutlet UIButton *btnSignIn;
@property (nonatomic, retain) IBOutlet UIButton *btnNext;
@property (nonatomic, retain) IBOutlet UITextField *txtUsername;
@property (nonatomic, retain) IBOutlet UITextField *txtPassword;
@property (nonatomic, retain) IBOutlet UITextField *txtConfirmPassword;
@property (nonatomic, retain) IBOutlet UITextField *txtSiteURL;
@property (nonatomic, retain) IBOutlet UIView *subView;
@property (nonatomic, retain) IBOutlet UIImageView *imgView;
@property (nonatomic, retain) IBOutlet UILabel *usernamelab;
@property (nonatomic, retain) IBOutlet UILabel *passwordlab1;
@property (nonatomic, retain) IBOutlet UILabel *passwordlab2;
@property (nonatomic, retain) IBOutlet UILabel *siteurllab;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollview;

@property (nonatomic, retain) NSString *strUsername;
@property (nonatomic, retain) NSString *strPassword;
@property (nonatomic, retain) NSString *strURL;
@property (nonatomic, retain) NSString *strEncryptedPass;
@property (nonatomic, retain) NSString *SALT;

@property (nonatomic,assign)float NewXval;

- (IBAction)clickedSignInButton:(id)sender;
- (IBAction)clickedNextButton:(id)sender;
- (BOOL) validateUrl: (NSString *) testURL;
- (BOOL) siteUrlEmbedded;
- (NSString *) getSiteUrl;
- (void) animateTextField: (UITextField*) textField up: (BOOL) up;

@end
