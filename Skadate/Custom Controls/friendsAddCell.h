//
//  friendsAddCell.h
//  Skadate
//
//  Created by Heinz Vallonthaiel on 27/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "NewsFeedsController.h"
#import "DisplayDateTime.h"

@interface friendsAddCell : UITableViewCell
{       
    NSString *domain;
    NSDictionary *newsFeedItem;
    
    UIButton *comment_friendsAdd_btn; 
    UIButton *like_friendsAdd_btn;
    UIImageView *frnd_img1;
    UIImageView *frnd_img2;
    UIImage *profile_img;
    UIImage *friend_img;
    
    NewsFeedsController *objNewsFeedsView;
    
    int index_row;
    dispatch_queue_t queue;

}

@property(nonatomic,retain) NSDictionary *newsFeedItem;
@property(nonatomic,retain) NSString *domain;
@property(retain,nonatomic) UIButton *comment_friendsAdd_btn; 
@property(retain,nonatomic) UIButton *like_friendsAdd_btn;
@property(retain,nonatomic) UIImageView *frnd_img1;
@property(retain,nonatomic) UIImageView *frnd_img2;
@property(retain,nonatomic) UIImage *profile_img;
@property(retain,nonatomic) UIImage *friend_img;
@property(nonatomic,assign) int index_row;

@end
