//
//  profileAvatarChangeCell.h
//  Skadate
//
//  Created by Heinz Vallonthaiel on 27/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "NewsFeedsController.h"
#import "DisplayDateTime.h"

@interface profileAvatarChangeCell : UITableViewCell
{    
    NSString *domain;
    NSDictionary *newsFeedItem;
    UIButton *comment_btn; 
    UIButton *like_btn;
    UIImage *profile_img;
    
    int index_row;
    NewsFeedsController *objNewsFeedsView;
    
    dispatch_queue_t queue;

}

@property(nonatomic,retain) NSDictionary *newsFeedItem;
@property(nonatomic,retain) NSString *domain;
@property(retain,nonatomic) UIButton *comment_btn;
@property(retain,nonatomic) UIButton *like_btn;
@property(nonatomic,assign) UIImage *profile_img;
@property(nonatomic,assign) int index_row;


@end
