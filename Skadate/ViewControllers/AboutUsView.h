//
//  AboutUsView.h
//  Chk
//
//  Created by SODTechnologies on 25/08/11.
//  Copyright 2011 Solutions On Demand Australasia Pty Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface AboutUsView : UIViewController 
{
    
    IBOutlet UIButton *closeButton;
    IBOutlet UISegmentedControl *segControl;
    IBOutlet UINavigationBar *navBar;
    IBOutlet UILabel *aboutuslab;
    IBOutlet UIWebView *webView;
    IBOutlet UITextView *textViewInfo;
    
    float NewXval;
    
    NSMutableData *respData;
    NSString *urlReq;
    NSString *textViewDetails;
    NSString *domain;
  
    BOOL aboutUsFlag;
    BOOL termsofuseFlag;
    BOOL privacyFlag;
    BOOL fullversionFlag;
    
    UILabel *indicatorLabel;
    UIView *indicatorView;
    UIActivityIndicatorView *objIndicatorView;
}

@property(nonatomic,retain) IBOutlet UITextView *textViewInfo;
@property(nonatomic,retain) IBOutlet UIButton *closeButton;
@property(nonatomic,retain) IBOutlet UISegmentedControl *segControl;

@property(nonatomic,retain) UILabel *indicatorLabel;
@property(nonatomic,retain) UIView *indicatorView;
@property(nonatomic,retain) UIActivityIndicatorView *objIndicatorView;

@property(nonatomic, retain) NSString *domain;

-(IBAction)clikedClosedButton:(id) sender;
-(IBAction) clickedSegmentContol; 

@end
