//
//  DetailedCommentViewController.h
//  Skadate
//
//  Created by Heinz Vallonthaiel on 8/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SkadateAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "NewsFeedCommentViewController.h"
#import "ProfileView.h"
#import "DisplayDateTime.h"


@interface DetailedCommentViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
        
    IBOutlet UINavigationBar *navBar;
    IBOutlet UIToolbar *toolBar;
    IBOutlet UIButton *commentBtn;
    IBOutlet UITableView *commentsTV;
    IBOutlet UILabel *navlbl;
    
    NSString *entityId;
    NSString *domain;
    NSMutableArray *commentArray;
    NSMutableArray *profilePics;
    NSMutableArray *thumbPicURLs;
       
    dispatch_queue_t queue;
    
    float NewXval;

}
@property (nonatomic,assign)float NewXval;

@property(nonatomic,retain) IBOutlet UITableView *commentsTV;

@property(nonatomic,retain) NSString *entityId;
@property(nonatomic,retain) NSString *domain;
@property(nonatomic,retain) NSMutableData *respData;
@property(nonatomic,retain) NSURLConnection *commentsConnection;
@property(nonatomic,retain) NSMutableArray *profilePics;
@property(nonatomic,retain) NSMutableArray *thumbPicURLs;
@property(nonatomic,retain) NSMutableArray *commentArray;

-(IBAction)clickedBackButton:(id)sender;
-(IBAction)clickedCommentButton:(id)sender;

@end
