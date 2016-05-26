//
//  forumAddTopicCell.h
//  Skadate
//
//  Created by Heinz Vallonthaiel on 27/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "NewsFeedsController.h"
#import "DisplayDateTime.h"

@interface forumAddTopicCell : UITableViewCell
{
    
    NSString *domain;
    NSDictionary *newsFeedItem;
    int index_row;
    NewsFeedsController *objNewsFeedsView;
    UIImage *profile_img;
    UIImage *group_img;
    UIButton *comment_btn; 
    UIButton *like_btn;
    
    dispatch_queue_t queue;

}

@property(nonatomic,retain) NSDictionary *newsFeedItem;
@property(nonatomic,retain) NSString *domain;
@property(nonatomic,assign) int index_row;
@property(nonatomic,assign) UIImage *profile_img;
@property(nonatomic,assign) UIImage *group_img;
@property(retain,nonatomic) UIButton *comment_btn;
@property(retain,nonatomic) UIButton *like_btn;


@end
