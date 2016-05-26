//
//  NewsFeedsController.h
//  Skadate
//
//  Created by SOD MAC4 on 24/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsFeedCommentViewController.h"
#import "CommonMethods.h"
#import "ProfileView.h"
#import "JSWaiter.h"
#import "JSWebManager.h"

@interface NewsFeedsController : UIViewController<UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
         
    IBOutlet UINavigationBar *navBar;
    IBOutlet UILabel *navLable;
    IBOutlet UITableView *newsFeedTV;
    
    NSString *textPull;
    NSString *textRelease;
    NSString *textLoading;
    NSString *domain;

    NSMutableArray *newsFeedsItemArray;
    NSMutableArray *ProfilePicURLs;
    NSMutableArray *ProfilePicImages;
    NSMutableArray *Friend_PicUrls;
    NSMutableArray *Friend_Pics;
    NSMutableArray *imgUpload_PicsUrls;
    NSMutableArray *imgUpload_Pics;
    NSMutableArray *statusArray;

    UIActivityIndicatorView *smallIndicatorView;
    UIActivityIndicatorView *refreshSpinner;
    
    UIView *refreshHeaderView;
    UILabel *refreshLabel;
    UIImageView *refreshArrow;

    BOOL fromCommentView;
    BOOL youLiked;
    BOOL likesConnected;
    BOOL isDragging;
    BOOL isLoading;
    
    int selectedLike;
    
    float NewXval;
    
}

@property (nonatomic,retain) IBOutlet UINavigationBar *navBar;
@property (nonatomic,retain) IBOutlet UILabel *navLable;
@property (nonatomic,retain) IBOutlet UITableView *newsFeedTV;

@property (nonatomic,  copy) NSString *textPull;
@property (nonatomic,  copy) NSString *textRelease;
@property (nonatomic,  copy) NSString *textLoading;
@property (nonatomic,retain) NSString *domain;
@property (nonatomic,retain) NSMutableArray *newsFeedsItemArray;
@property (nonatomic,retain) NSMutableArray *ProfilePicURLs;
@property (nonatomic,retain) NSMutableArray *ProfilePicImages;
@property (nonatomic,retain) NSMutableArray *Friend_Pics;
@property (nonatomic,retain) NSMutableArray *Friend_PicUrls;
@property (nonatomic,retain) NSMutableArray *imgUpload_PicsUrls;
@property (nonatomic,retain) NSMutableArray *imgUpload_Pics;

@property (nonatomic,assign) int selectedLike;
@property (nonatomic,assign) BOOL fromCommentView;
@property (nonatomic,assign) BOOL youLiked;
@property (nonatomic,retain) UIActivityIndicatorView *smallIndicatorView;

@property (nonatomic, retain) UIView *refreshHeaderView;
@property (nonatomic, retain) UILabel *refreshLabel;
@property (nonatomic, retain) UIImageView *refreshArrow;
@property (nonatomic, retain) UIActivityIndicatorView *refreshSpinner;

@property (nonatomic,assign)float NewXval;

-(IBAction)clickedBackButton:(id)sender;
-(CGFloat)heightForNewsFeedCell:(NSString *)type andPhotoUploadStatus:(NSString *)uploadStatus;

-(void)likeButtonClicked:(id)sender;
-(void)commentButtonClicked:(id)sender;
-(void)commentsCountButtonClicked:(id)sender;
-(void)likesCountButtonClicked:(id)sender;
-(void)profileButtonClicked:(id)sender;
-(void)FrdProfileButtonClicked:(id)sender;

// pull down refresh.........//
- (void)setupStrings;
- (void)addPullToRefreshHeader;
- (void)startLoading;
- (void)stopLoading;
- (void)refresh;
/////////////////////

@end
