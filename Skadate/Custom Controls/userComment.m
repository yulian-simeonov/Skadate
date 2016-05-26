//
//  userComment.m
//  Skadate
//
//  Created by Heinz Vallonthaiel on 27/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "userComment.h"
#import "CommonStaticMethods.h"

@implementation userComment

@synthesize newsFeedItem;
@synthesize domain;
@synthesize comment_btn;
@synthesize like_btn;
@synthesize index_row;
@synthesize profile_img;


#pragma mark initWithStyle

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {
        // Initialization code
    }
    return self;
}


#pragma mark Custom Methods

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(NSString *)FormatTime:(NSString *)ServerTimeStr
{
    NSString *serverTime =ServerTimeStr;
    NSString * serverTimeZone=((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedTimeZone;
    NSString *TimeZoneName=[[NSTimeZone systemTimeZone] name];
    
    DisplayDateTime *objDisplayDateTime =[[DisplayDateTime alloc]init];
    NSString *result= [objDisplayDateTime CalculateTime:serverTime andServerTimeZone:serverTimeZone andDeviceTimeZone:TimeZoneName];
    [objDisplayDateTime release];
    return result;
}

-(void)layoutSubviews
{    
    [super layoutSubviews];
        
    UIButton *imgview_btn=[[[UIButton alloc]initWithFrame:CGRectMake(7, 10, 70, 70)] autorelease];
    imgview_btn.tag=index_row;
    imgview_btn.layer.cornerRadius=6.0;
    imgview_btn.layer.masksToBounds=YES;
    [imgview_btn setImage:profile_img forState:UIControlStateNormal];
    [self.contentView addSubview:imgview_btn];
    [imgview_btn addTarget:objNewsFeedsView action:@selector(profileButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    NSString *generVal=(NSString*)[newsFeedItem valueForKey:@"sex"];
    
    // Lazy image loading         
    NSString *profilePicURL=[NSString stringWithFormat:@"%@%@",domain,[newsFeedItem valueForKey:@"Profile_Pic"]];
    
    NSString *imageName=[NSString stringWithFormat:@"%@",[newsFeedItem valueForKey:@"Profile_Pic"]];
    //imageName=[imageName stringByReplacingOccurrencesOfString:@"/$userfiles/" withString:@""];  // for old version
    imageName=[imageName stringByReplacingOccurrencesOfString:@"/userfiles/" withString:@""];  // for new version
    NSString *originalPath =[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]  stringByAppendingPathComponent:@"Images"];
           
    NSString *localFilePath = [originalPath stringByAppendingPathComponent:imageName];
    
    BOOL isDir=[CommonStaticMethods directoryExistsAtAbsolutePath:[originalPath stringByAppendingPathComponent:@"profile.png"]];
   
    if(!isDir)
    {       
        [[NSFileManager defaultManager]createDirectoryAtPath: originalPath withIntermediateDirectories: YES attributes: nil error: NULL];
    }
    
    dispatch_async(queue, ^{
        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:localFilePath];
        if (!fileExists)
        {
            
            NSURL *imageURL = [[[NSURL alloc] initWithString:profilePicURL]autorelease];            
            NSURLRequest *request = [NSURLRequest requestWithURL:imageURL];
            [NSURLConnection connectionWithRequest:request delegate:self];
            NSData *thedata = [NSData dataWithContentsOfURL:imageURL];
            [thedata writeToFile:localFilePath atomically:YES];
        }
        UIImage* image = [UIImage imageWithContentsOfFile:localFilePath];
        dispatch_sync(dispatch_get_main_queue(), ^{
            if(image)
            {
                profile_img=image;
            }
            else
            {
                if ((generVal == (id)[NSNull null])||([generVal length] == 0)||(generVal==NULL)) 
                {                                                      
                    profile_img=[UIImage imageNamed:@"man.png"];
                }
                else
                {
                    
                    if ([generVal intValue]==1) 
                    {
                        profile_img=[UIImage imageNamed:@"women.png"];
                    }
                    else if ([generVal intValue]==2) 
                    {
                        profile_img=[UIImage imageNamed:@"man.png"];
                    }
                    else if ([generVal intValue]==4) 
                    {
                        profile_img=[UIImage imageNamed:@"man_women.png"];
                    }
                    else if ([generVal intValue]==8) 
                    {
                        profile_img=[UIImage imageNamed:@"man_women_a.png"];
                    }
                    else 
                    {
                        profile_img=[UIImage imageNamed:@"man.png"];
                    } 
                }
            }
            [imgview_btn setImage:profile_img forState:UIControlStateNormal];
        });
    });  
    
    dispatch_release(queue);

    
    UIButton *profileName=[UIButton buttonWithType:UIButtonTypeCustom];
    CGSize constraintSize;
    constraintSize.height = MAXFLOAT;
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {        
        constraintSize.width = 500.0f;
    }
    else
    {        
        constraintSize.width = 215.0f;
    }
    
    NSString *nameStr;
    if ( ([newsFeedItem valueForKey:@"username"] == (id)[NSNull null])
        || [newsFeedItem valueForKey:@"username"] == NULL
        || [[newsFeedItem valueForKey:@"username"] isEqualToString:@""] )
    {
        nameStr = @" ";
    }
    else
    {        
        nameStr=[newsFeedItem valueForKey:@"username"];
    }
    
    profileName.titleLabel.font=[UIFont fontWithName:@"Ubuntu-Bold" size:18];
    
    CGSize stringSize =[nameStr sizeWithFont:profileName.titleLabel.font  constrainedToSize: constraintSize lineBreakMode: UILineBreakModeTailTruncation];
    profileName.titleLabel.lineBreakMode=UILineBreakModeTailTruncation;

    CGRect rect = CGRectMake(84, 10, stringSize.width, stringSize.height);
    profileName.frame=rect;
    profileName.tag=index_row;
    [profileName setTitle:nameStr forState:UIControlStateNormal];
    [profileName addTarget:objNewsFeedsView action:@selector(profileButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [profileName setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.contentView addSubview:profileName];
    
    UILabel *and_lbl=[[UILabel alloc]initWithFrame:CGRectMake(profileName.frame.origin.x+rect.size.width+6, profileName.frame.origin.y, 50, 22)];
    and_lbl.text=@">>";
    [and_lbl setTextColor:[UIColor blackColor]];
    and_lbl.font=[UIFont fontWithName:@"Ubuntu" size:14];
    [self.contentView addSubview:and_lbl];
    [and_lbl release];
    
      
    UIButton *profileName_2=[UIButton buttonWithType:UIButtonTypeCustom];
    CGSize constraintSize2;
    constraintSize2.height = MAXFLOAT;
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) 
    {        
        constraintSize2.width = 500.0f;
    }
    else
    {        
        constraintSize2.width = 230.0f;
    }
    
    NSString *nameStr2;
    if ( ([newsFeedItem valueForKey:@"FriendName"] == (id)[NSNull null])
        || [newsFeedItem valueForKey:@"FriendName"] == NULL
        || [[newsFeedItem valueForKey:@"FriendName"] isEqualToString:@""] )
    {
        nameStr2 = @" ";
    }
    else
    {        
        nameStr2=[newsFeedItem valueForKey:@"FriendName"];
    }
    
    profileName_2.titleLabel.font=[UIFont fontWithName:@"Ubuntu-Bold" size:18];
    
    CGSize stringSize2 =[nameStr2 sizeWithFont:profileName_2.titleLabel.font  constrainedToSize: constraintSize2 lineBreakMode: UILineBreakModeTailTruncation];
    profileName_2.titleLabel.lineBreakMode=UILineBreakModeTailTruncation;

    CGRect rect2 = CGRectMake(84, 37, stringSize2.width, stringSize2.height);
    profileName_2.frame=rect2;
    profileName_2.tag=index_row;
    [profileName_2 setTitle:nameStr2 forState:UIControlStateNormal];
    [profileName_2 addTarget:objNewsFeedsView action:@selector(FrdProfileButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [profileName_2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.contentView addSubview:profileName_2];
    
    UILabel *time_lbl=[[UILabel alloc]initWithFrame:CGRectMake(84, 61, 150, 25)];
    NSString *time=[NSString stringWithFormat:@"%@",[newsFeedItem valueForKey:@"Time"]];
    time_lbl.text=[self FormatTime:time];
    
    
    [time_lbl setTextColor:[UIColor blackColor]];
    time_lbl.font=[UIFont fontWithName:@"Ubuntu" size:13];
    [self.contentView addSubview:time_lbl];
    [time_lbl release];
    
    
    NSString *DisStr;
    if ( ([newsFeedItem valueForKey:@"Title"] == (id)[NSNull null])
        || [newsFeedItem valueForKey:@"Title"] == NULL
        || [[newsFeedItem valueForKey:@"Title"] isEqualToString:@""] )
    {
        DisStr = @"";
    }
    else
    {        
        DisStr=[newsFeedItem valueForKey:@"Title"];
    }
    
    UITextView *blogPostDis=[[UITextView alloc]init];
    blogPostDis.text=DisStr;
    [blogPostDis setTextColor:[UIColor blackColor]];
    blogPostDis.editable=NO;
    blogPostDis.font=[UIFont fontWithName:@"Ubuntu" size:13];
    [self.contentView addSubview:blogPostDis];
    [blogPostDis release];
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {        
        blogPostDis.frame=CGRectMake(7, 83, 500, 56);
    }
    else
    {        
        blogPostDis.frame=CGRectMake(7, 83, 306, 56);
    }
    
    comment_btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [comment_btn setFrame:CGRectMake(124, 148, 70, 20)];
    [comment_btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    comment_btn.tag=index_row;
    comment_btn.titleLabel.font =[UIFont fontWithName:@"Ubuntu" size:13];
    [comment_btn setTitle:@"Comment" forState:UIControlStateNormal];
    [self.contentView addSubview:comment_btn];
    
    if (!([[newsFeedItem valueForKey:@"userId"] isEqualToString:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID]))
    {        
        like_btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [like_btn setFrame:CGRectMake(252, 148, 50, 20)];
        [like_btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        if ( ([newsFeedItem valueForKey:@"LikeStatusID"] == (id)[NSNull null])
            || [newsFeedItem valueForKey:@"LikeStatusID"] == NULL
            || [[newsFeedItem valueForKey:@"LikeStatusID"] isEqualToString:@"UnLiked"] )
        {
            [like_btn setTitle:@"Like" forState:UIControlStateNormal];
        }
        else
        {            
            [like_btn setTitle:@"Unlike" forState:UIControlStateNormal];
        }
        
        like_btn.tag=index_row;
        like_btn.titleLabel.font =[UIFont fontWithName:@"Ubuntu" size:13];
        [self.contentView addSubview:like_btn];
        
    }
    
    [self.like_btn addTarget:objNewsFeedsView action:@selector(likeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.comment_btn addTarget:objNewsFeedsView action:@selector(commentButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *commentimg_btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [commentimg_btn setFrame:CGRectMake(84, 150, 17, 17)];
    commentimg_btn.tag=index_row;
    [commentimg_btn setImage:[UIImage imageNamed:@"comments.png"] forState:UIControlStateNormal];
    [self.contentView addSubview:commentimg_btn];
    
    NSString *commentcountStr;
    
    if ( ([newsFeedItem valueForKey:@"Comment"] == (id)[NSNull null])
        || [newsFeedItem valueForKey:@"Comment"] == NULL
        || [[newsFeedItem valueForKey:@"Comment"] isEqualToString:@""] )
    {
        commentcountStr = @"";
    }
    else
    {        
        commentcountStr=[newsFeedItem valueForKey:@"Comment"];
    }
    
    UIButton *commentcount_btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [commentcount_btn setFrame:CGRectMake(103, 150, 15, 15)];
    commentcount_btn.tag=index_row;
    [commentcount_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [commentcount_btn setTitle:commentcountStr forState:UIControlStateNormal];
    commentcount_btn.titleLabel.font =[UIFont fontWithName:@"Ubuntu" size:12];
    [self.contentView addSubview:commentcount_btn];
    
    UIButton *likesview_btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [likesview_btn setFrame:CGRectMake(214, 150, 17, 17)];
    likesview_btn.tag=index_row;
    
    [likesview_btn setImage:[UIImage imageNamed:@"likes.png"] forState:UIControlStateNormal];
    [self.contentView addSubview:likesview_btn];
    
    NSString *likecountStr;
    if ( ([newsFeedItem valueForKey:@"likecount"] == (id)[NSNull null])
        || [newsFeedItem valueForKey:@"likecount"] == NULL
        || [[newsFeedItem valueForKey:@"likecount"] isEqualToString:@""] )
    {
        likecountStr = @"";
    }
    else
    {        
        likecountStr=[newsFeedItem valueForKey:@"likecount"];
    }
    
    UIButton *likescount_btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [likescount_btn setFrame:CGRectMake(234, 150, 15, 15)];
    likescount_btn.tag=index_row;
    [likescount_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [likescount_btn setTitle:likecountStr forState:UIControlStateNormal];
    likescount_btn.titleLabel.font =[UIFont fontWithName:@"Ubuntu" size:12];
    [self.contentView addSubview:likescount_btn];
    
    [likesview_btn addTarget:objNewsFeedsView action:@selector(likesCountButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [likescount_btn addTarget:objNewsFeedsView action:@selector(likesCountButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [commentimg_btn addTarget:objNewsFeedsView action:@selector(commentsCountButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [commentcount_btn addTarget:objNewsFeedsView action:@selector(commentsCountButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
}


@end
