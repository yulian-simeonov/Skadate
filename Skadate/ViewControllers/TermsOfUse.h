//
//  TermsOfUse.h
//  Chk
//
//  Created by kavitha on 01/09/11.
//  Copyright 2011 Solutions On Demand Australasia Pty Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignUPSecondView.h" 

@class SkadateViewController;

@interface TermsOfUse : UIViewController<UIAlertViewDelegate> 
{    
    IBOutlet UINavigationBar *navBar;
    IBOutlet UILabel *lblNavTitle;
    IBOutlet UITextView *textView;

    NSString *urlReq;
    NSString *textViewDetails;
    NSString *domain;
    
    SignUPSecondView *objSignUPSecondView;
    SkadateViewController *objSignInView;
    
    float NewXval;
}

@property (nonatomic, retain) IBOutlet UINavigationBar *navBar;
@property (nonatomic, retain) IBOutlet UILabel *lblNavTitle;
@property (nonatomic, retain) IBOutlet IBOutlet UITextView *textView;

@property (nonatomic, retain)  NSString *urlReq;
@property (nonatomic, retain)  NSString *textViewDetails;
@property (nonatomic, retain)  NSString *domain;

@property (nonatomic,assign)float NewXval;
@property (nonatomic, retain) SignUPSecondView *objSignUPSecondView;
@property (nonatomic, retain) SkadateViewController *objSignInView;


- (IBAction)clickedAccept:(UIButton *)button;
- (IBAction)clickedDecline:(UIButton *)button;
- (IBAction)clickedClose:(UIButton *)button;

@end
