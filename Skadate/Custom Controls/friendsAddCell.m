//
//  friendsAddCell.m
//  Skadate
//
//  Created by Heinz Vallonthaiel on 27/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "friendsAddCell.h"
#import "CommonStaticMethods.h"

@implementation friendsAddCell

@synthesize newsFeedItem;
@synthesize domain;
@synthesize comment_friendsAdd_btn;
@synthesize like_friendsAdd_btn;
@synthesize frnd_img1;
@synthesize frnd_img2;
@synthesize profile_img;
@synthesize friend_img;
@synthesize index_row;

#pragma mark initWithNibName

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {
        // Initialization code
        newsFeedItem=[[NSDictionary alloc]init];
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
    if (([newsFeedItem valueForKey:@"username"]==(id)[NSNull null])||[newsFeedItem valueForKey:@"username"]==NULL||[[newsFeedItem valueForKey:@"username"]isEqual:@""])
    {
        nameStr=@" ";
    }
    else
    {        
        nameStr=[newsFeedItem valueForKey:@"username"];
    }
    
    profileName.titleLabel.font=[UIFont fontWithName:@"Ubuntu-Bold" size:18];
    
    CGSize stringSize =[nameStr sizeWithFont:profileName.titleLabel.font  constrainedToSize: constraintSize lineBreakMode: UILineBreakModeTailTruncation];
    profileName.titleLabel.lineBreakMode=UILineBreakModeTailTruncation;

    CGRect rect = CGRectMake(5, 7, stringSize.width, stringSize.height);
    profileName.frame=rect;
    profileName.tag=index_row;
    [profileName setTitle:nameStr forState:UIControlStateNormal];
    [profileName addTarget:objNewsFeedsView action:@selector(profileButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [profileName setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.contentView addSubview:profileName];
    
    UILabel *and_lbl=[[UILabel alloc]initWithFrame:CGRectMake(profileName.frame.origin.x+rect.size.width+6, profileName.frame.origin.y, 50, 22)];
    and_lbl.text=@"and";
    [and_lbl setTextColor:[UIColor blueColor]];
    and_lbl.font=[UIFont fontWithName:@"Ubuntu" size:14];
    [self.contentView addSubview:and_lbl];
    [and_lbl release];

    NSString *FrdName;

    if (([newsFeedItem valueForKey:@"FriendName"]==(id)[NSNull null])||[newsFeedItem valueForKey:@"FriendName"]==NULL)
    {
        FrdName=@" ";
    }
    else
    {        
        FrdName=[newsFeedItem valueForKey:@"FriendName"];

    }
           
    UIButton *friend2_btn=[[UIButton alloc]init];
    
    [friend2_btn setTitle:FrdName forState:UIControlStateNormal];
    friend2_btn.titleLabel.font=[UIFont fontWithName:@"Ubuntu-Bold" size:18];
    CGSize constraintSize_friend2_lbl;
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {        
        constraintSize_friend2_lbl.width = 500.0f;
    }
    else
    {        
        constraintSize_friend2_lbl.width = 230.0f;
    }
    
    constraintSize_friend2_lbl.height = MAXFLOAT;
    [friend2_btn addTarget:objNewsFeedsView action:@selector(FrdProfileButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    CGSize stringSize_friend2_lbl =[FrdName sizeWithFont:friend2_btn.titleLabel.font  constrainedToSize: constraintSize_friend2_lbl lineBreakMode: UILineBreakModeTailTruncation];
    friend2_btn.titleLabel.lineBreakMode=UILineBreakModeTailTruncation;

    CGRect rect_friend2_lbl = CGRectMake(85, 32, stringSize_friend2_lbl.width, stringSize_friend2_lbl.height);
    [self.contentView addSubview:friend2_btn];
    friend2_btn.frame=rect_friend2_lbl;
    friend2_btn.tag=index_row;
    [friend2_btn setTitle:FrdName forState:UIControlStateNormal];
    [friend2_btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [friend2_btn release];
    
    UILabel *arenowFrds_lbl=[[UILabel alloc]initWithFrame:CGRectMake(160, 125, 120, 22)];
    arenowFrds_lbl.text=@"are now friends";
    [arenowFrds_lbl setTextColor:[UIColor blueColor]];
    arenowFrds_lbl.font=[UIFont fontWithName:@"Ubuntu" size:14];
    [self.contentView addSubview:arenowFrds_lbl];
    [arenowFrds_lbl release];

    UILabel *time_lbl=[[UILabel alloc]initWithFrame:CGRectMake(7, 125, 150, 25)];
    NSString *time=[NSString stringWithFormat:@"%@",[newsFeedItem valueForKey:@"Time"]];
    time_lbl.text=[self FormatTime:time];
    
    [time_lbl setTextColor:[UIColor blackColor]];
    time_lbl.font=[UIFont fontWithName:@"Ubuntu" size:13];
    [self.contentView addSubview:time_lbl];
    [time_lbl release];
       
    UIButton *imgview_btn=[[[UIButton alloc]initWithFrame:CGRectMake(7, 32, 70, 70)] autorelease];
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
    
    UIButton *imgview_btn2=[[[UIButton alloc]initWithFrame:CGRectMake(85, 57, 70, 70)] autorelease];
    imgview_btn2.tag=index_row;
    imgview_btn2.layer.cornerRadius=6.0;
    imgview_btn2.layer.masksToBounds=YES;
    [imgview_btn2 setImage:friend_img forState:UIControlStateNormal];
    [self.contentView addSubview:imgview_btn2];
    [imgview_btn2 addTarget:objNewsFeedsView action:@selector(FrdProfileButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    NSString *generVal1=(NSString*)[newsFeedItem valueForKey:@"FriendSex"];
    
    // Lazy image loading         
    NSString *profilePicURL1=[NSString stringWithFormat:@"%@%@",domain,[newsFeedItem valueForKey:@"Friend_Pic"]];
    
    NSString *imageName1=[NSString stringWithFormat:@"%@",[newsFeedItem valueForKey:@"Friend_Pic"]];
    //imageName1=[imageName1 stringByReplacingOccurrencesOfString:@"/$userfiles/" withString:@""];  // for old version
    imageName1=[imageName1 stringByReplacingOccurrencesOfString:@"/userfiles/" withString:@""];  // for new version
    NSString *originalPath1 =[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]  stringByAppendingPathComponent:@"Images"];
    
    NSString *localFilePath1 = [originalPath1 stringByAppendingPathComponent:imageName1];
    
    BOOL isDir1=[CommonStaticMethods directoryExistsAtAbsolutePath:[originalPath1 stringByAppendingPathComponent:@"profile.png"]];
    if(!isDir1)
    {        
        [[NSFileManager defaultManager]createDirectoryAtPath: originalPath1 withIntermediateDirectories: YES attributes: nil error: NULL];
    }
    
    
    dispatch_async(queue, ^{
        BOOL fileExists1 = [[NSFileManager defaultManager] fileExistsAtPath:localFilePath1];
        if (!fileExists1)
        {
            
            NSURL *imageURL = [[[NSURL alloc] initWithString:profilePicURL1]autorelease];            
            NSURLRequest *request = [NSURLRequest requestWithURL:imageURL];
            [NSURLConnection connectionWithRequest:request delegate:self];
            NSData *thedata = [NSData dataWithContentsOfURL:imageURL];
            [thedata writeToFile:localFilePath1 atomically:YES];
        }
        UIImage* image = [UIImage imageWithContentsOfFile:localFilePath1];
        dispatch_sync(dispatch_get_main_queue(), ^{
            if(image)
            {
                friend_img=image;
            }
            else
            {
                if ((generVal1 == (id)[NSNull null])||([generVal1 length] == 0)||(generVal1==NULL)) 
                {                                                      
                    friend_img=[UIImage imageNamed:@"man.png"];
                }
                else
                {                    
                    if ([generVal1 intValue]==1) 
                    {
                        friend_img=[UIImage imageNamed:@"women.png"];
                    }
                    else if ([generVal1 intValue]==2) 
                    {
                        friend_img=[UIImage imageNamed:@"man.png"];
                    }
                    else if ([generVal1 intValue]==4) 
                    {
                        friend_img=[UIImage imageNamed:@"man_women.png"];
                    }
                    else if ([generVal1 intValue]==8) 
                    {
                        friend_img=[UIImage imageNamed:@"man_women_a.png"];
                    }
                    else 
                    {
                        friend_img=[UIImage imageNamed:@"man.png"];
                        
                    } 
                }
            }
            [imgview_btn2 setImage:friend_img forState:UIControlStateNormal];
        });
    });  
    
    dispatch_release(queue);
    
     
    comment_friendsAdd_btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [comment_friendsAdd_btn setFrame:CGRectMake(124, 151, 70, 20)];
    comment_friendsAdd_btn.tag=index_row;
    [comment_friendsAdd_btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    comment_friendsAdd_btn.titleLabel.font = [UIFont fontWithName:@"Ubuntu" size:13];
    [comment_friendsAdd_btn setTitle:@"Comment" forState:UIControlStateNormal];
    [self.contentView addSubview:comment_friendsAdd_btn];
    
    if (!([[newsFeedItem valueForKey:@"userId"] isEqualToString:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID])) 
    {        
        like_friendsAdd_btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [like_friendsAdd_btn setFrame:CGRectMake(252, 151, 50, 20)];
        
        [like_friendsAdd_btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        if (([newsFeedItem valueForKey:@"LikeStatusID"]==(id)[NSNull null])||[newsFeedItem valueForKey:@"LikeStatusID"]==NULL||[[newsFeedItem valueForKey:@"LikeStatusID"]isEqual:@"UnLiked"])
        {            
            [like_friendsAdd_btn setTitle:@"Like" forState:UIControlStateNormal];
        }
        else
        {            
            [like_friendsAdd_btn setTitle:@"Unlike" forState:UIControlStateNormal];
        }
        like_friendsAdd_btn.tag=index_row;
        like_friendsAdd_btn.titleLabel.font =[UIFont fontWithName:@"Ubuntu" size:13];
        [self.contentView addSubview:like_friendsAdd_btn];
        
    }

     
    [self.like_friendsAdd_btn addTarget:objNewsFeedsView action:@selector(likeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.comment_friendsAdd_btn addTarget:objNewsFeedsView action:@selector(commentButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *commentimg_btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [commentimg_btn setFrame:CGRectMake(84, 153, 17, 17)];
    commentimg_btn.tag=index_row;
    [commentimg_btn setImage:[UIImage imageNamed:@"comments.png"] forState:UIControlStateNormal];
    [self.contentView addSubview:commentimg_btn];
    
    NSString *commentcountStr;
    if (([newsFeedItem valueForKey:@"Comment"]==(id)[NSNull null])||[newsFeedItem valueForKey:@"Comment"]==NULL)
    {        
        commentcountStr=@"";
        
    }
    else
    {        
        commentcountStr=[newsFeedItem valueForKey:@"Comment"];
    }
    
    UIButton *commentcount_btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [commentcount_btn setFrame:CGRectMake(103, 153, 15, 15)];
    commentcount_btn.tag=index_row;
    [commentcount_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [commentcount_btn setTitle:commentcountStr forState:UIControlStateNormal];
    commentcount_btn.titleLabel.font =[UIFont fontWithName:@"Ubuntu" size:12];
    [self.contentView addSubview:commentcount_btn];
    
    UIButton *likesview_btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [likesview_btn setFrame:CGRectMake(214, 153, 17, 17)];
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
    [likescount_btn setFrame:CGRectMake(234, 153, 15, 15)];
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
