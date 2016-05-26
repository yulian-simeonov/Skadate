//
//  blogPostCell.m
//  Skadate
//
//  Created by Heinz Vallonthaiel on 27/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "blogPostCell.h"
#import "CommonStaticMethods.h"

@implementation blogPostCell

@synthesize newsFeedItem;
@synthesize domain;
@synthesize comment_btn;
@synthesize like_btn;
@synthesize index_row;
@synthesize profile_img;

#pragma mark initWithNibName

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {
        // Initialization code
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        domain = [prefs stringForKey:@"URL"];

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
        constraintSize.width = 230.0f;
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
    
    profileName.titleLabel.font=[UIFont fontWithName:@"Ubuntu-Bold" size:20];

    CGSize stringSize =[nameStr sizeWithFont:profileName.titleLabel.font  constrainedToSize: constraintSize lineBreakMode: UILineBreakModeTailTruncation];
    profileName.titleLabel.lineBreakMode=UILineBreakModeTailTruncation;

    CGRect rect = CGRectMake(84, 10, stringSize.width, stringSize.height);
    profileName.frame=rect;
    profileName.tag=index_row;
    [profileName setTitle:nameStr forState:UIControlStateNormal];
    [profileName addTarget:objNewsFeedsView action:@selector(profileButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [profileName setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.contentView addSubview:profileName];

    
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(84, 37, 220, 25)];
    lbl.text=[NSString stringWithFormat:@"added a new blog post"];
    [lbl setTextColor:[UIColor blackColor]];
    lbl.font=[UIFont fontWithName:@"Ubuntu" size:14];
    [self.contentView addSubview:lbl];
    [lbl release];
    
    UILabel *time_lbl=[[UILabel alloc]initWithFrame:CGRectMake(84, 61, 150, 25)];
    NSString *time=[NSString stringWithFormat:@"%@",[newsFeedItem valueForKey:@"Time"]];
    time_lbl.text=[self FormatTime:time];
    
    [time_lbl setTextColor:[UIColor blackColor]];
    time_lbl.font=[UIFont fontWithName:@"Ubuntu" size:13];
    [self.contentView addSubview:time_lbl];
    [time_lbl release];
        
    NSString *titleStr;
    if ( ([newsFeedItem valueForKey:@"Title"] == (id)[NSNull null])
        || [newsFeedItem valueForKey:@"Title"] == NULL
        || [[newsFeedItem valueForKey:@"Title"] isEqualToString:@""] )
    {
        titleStr = @"";
    }
    else
    {        
        titleStr=[newsFeedItem valueForKey:@"Title"];
    }

    UILabel *title_lbl=[[UILabel alloc]init];
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {        
        title_lbl.frame=CGRectMake(14, 83, 500, 25);
    }
    else
    {        
        title_lbl.frame=CGRectMake(14, 83, 230, 25);
    }

    title_lbl.text=titleStr;
    [title_lbl setTextColor:[UIColor blueColor]];
    title_lbl.font=[UIFont fontWithName:@"Ubuntu-Bold" size:13];
    [self.contentView addSubview:title_lbl];
    [title_lbl release];

    NSString *DisStr;
    if ( ([newsFeedItem valueForKey:@"Description"] == (id)[NSNull null])
        || [newsFeedItem valueForKey:@"Description"] == NULL
        || [[newsFeedItem valueForKey:@"Description"] isEqualToString:@""] )
    {
        DisStr = @"";
    }
    else
    {        
        DisStr=[newsFeedItem valueForKey:@"Description"];
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
        blogPostDis.frame=CGRectMake(7, 108, 500, 56);
    }
    else
    {        
        blogPostDis.frame=CGRectMake(7, 108, 306, 56);
    }
    
    comment_btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [comment_btn setFrame:CGRectMake(124, 166, 70, 20)];
    [comment_btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    comment_btn.tag=index_row;
    comment_btn.titleLabel.font =[UIFont fontWithName:@"Ubuntu" size:13];
    [comment_btn setTitle:@"Comment" forState:UIControlStateNormal];
    [self.contentView addSubview:comment_btn];
    
    if (!([[newsFeedItem valueForKey:@"userId"] isEqualToString:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID]))
    {        
        like_btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [like_btn setFrame:CGRectMake(252, 166, 50, 20)];
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
    [commentimg_btn setFrame:CGRectMake(84, 168, 17, 17)];
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
    [commentcount_btn setFrame:CGRectMake(103, 168, 15, 15)];
    commentcount_btn.tag=index_row;
    [commentcount_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [commentcount_btn setTitle:commentcountStr forState:UIControlStateNormal];
    commentcount_btn.titleLabel.font =[UIFont fontWithName:@"Ubuntu" size:12];
    [self.contentView addSubview:commentcount_btn];
    
    UIButton *likesview_btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [likesview_btn setFrame:CGRectMake(214, 168, 17, 17)];
    likesview_btn.tag=index_row;
    [likesview_btn setImage:[UIImage imageNamed:@"likes.png"] forState:UIControlStateNormal];
    [self.contentView addSubview:likesview_btn];
    
    NSString *likecountStr;
    
    if (([newsFeedItem valueForKey:@"likecount"]==(id)[NSNull null])||[newsFeedItem valueForKey:@"likecount"]==NULL)
    {        
        likecountStr=@"";
    }
    else
    {        
        likecountStr=[newsFeedItem valueForKey:@"likecount"];
    }
    
    UIButton *likescount_btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [likescount_btn setFrame:CGRectMake(234, 168, 15, 15)];
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
