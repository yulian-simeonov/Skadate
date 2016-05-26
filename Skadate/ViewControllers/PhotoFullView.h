//
//  PhotoFullView.h
//  Chk
//
//  Created by SODTechnologies on 24/08/11.
//  Copyright 2011 Solutions On Demand Australasia Pty Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPhotosView.h"
#import <QuartzCore/QuartzCore.h>
#import "JSWebManager.h"
#import "JSWaiter.h"

@interface PhotoFullView : UIViewController<UIActionSheetDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate> 
{
    
     MyPhotosView *objMyPhotosView;
    IBOutlet UIButton *btnMyPhotos;
    IBOutlet UIButton *btnSave;
    IBOutlet UIButton *btnNext;
    IBOutlet UIButton *btnPrev;
    IBOutlet UINavigationBar *navBar;
    IBOutlet UIImageView *imgView;
    IBOutlet UIActivityIndicatorView *act;
    IBOutlet UILabel *lblTitle;
    IBOutlet UIBarButtonItem *reportItem;
    IBOutlet UIToolbar *toolBar;
    IBOutlet UIScrollView *scrollView;
    
    NSArray *imgURLs;
    NSInteger imgIndex;
    NSString *domain;
    NSString *strRep;
    NSString *profileId;
    NSString *urlReq;
    NSMutableArray *imgIDArr;

    BOOL mSwiping;
	BOOL swipeDone;
    BOOL fromMyphotos;
    
	CGFloat mSwipeStart;
    
    int fla;
    int resultCount;
   
    float NewXval; 
   
}

@property(nonatomic, retain) IBOutlet UIButton *btnMyPhotos;
@property(nonatomic, retain) IBOutlet UIButton *btnSave;
@property(nonatomic, retain) IBOutlet UIButton *btnNext;
@property(nonatomic, retain) IBOutlet UIButton *btnPrev;
@property(nonatomic, retain) IBOutlet UINavigationBar *navBar;
@property(nonatomic, retain) IBOutlet UIImageView *imgView;
@property(nonatomic, retain) IBOutlet UIActivityIndicatorView *act;
@property (retain,nonatomic) IBOutlet UIButton *Actbut;
@property(nonatomic, retain) IBOutlet UILabel *lblTitle;
@property (retain,nonatomic) IBOutlet UIBarButtonItem *ActButt;
@property (retain,nonatomic) IBOutlet UIScrollView *scrollView;

@property(nonatomic, retain) NSArray *imgURLs;
@property(nonatomic, retain) NSString *domain;
@property(nonatomic, retain) NSString *profileId;
@property(nonatomic, retain) NSString *strRep;
@property(nonatomic, readwrite) NSInteger imgIndex;
@property(nonatomic, retain) NSMutableArray *imgIDArr;
@property(nonatomic, retain) NSMutableArray *imgArr;

@property(nonatomic, retain) MyPhotosView *objMyPhotosView;
@property(nonatomic, assign) int resultCount;
@property (nonatomic,assign) float NewXval;

@property(nonatomic,readwrite) BOOL fromMyphotos;

-(IBAction)clickedReportButton:(id) sender;
-(IBAction)clickedMyPhotosButton:(id) sender;
-(IBAction)clickedSaveButton:(id) sender;
-(IBAction)clickedNextButton:(id) sender;
-(IBAction)clickedPrevButton:(id) sender;

-(void)handleSwipeFrom:(UISwipeGestureRecognizer*)recognizer;
-(void)loadPic;
-(void)loading;

@end
