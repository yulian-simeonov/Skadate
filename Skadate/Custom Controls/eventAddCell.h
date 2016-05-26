//
//  eventAddCell.h
//  Skadate
//
//  Created by Heinz Vallonthaiel on 27/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "NewsFeedsController.h"
#import "DisplayDateTime.h"

@interface eventAddCell : UITableViewCell
{    
    NSString *domain;
    NSDictionary *newsFeedItem;
    UIButton *comment_btn; 
    UIButton *like_btn;
    UIImage *profile_img;
    UIImage *event_img;
    
    dispatch_queue_t queue;
    dispatch_queue_t queue1;

    int index_row;
    NewsFeedsController *objNewsFeedsView;
  
}

@property(nonatomic,retain) NSDictionary *newsFeedItem;
@property(nonatomic,retain) NSString *domain;
@property(retain,nonatomic) UIButton *comment_btn;
@property(retain,nonatomic) UIButton *like_btn;
@property(retain,nonatomic) UIImage *profile_img;
@property(retain,nonatomic) UIImage *event_img;
@property(nonatomic,assign) int index_row;



@end
