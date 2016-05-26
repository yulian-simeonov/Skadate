//
//  NewsFeedsController.m
//  Skadate
//
//  Created by SOD MAC4 on 24/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NewsFeedsController.h"
#import "SkadateAppDelegate.h"
#import "JSON.h"
#import "blogPostCell.h"
#import "newsPostAddCell.h"
#import "friendsAddCell.h"
#import "profileAvatarChangeCell.h"
#import "profileEdit.h"
#import "profileJoinCell.h"
#import "profileCommentCell.h"
#import "userComment.h"
#import "postClassifiedsItemCell.h"
#import "eventAttendCell.h"
#import "eventAddCell.h"
#import "groupAddCell.h"
#import "groupJoinCell.h"
#import "photoUpload.h"
#import "mediaUploadCell.h"
#import "musicUploadCell.h"
#import "forumAddTopicCell.h"
#import "statusUpdateCell.h"
#import "DetailedCommentViewController.h"
#import "LikeListViewController.h"
#import "UploadedPhotoFullView.h"
#import "photoUploadDeleted.h"
#import "MyProfileView.h"

#define REFRESH_HEADER_HEIGHT 52.0f

@implementation NewsFeedsController

@synthesize newsFeedTV;
@synthesize domain;
@synthesize newsFeedsItemArray;
@synthesize ProfilePicURLs;
@synthesize ProfilePicImages;
@synthesize Friend_Pics;
@synthesize Friend_PicUrls;
@synthesize imgUpload_PicsUrls;
@synthesize imgUpload_Pics;
@synthesize navBar;
@synthesize navLable;
@synthesize selectedLike;
@synthesize fromCommentView;
@synthesize youLiked;
@synthesize smallIndicatorView;
@synthesize NewXval;
// pull down refresh.........//
@synthesize textPull, textRelease, textLoading, refreshHeaderView, refreshLabel, refreshArrow, refreshSpinner;

#pragma mark initWithNibName 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        // Custom initialization
    }
    return self;
}

#pragma mark Memory Management

- (void)dealloc
{    
    [ProfilePicURLs release];
    [ProfilePicImages release];
    [Friend_Pics release];
    [Friend_PicUrls release];
    [imgUpload_PicsUrls release];
    [imgUpload_Pics release];
    [newsFeedsItemArray release];
    [super dealloc];
    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

//-(NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskAll;
//}

-(BOOL)shouldAutorotate
{
    return NO;
}

/*-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
       
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        [self ios6ipad];
    }
    
}*/

- (void)addItem
{        
    newsFeedsItemArray=[[NSMutableArray alloc]init];
    
    ProfilePicURLs=[[NSMutableArray alloc]init];
    ProfilePicImages=[[NSMutableArray alloc]init];
    
    Friend_PicUrls=[[NSMutableArray alloc]init];
    Friend_Pics=[[NSMutableArray alloc]init];
    
    Friend_PicUrls=[[NSMutableArray alloc]init];
    Friend_Pics=[[NSMutableArray alloc]init];
    
    imgUpload_PicsUrls=[[NSMutableArray alloc]init];
    imgUpload_Pics=[[NSMutableArray alloc]init];
    
    NSString *req = [NSString stringWithFormat:@"%@/mobile/News_Feed_View/?pid=%@&skey=%@",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID];

    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:req, @"url", @"newsFeedUrlconnection", @"meta", nil];
    [self performSelectorOnMainThread:@selector(WebRequest:) withObject:params waitUntilDone:NO];
    self.view.userInteractionEnabled=NO;
    
}

-(void)likeButtonClicked:(id)sender
{
    
    if (likesConnected) 
    {
        return;
    }
    
    likesConnected=YES;
    smallIndicatorView.hidden=NO;
    [smallIndicatorView startAnimating];
    
    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fromlikesView_liked=NO;
    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fromlikesView_Unliked=NO;
    
    selectedLike=[sender tag];
    
    NSString *entityId=(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:[sender tag]] valueForKey:@"id"];
    NSString *likeStr = [[(UIButton*)sender titleLabel] text];
    
    if ([likeStr isEqualToString:@"Like"])
    {
        NSString *req = [NSString stringWithFormat:@"%@/mobile/News_Like/?pid=%@&skey=%@&eid=%@",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID,entityId];
        NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:req, @"url", @"likeUrlconnection", @"meta", nil];
        [JSWaiter ShowWaiter:self title:@"Contacting Server..." type:0];
        [self performSelectorOnMainThread:@selector(WebRequest:) withObject:params waitUntilDone:NO];
        self.view.userInteractionEnabled=NO;
        
    }
    else if([likeStr isEqualToString:@"Unlike"])
    {        
        NSString *req = [NSString stringWithFormat:@"%@/mobile/News_UnLike/?pid=%@&skey=%@&eid=%@",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID,entityId];
        NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:req, @"url", @"UnlikeUrlconnection", @"meta", nil];
        [JSWaiter ShowWaiter:self title:@"Please Wait..." type:0];
        [self performSelectorOnMainThread:@selector(WebRequest:) withObject:params waitUntilDone:NO];
        self.view.userInteractionEnabled=NO;
    }    
}

-(void)commentButtonClicked:(id)sender
{    
    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fromCommentView=NO;
    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fromlikesView_liked=NO;
    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fromlikesView_Unliked=NO;
    
    selectedLike=[sender tag];
    NSString *entityId=(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:[sender tag]] valueForKey:@"id"];
    NewsFeedCommentViewController *objcommentView=[[NewsFeedCommentViewController alloc]initWithNibName:@"NewsFeedCommentViewController" bundle:nil];
    objcommentView.entityId=entityId;
    [self.navigationController presentModalViewController:objcommentView animated:YES];
    [objcommentView release];
    
}

-(void)commentsCountButtonClicked:(id)sender
{
    selectedLike=[sender tag];
    
    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fromCommentView=NO;
    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fromlikesView_liked=NO;
    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fromlikesView_Unliked=NO;
    
    NSString *CommentCountStr=(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:selectedLike] valueForKey:@"Comment"];
    int CommentCount=[CommentCountStr intValue];
    
    if (CommentCount>0)
    {               
        NSString *entityId=(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:[sender tag]] valueForKey:@"id"];
        
        DetailedCommentViewController *objDetailedCommentViewController=[[DetailedCommentViewController alloc]initWithNibName:@"DetailedCommentViewController" bundle:nil];
        objDetailedCommentViewController.entityId=entityId;
        [self.navigationController pushViewController:objDetailedCommentViewController animated:YES];
        [objDetailedCommentViewController release];
                
    }
    
}

-(void)likesCountButtonClicked:(id)sender
{    
    
    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fromlikesView_liked=NO;
    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fromlikesView_Unliked=NO;
    selectedLike=[sender tag];
    
    if (((NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:[sender tag]] valueForKey:@"LikeStatusID"]==(id)[NSNull null])||(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:[sender tag]] valueForKey:@"LikeStatusID"]==NULL||[(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:[sender tag]] valueForKey:@"LikeStatusID"] isEqualToString:@"UnLiked"])
    {
        youLiked=NO;  
    }
    else
    {        
        youLiked=YES;        
    }
    
    NSString *entityType=(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:selectedLike] valueForKey:@"likecount"];
    int likecount=[entityType intValue];
    
    if (likecount>0) 
    {        
        NSString *entityId=(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:[sender tag]] valueForKey:@"id"];
        
        LikeListViewController *objLikeListViewController=[[LikeListViewController alloc]initWithNibName:@"LikeListViewController" bundle:nil];
        objLikeListViewController.entityId=entityId;
        objLikeListViewController.youLiked=youLiked;
        
        if (([(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:[sender tag]] valueForKey:@"userId"] isEqualToString:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID]))
        {                        
            objLikeListViewController.myFeed=YES;
        }
        else
        {            
            objLikeListViewController.myFeed=NO;
        }
        
        [self.navigationController pushViewController:objLikeListViewController animated:YES];
        
        [objLikeListViewController release];
        
    }
    
}

-(void)profileButtonClicked:(id)sender
{        
    selectedLike=[sender tag];
    
    NSString *profileId=(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:[sender tag]] valueForKey:@"userId"];
    
    if([((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID isEqualToString:profileId])
    {
        MyProfileView *objMyProfileView=[[MyProfileView alloc]initWithNibName:@"MyProfileView" bundle:nil];
        objMyProfileView.profileID=profileId;
        [self.navigationController pushViewController:objMyProfileView animated:YES];
        [objMyProfileView release];
    }
    else
    {
        ProfileView *objProfileView=[[ProfileView alloc]initWithNibName:@"ProfileView" bundle:nil];
        objProfileView.profileID=profileId;
        [self.navigationController pushViewController:objProfileView animated:YES];
        [objProfileView release];
        
    }
}


-(void)FrdProfileButtonClicked:(id)sender
{    
    selectedLike=[sender tag];
    
    NSString *profileId=(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:[sender tag]] valueForKey:@"FriendID"];
    
    if([((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID isEqualToString:profileId])
    {
        
    }
    else
    {
        ProfileView *objProfileView=[[ProfileView alloc]initWithNibName:@"ProfileView" bundle:nil];
        objProfileView.profileID=profileId;
        
        [self.navigationController pushViewController:objProfileView animated:YES];
        [objProfileView release];
    }
    
}

-(void)uploadedImageButtonClicked:(id)sender
{    
    selectedLike=[sender tag];
    
    if ( ([imgUpload_PicsUrls objectAtIndex:selectedLike] == (id)[NSNull null])
        || ([imgUpload_PicsUrls objectAtIndex:selectedLike] == NULL)
        || ([[imgUpload_PicsUrls objectAtIndex:selectedLike] isEqual:@""])
        || ([[imgUpload_PicsUrls objectAtIndex:selectedLike] length] == 0) )
    {
        
        return;
    }
    else
    {
        UploadedPhotoFullView *objUploadedPhotoFullView=[[UploadedPhotoFullView alloc]initWithNibName:@"UploadedPhotoFullView" bundle:nil];
        objUploadedPhotoFullView.strImageUpload=[imgUpload_PicsUrls objectAtIndex:selectedLike];
        [self.navigationController pushViewController:objUploadedPhotoFullView animated:YES];
        [objUploadedPhotoFullView release];
    }
}

#pragma mark Pull to refresh Related Methods & Delegates

- (void)startLoading 
{
    isLoading = YES;
    
    // Show the header
    [UIView animateWithDuration:0.3 animations:^{
        newsFeedTV.contentInset = UIEdgeInsetsMake(REFRESH_HEADER_HEIGHT, 0, 0, 0);
        refreshLabel.text = self.textLoading;
        refreshArrow.hidden = YES;
        [refreshSpinner startAnimating];
    }];
    
    // Refresh action!
    [self refresh];
}

- (void)stopLoading 
{
    isLoading = NO;
    self.view.userInteractionEnabled=YES;
    // Hide the header
    [UIView animateWithDuration:0.3 animations:^{
        newsFeedTV.contentInset = UIEdgeInsetsZero;
        [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
    } 
                     completion:^(BOOL finished) {
                         [self performSelector:@selector(stopLoadingComplete)];
                     }];
}

- (void)stopLoadingComplete 
{
    // Reset the header
    refreshLabel.text = self.textPull;
    refreshArrow.hidden = NO;
    [refreshSpinner stopAnimating];
    
}


- (void)refresh 
{
    self.view.userInteractionEnabled=NO;
    [self performSelector:@selector(addItem) withObject:nil afterDelay:2.0];
}


- (void)setupStrings
{
    textPull = [[NSString alloc] initWithString:@"Pull down to refresh..."];
    textRelease = [[NSString alloc] initWithString:@"Release to refresh..."];
    textLoading = [[NSString alloc] initWithString:@"Loading..."];
}

- (void)addPullToRefreshHeader 
{
    refreshHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 - REFRESH_HEADER_HEIGHT, 320, REFRESH_HEADER_HEIGHT)];
    refreshHeaderView.backgroundColor = [UIColor clearColor];
    
    refreshLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, REFRESH_HEADER_HEIGHT)];
    refreshLabel.backgroundColor = [UIColor clearColor];
    refreshLabel.font = [UIFont boldSystemFontOfSize:12.0];
    refreshLabel.textAlignment = UITextAlignmentCenter;
    
    refreshArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.png"]];
    refreshArrow.frame = CGRectMake(floorf((REFRESH_HEADER_HEIGHT - 27) / 2),
                                    (floorf(REFRESH_HEADER_HEIGHT - 44) / 2),
                                    27, 44);
    
    refreshSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            
    int xvalue=floorf(floorf(REFRESH_HEADER_HEIGHT - 20) / 2) +85;
    
    refreshSpinner.frame = CGRectMake(xvalue, floorf((REFRESH_HEADER_HEIGHT - 20) / 2), 20, 20);
    
    refreshSpinner.hidesWhenStopped = YES;
    
    [refreshHeaderView addSubview:refreshLabel];
    [refreshHeaderView addSubview:refreshArrow];
    [refreshHeaderView addSubview:refreshSpinner];
    [newsFeedTV addSubview:refreshHeaderView];
    
}

#pragma mark ScrollView Delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView 
{
    if (isLoading) return;
    isDragging = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (isLoading) 
    {
        // Update the content inset, good for section headers
        if (scrollView.contentOffset.y > 0)
            newsFeedTV.contentInset = UIEdgeInsetsZero;
        else if (scrollView.contentOffset.y >= -REFRESH_HEADER_HEIGHT)
            newsFeedTV.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } 
    else if (isDragging && scrollView.contentOffset.y < 0) 
    {
        // Update the arrow direction and label
        [UIView animateWithDuration:0.25 animations:^{
            if (scrollView.contentOffset.y < -REFRESH_HEADER_HEIGHT) 
            {
                // User is scrolling above the header
                refreshLabel.text = self.textRelease;
                [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
            } 
            else 
            { 
                // User is scrolling somewhere within the header
                refreshLabel.text = self.textPull;
                [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
            }
        }];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate 
{
    if (isLoading) return;
    isDragging = NO;
    if (scrollView.contentOffset.y <= -REFRESH_HEADER_HEIGHT)
    {
        // Released above the header
        [self startLoading];
    }
}


#pragma mark View lifecycle

- (void)viewDidAppear:(BOOL)animated
{
    
    [smallIndicatorView stopAnimating];
    smallIndicatorView.hidden=YES;
    
    if (((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fromCommentView) 
    {
        
        NSString *CommentCountStr=(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:selectedLike] valueForKey:@"Comment"];
     
        int CommentCount=[CommentCountStr intValue]+1;
        
        NSString *cmtcountStr=[NSString stringWithFormat:@"%d",CommentCount];
        
        [(NSMutableDictionary*)[newsFeedsItemArray objectAtIndex:selectedLike] setObject:cmtcountStr forKey:@"Comment"];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:selectedLike inSection:0];
        [newsFeedTV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
        
    }
    else if(((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fromlikesView_liked)
    {        
        
        NSString *entityType=(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:selectedLike] valueForKey:@"likecount"];
        int likecount=[entityType intValue]+1;
        NSString *likecountStr=[NSString stringWithFormat:@"%d",likecount];
        
        [(NSMutableDictionary*)[newsFeedsItemArray objectAtIndex:selectedLike] setObject:likecountStr forKey:@"likecount"];
        [(NSMutableDictionary*)[newsFeedsItemArray objectAtIndex:selectedLike] setObject:@"Liked" forKey:@"LikeStatusID"];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:selectedLike inSection:0];
        
        [newsFeedTV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
        
    }
    else if(((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fromlikesView_Unliked)
    {    
        
        NSString *entityType=(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:selectedLike] valueForKey:@"likecount"];
        int likecount=[entityType intValue]-1;
        NSString *likecountStr=[NSString stringWithFormat:@"%d",likecount];
        
        [(NSMutableDictionary*)[newsFeedsItemArray objectAtIndex:selectedLike] setObject:likecountStr forKey:@"likecount"];
        [(NSMutableDictionary*)[newsFeedsItemArray objectAtIndex:selectedLike] setObject:@"UnLiked" forKey:@"LikeStatusID"];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:selectedLike inSection:0];
        
        [newsFeedTV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
        
    }
 
}


- (void)viewDidLoad
{
    //// pull to refresh
    
    [self setupStrings];
    [super viewDidLoad];
    
    [self addPullToRefreshHeader];
        
    [self.view setBackgroundColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redVal/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenVal/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueVal/255.0 alpha:1.0]];
    
    [navBar setTintColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavbar/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavbar/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavbar/255.0 alpha:1.0]];
    navBar.layer.borderColor=[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavBorder/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavBorder/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavBorder/255.0 alpha:1.0].CGColor;
    navBar.layer.borderWidth=1.0f;
    navLable.font= ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontNavTitle;
    
    [navLable setTextAlignment:UITextAlignmentCenter];
    navLable.text=@"News Feed";
    likesConnected=NO;
    
    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fromCommentView=NO;
    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fromlikesView_liked=NO;
    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fromlikesView_Unliked=NO;

    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    domain = [prefs stringForKey:@"URL"];
       
    newsFeedsItemArray=[[NSMutableArray alloc]init];
    
    ProfilePicURLs=[[NSMutableArray alloc]init];
    ProfilePicImages=[[NSMutableArray alloc]init];
    
    Friend_PicUrls=[[NSMutableArray alloc]init];
    Friend_Pics=[[NSMutableArray alloc]init];

    Friend_PicUrls=[[NSMutableArray alloc]init];
    Friend_Pics=[[NSMutableArray alloc]init];

    imgUpload_PicsUrls=[[NSMutableArray alloc]init];
    imgUpload_Pics=[[NSMutableArray alloc]init];
      
    NSString *req = [NSString stringWithFormat:@"%@/mobile/News_Feed_View/?pid=%@&skey=%@",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID];
    
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:req, @"url", @"newsFeedUrlconnection", @"meta", nil];
    [JSWaiter ShowWaiter:self title:@"Loading..." type:0];
    [self performSelectorOnMainThread:@selector(WebRequest:) withObject:params waitUntilDone:NO];
    
    self.view.userInteractionEnabled=NO;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
    
    /*if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {       
        
        if (interfaceOrientation==UIInterfaceOrientationLandscapeRight||interfaceOrientation==UIInterfaceOrientationLandscapeLeft) 
        {            
            indicatorView.frame =CGRectMake((412+NewXval), 344, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30), 40);
        }
        else
        {                       
            indicatorView.frame =CGRectMake((284+NewXval), 471, (objIndicatorView.frame.size.width+indicatorLabel.frame.size.width+30), 40);
        }
        return YES;
        
    }
    else
    {       
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    }*/
}

- (void)viewDidUnload
{    
    
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark Table View Delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    
    return [newsFeedsItemArray count];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    NSString *entityType=(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row] valueForKey:@"entityType"];
    
    NSString *PhotoStatus=(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row] valueForKey:@"ActionImage"];
       
    return [self heightForNewsFeedCell:entityType andPhotoUploadStatus:PhotoStatus];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
        
    static NSString *CellIdentifier = @"Cells";
        
    UITableViewCell *objCustTabViewCell=nil;
    objCustTabViewCell=[tableView dequeueReusableCellWithIdentifier:@"cells"];
    
    if([newsFeedsItemArray count]==0)
    {
        return objCustTabViewCell;
    }
    
    NSString *entityType=(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row] valueForKey:@"entityType"];
        
    if ([entityType isEqualToString:@"blog_post_add"]) 
    {       
        blogPostCell *cell=nil;
        cell=(blogPostCell*)[tableView dequeueReusableCellWithIdentifier:@"cells"];
        
        if (cell == nil) 
        {            
            cell = [[[blogPostCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ; 
        }
        
        cell.newsFeedItem=(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row];
        cell.profile_img=[UIImage imageNamed:@"ImageLoading.png"];
        cell.index_row=indexPath.row;
                
        return cell;

    }
    else if ([entityType isEqualToString:@"news_post_add"]) 
    {                
        newsPostAddCell *cell=nil;
        cell=(newsPostAddCell*)[tableView dequeueReusableCellWithIdentifier:@"cells"];
        
        if (cell == nil) 
        {            
            cell = [[[newsPostAddCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ; 
        }

        return cell;

    }
    else if ([entityType isEqualToString:@"friend_add"])
    {        
        friendsAddCell *cell=nil;
        cell=(friendsAddCell*)[tableView dequeueReusableCellWithIdentifier:@"cells"];
        
        if (cell == nil)
        {            
            cell = [[[friendsAddCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ; 
        }
                
        cell.friend_img=[UIImage imageNamed:@"ImageLoading.png"];
        cell.newsFeedItem=(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row];
        cell.index_row=indexPath.row;
        cell.profile_img=[UIImage imageNamed:@"ImageLoading.png"];

        return cell;

    }
    else if ([entityType isEqualToString:@"profile_avatar_change"]) 
    {        
        profileAvatarChangeCell *cell=nil;
        cell=(profileAvatarChangeCell*)[tableView dequeueReusableCellWithIdentifier:@"cells"];
        
        if (cell == nil)
        {            
            cell = [[[profileAvatarChangeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ; 

        }
        
        cell.index_row=indexPath.row;
        cell.newsFeedItem=(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row];
        cell.profile_img=[UIImage imageNamed:@"ImageLoading.png"];

        return cell;

    }
    else if ([entityType isEqualToString:@"profile_edit"])
    {        
        profileEdit *cell=nil;
        cell=(profileEdit*)[tableView dequeueReusableCellWithIdentifier:@"cells"];
        
        if (cell == nil) 
        {            
            cell = [[[profileEdit alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ; 

        }
        cell.index_row=indexPath.row;
        cell.newsFeedItem=(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row];
        cell.profile_img=[UIImage imageNamed:@"ImageLoading.png"];
        
        return cell;
        
    }
    else if ([entityType isEqualToString:@"profile_join"]) 
    {        
        profileJoinCell *cell=nil;
        cell=(profileJoinCell*)[tableView dequeueReusableCellWithIdentifier:@"cells"];
        
        if (cell == nil) 
        {            
            cell = [[[profileJoinCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ; 

        }
        
        cell.index_row=indexPath.row;
        cell.newsFeedItem=(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row];
        cell.profile_img=[UIImage imageNamed:@"ImageLoading.png"];
             
        return cell;
        
    }
    else if ([entityType isEqualToString:@"profile_comment"]) 
    {        
        profileCommentCell *cell=nil;
        cell=(profileCommentCell*)[tableView dequeueReusableCellWithIdentifier:@"cells"];
        
        if (cell == nil)
        {            
            cell = [[[profileCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ; 

        }
        
        cell.newsFeedItem=(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row];
        cell.profile_img=[UIImage imageNamed:@"ImageLoading.png"];
        cell.index_row=indexPath.row;
        
        return cell;

    }
    else if ([entityType isEqualToString:@"user_comment"]) 
    {        
        userComment *cell=nil;
        cell=(userComment*)[tableView dequeueReusableCellWithIdentifier:@"cells"];
        
        if (cell == nil) 
        {            
            cell = [[[userComment alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ; 

        }
        
        cell.newsFeedItem=(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row];
        cell.index_row=indexPath.row;
        cell.profile_img=[UIImage imageNamed:@"ImageLoading.png"];

        return cell;
        
    }
    else if ([entityType isEqualToString:@"post_classifieds_item"]) 
    {        
        postClassifiedsItemCell *cell=nil;
        cell=(postClassifiedsItemCell*)[tableView dequeueReusableCellWithIdentifier:@"cells"];
        
        if (cell == nil) 
        {            
            cell = [[[postClassifiedsItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ; 
        }

        return cell;

    }
    else if ([entityType isEqualToString:@"event_attend"])
    {               
        eventAttendCell *cell=nil;
        cell=(eventAttendCell*)[tableView dequeueReusableCellWithIdentifier:@"cells"];
        
        if (cell == nil)
        {            
            cell = [[[eventAttendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ; 

        }
        
        cell.newsFeedItem=(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row];
        cell.profile_img=[UIImage imageNamed:@"ImageLoading.png"];
        cell.event_img=[UIImage imageNamed:@"ImageLoading.png"];
        cell.index_row=indexPath.row;
           
        return cell;

    }
    else if ([entityType isEqualToString:@"event_add"]) 
    {        
        eventAddCell *cell=nil;
        cell=(eventAddCell*)[tableView dequeueReusableCellWithIdentifier:@"cells"];
        
        if (cell == nil)
        {            
            cell = [[[eventAddCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ; 

        }
        
        cell.newsFeedItem=(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row];
        cell.profile_img=[UIImage imageNamed:@"ImageLoading.png"];
        cell.event_img=[UIImage imageNamed:@"ImageLoading.png"];
        cell.index_row=indexPath.row;
         
        return cell;
        
    }
    else if ([entityType isEqualToString:@"group_add"])
    {        
        groupAddCell *cell=nil;
        cell=(groupAddCell*)[tableView dequeueReusableCellWithIdentifier:@"cells"];
        
        if (cell == nil) 
        {            
            cell = [[[groupAddCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ; 

        }

        cell.index_row=indexPath.row;
        cell.newsFeedItem=(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row];
        cell.profile_img=[UIImage imageNamed:@"ImageLoading.png"];
        cell.group_img=[UIImage imageNamed:@"ImageLoading.png"];
    
        return cell;

    }
    else if ([entityType isEqualToString:@"group_join"])
    {        
        groupJoinCell *cell=nil;
        cell=(groupJoinCell*)[tableView dequeueReusableCellWithIdentifier:@"cells"];
        
        if (cell == nil) 
        {            
            cell = [[[groupJoinCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ; 

        }

        cell.index_row=indexPath.row;
        cell.newsFeedItem=(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row];
        cell.profile_img=[UIImage imageNamed:@"ImageLoading.png"];
        cell.group_img=[UIImage imageNamed:@"ImageLoading.png"];
        
        return cell;
        
    }
    else if ([entityType isEqualToString:@"photo_upload"]) 
    {
        
        NSString *PhotoStatus=(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row] valueForKey:@"ActionImage"];
        
        if ([PhotoStatus isEqualToString:@"(null)"]||[PhotoStatus isEqualToString:@""]||(PhotoStatus == (id)[NSNull null])||([PhotoStatus length] == 0)||(PhotoStatus==NULL))
        {
            PhotoStatus=@"";
        }
        
        if([PhotoStatus isEqualToString:@"Deleted Photo"])
        {
            photoUploadDeleted *cell=nil;
            cell=(photoUploadDeleted*)[tableView dequeueReusableCellWithIdentifier:@"cells"];
            
            if (cell == nil) 
            {                
                cell = [[[photoUploadDeleted alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone ; 
                
            }
            
            cell.index_row=indexPath.row;
            cell.newsFeedItem=(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row];
            cell.profile_img=[UIImage imageNamed:@"ImageLoading.png"];
                        
            return cell;

        }
        else
        {
            photoUpload *cell=nil;
            cell=(photoUpload*)[tableView dequeueReusableCellWithIdentifier:@"cells"];
            
            if (cell == nil) 
            {                
                cell = [[[photoUpload alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone ; 
                
            }
            
            cell.index_row=indexPath.row;
            cell.newsFeedItem=(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row];
           
            cell.uploadedImg=[UIImage imageNamed:@"ImageLoading.png"];
            cell.profile_img=[UIImage imageNamed:@"ImageLoading.png"];
            
            
            return cell;

        }
                        
    }
    else if ([entityType isEqualToString:@"media_upload"]) 
    {
        
        mediaUploadCell *cell=nil;
        cell=(mediaUploadCell*)[tableView dequeueReusableCellWithIdentifier:@"cells"];
        
        if (cell == nil) 
        {            
            cell = [[[mediaUploadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ; 

        }
        
        cell.index_row=indexPath.row;
        cell.newsFeedItem=(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row];
        cell.profile_img=[UIImage imageNamed:@"ImageLoading.png"];

        return cell;

    }
    else if ([entityType isEqualToString:@"music_upload"]) 
    {        
        musicUploadCell *cell=nil;
        
        cell=(musicUploadCell*)[tableView dequeueReusableCellWithIdentifier:@"cells"];
        
        if (cell == nil) 
        {            
            cell = [[[musicUploadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ; 

        }
        
        cell.newsFeedItem=(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row];
        cell.index_row=indexPath.row;
        cell.profile_img=[UIImage imageNamed:@"ImageLoading.png"];

        return cell;

    }
    else if ([entityType isEqualToString:@"forum_add_topic"]) 
    {        
        forumAddTopicCell *cell=nil;
        cell=(forumAddTopicCell*)[tableView dequeueReusableCellWithIdentifier:@"cells"];
        
        if (cell == nil) 
        {            
            cell = [[[forumAddTopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ; 

        }
        
        cell.index_row=indexPath.row;
        cell.newsFeedItem=(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row];
        cell.profile_img=[UIImage imageNamed:@"ImageLoading.png"];
        cell.group_img=[imgUpload_Pics objectAtIndex:indexPath.row];
                      
        return cell;

    }
    else if ([entityType isEqualToString:@"status_update"])
    {        
        statusUpdateCell *cell=nil;
        cell=(statusUpdateCell*)[tableView dequeueReusableCellWithIdentifier:@"cells"];
        
        if (cell == nil) 
        {            
            cell = [[[statusUpdateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
                        
            NSString *nameStr=[NSString stringWithFormat:@"Updated status as %@",[statusArray objectAtIndex:indexPath.row]];
           
            cell.updatedStatus=nameStr;
            cell.selectionStyle = UITableViewCellSelectionStyleNone ; 
            
        }
        
        cell.index_row=indexPath.row;
        cell.newsFeedItem=(NSDictionary*)[newsFeedsItemArray objectAtIndex:indexPath.row];
        cell.profile_img=[UIImage imageNamed:@"ImageLoading.png"];

        return cell;
        
    }
    
    return objCustTabViewCell;
    
}


-(CGFloat)heightForNewsFeedCell:(NSString *)type andPhotoUploadStatus:(NSString *)uploadStatus
{    
    
    if ([type isEqualToString:@"blog_post_add"]) 
    {               
        return 200;
    }
    else if ([type isEqualToString:@"news_post_add"]) 
    {        
        return 150;
    }
    else if ([type isEqualToString:@"friend_add"]) 
    {                
        return 190;
    }
    else if ([type isEqualToString:@"profile_avatar_change"]) 
    {        
        return 130;
    }
    else if ([type isEqualToString:@"profile_edit"]) 
    {        
        return 130;
    }
    else if ([type isEqualToString:@"profile_join"]) 
    {        
        return 130;
    }
    else if ([type isEqualToString:@"profile_comment"])
    {                
        return 175;
    }
    else if ([type isEqualToString:@"user_comment"]) 
    {        
        return 175;
    }
    else if ([type isEqualToString:@"post_classifieds_item"]) 
    {        
        return 50;
    }
    else if ([type isEqualToString:@"event_attend"]) 
    {        
        return 225;
    }
    else if ([type isEqualToString:@"event_add"]) 
    {        
        return 225;
    }
    else if ([type isEqualToString:@"group_add"])
    {        
        return 215;
    }
    else if ([type isEqualToString:@"group_join"])
    {        
        return 215;
    }
    else if ([type isEqualToString:@"photo_upload"]) 
    {       
        
        if ([uploadStatus isEqualToString:@"(null)"]||[uploadStatus isEqualToString:@""]||(uploadStatus == (id)[NSNull null])||([uploadStatus length] == 0)||(uploadStatus==NULL))
        {
            uploadStatus=@"";
        }
        
        if ([uploadStatus isEqualToString:@"Deleted Photo"]) 
        {
            return 160;
        }
        else
        {
            return 197;
        }
        
    }
    else if ([type isEqualToString:@"media_upload"]) 
    {        
        return 200;
    }
    else if ([type isEqualToString:@"music_upload"]) 
    {                
        return 200;
    }
    else if ([type isEqualToString:@"forum_add_topic"]) 
    {        
        return 200;
    }
    else if ([type isEqualToString:@"status_update"]) 
    {        
        return 130;
    }
    return 100;
}


#pragma mark IBAction

-(IBAction)clickedBackButton:(id)sender
{    
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark Managing API Calls
-(void)WebRequest:(NSDictionary*)params
{
	NSString* url = [params valueForKey:@"url"];
	NSString* meta = [params valueForKey:@"meta"];
    JSWebManager* webMgr = [[[JSWebManager alloc] initWithAsyncOption:NO] autorelease];
    NSDictionary* ret = [webMgr GetDataFromUrl:url];
    NSError* error = [ret objectForKey:@"error"];
    if (error)
    {
		self.view.userInteractionEnabled=YES;
        likesConnected=NO;
        [self stopLoading];
        self.view.userInteractionEnabled=YES;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Connection failed...Please launch the application again." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
    else
    {
        NSDictionary *parsedData = (NSDictionary *)[ret objectForKey:@"data"];
        likesConnected=NO;
        self.view.userInteractionEnabled=YES;
        NSDictionary *json = [[ret objectForKey:@"text"] JSONValue];
        
        if ([meta isEqualToString:@"newsFeedUrlconnection"])
        {
            NSString *msgStr=(NSString*)[parsedData objectForKey:@"Message"];
            
            if([msgStr isEqualToString:@"Site suspended"])
            {
                ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Site suspended";
                
                UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Site suspended. Please try after sometime." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
                sessionAlertView.tag=1;
                [sessionAlertView show];
                [sessionAlertView release];
                [JSWaiter HideWaiter];
                return;
                
            }
            else if ([msgStr isEqualToString:@"Session Expired"])
            {
                ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Session Expired";
                
                UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Your session has expired. Please login again." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
                sessionAlertView.tag=1;
                [sessionAlertView show];
                [sessionAlertView release];
                [JSWaiter HideWaiter];
                return;
                
            }
            else if ([msgStr isEqualToString:@"Membership Denied"])
            {
                UIAlertView * MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Please upgrade your membership to view newsfeed." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];            [MembershipAlertView show];
                [MembershipAlertView release];
                [JSWaiter HideWaiter];
                return;
            }
            
            NSString *resultCount = (NSString*)[parsedData objectForKey:@"count"];
            
            if([resultCount intValue]==0)
            {
                [self stopLoading];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"No newsfeeds found"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
                [alertView release];
                
            }
            else
            {
                NSArray *newsFeed = [json valueForKeyPath:@"result"];
                newsFeedsItemArray=[newsFeed copy];
                
                NSArray *picUrls = [json valueForKeyPath:@"result.Profile_Pic"];
                ProfilePicURLs=[picUrls copy];
                
                NSArray *FrdpicUrls = [json valueForKeyPath:@"result.Friend_Pic"];
                Friend_PicUrls=[FrdpicUrls copy];
                
                NSArray *uploadimgPicUrls=[json valueForKeyPath:@"result.ActionImage"];
                imgUpload_PicsUrls=[uploadimgPicUrls copy];
                
                
                NSArray *status=[json valueForKeyPath:@"result.Title"];
                statusArray=[[NSMutableArray alloc]initWithArray:status copyItems:YES];
                
                for (int i=0; i<[imgUpload_PicsUrls count]; i++)
                {
                    
                    if (([imgUpload_PicsUrls objectAtIndex:i]== (id)[NSNull null])||([imgUpload_PicsUrls objectAtIndex:i]==NULL))
                    {
                        
                        NSString *str=(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:i] valueForKey:@"entityType"];
                        
                        if ([str isEqualToString:@"event_attend"]||[str isEqualToString:@"event_add"])
                        {
                            UIImage *myimage =[UIImage imageNamed:@"event_default.png"];
                            [imgUpload_Pics addObject:myimage];
                        }
                        else
                        {
                            UIImage *myimage =[UIImage imageNamed:@"man_women_a.png"];
                            [imgUpload_Pics addObject:myimage];
                        }
                        
                    }
                    else
                    {
                        NSString *fullpath_picurl=[NSString stringWithFormat:@"%@/%@",domain,[imgUpload_PicsUrls objectAtIndex:i]];
                        NSData *mydata = [[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:fullpath_picurl]] autorelease];
                        
                        if (mydata)
                        {
                            UIImage *myimage = [[[UIImage alloc] initWithData:mydata] autorelease];
                            
                            if (myimage)
                            {
                                [imgUpload_Pics addObject:myimage];
                            }
                            else
                            {
                                NSString *str=(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:i] valueForKey:@"entityType"];
                                
                                
                                if ([str isEqualToString:@"event_attend"]||[str isEqualToString:@"event_add"])
                                {
                                    UIImage *myimage =[UIImage imageNamed:@"event_default.png"];
                                    [imgUpload_Pics addObject:myimage];
                                    
                                }
                                else
                                {
                                    UIImage *myimage =[UIImage imageNamed:@"man_women_a.png"];
                                    [imgUpload_Pics addObject:myimage];
                                }
                            }
                            
                        }
                        else
                        {
                            NSString *str=(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:i] valueForKey:@"entityType"];
                            
                            if ([str isEqualToString:@"event_attend"]||[str isEqualToString:@"event_add"])
                            {
                                UIImage *myimage =[UIImage imageNamed:@"event_default.png"];
                                [imgUpload_Pics addObject:myimage];
                                
                            }
                            else
                            {
                                UIImage *myimage =[UIImage imageNamed:@"man_women_a.png"];
                                [imgUpload_Pics addObject:myimage];
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
            [newsFeedTV reloadData];
            [self stopLoading];
            
        }
        else if([meta isEqualToString:@"likeUrlconnection"])
        {
            NSString *msgStr=(NSString*)[parsedData objectForKey:@"Message"];
            
            if([msgStr isEqualToString:@"Site suspended"])
            {
                ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Site suspended";
                
                UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Site suspended. Please try after sometime." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
                sessionAlertView.tag=1;
                [sessionAlertView show];
                [sessionAlertView release];
            }
            else if ([msgStr isEqualToString:@"Session Expired"])
            {
                ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Session Expired";
                
                UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Your session has expired. Please login again." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
                sessionAlertView.tag=1;
                [sessionAlertView show];
                [sessionAlertView release];   
            }
            else if ([msgStr isEqualToString:@"Membership Denied"])
            {
                UIAlertView * MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Please upgrade your membership." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [MembershipAlertView show];
                [MembershipAlertView release];                
            }
            else if([msgStr isEqualToString:@"Success"])
            {
                NSString *entityType=(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:selectedLike] valueForKey:@"likecount"];
                if ( (entityType == (id)[NSNull null])
                    || (entityType == NULL)
                    || ([entityType isEqualToString:@""])
                    || ([entityType length] == 0) )
                {
                }
                else
                {
                    int likecount=[entityType intValue]+1;
                    NSString *likecountStr=[NSString stringWithFormat:@"%d",likecount];
                    
                    [(NSMutableDictionary*)[newsFeedsItemArray objectAtIndex:selectedLike] setObject:likecountStr forKey:@"likecount"];
                    [(NSMutableDictionary*)[newsFeedsItemArray objectAtIndex:selectedLike] setObject:@"Liked" forKey:@"LikeStatusID"];
                    
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:selectedLike inSection:0];
                    
                    [newsFeedTV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
                }
                
            }
            else
            {
                UIAlertView * alertFailed = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Failed to like the post." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertFailed show];
                [alertFailed release];
            }
            
        }
        else if([meta isEqualToString:@"UnlikeUrlconnection"])
        {
            NSString *msgStr=(NSString*)[parsedData objectForKey:@"Message"];
            
            if([msgStr isEqualToString:@"Site suspended"])
            {
                ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Site suspended";
                
                UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Site suspended. Please try after sometime." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
                sessionAlertView.tag=1;
                [sessionAlertView show];
                [sessionAlertView release];
            }
            else if ([msgStr isEqualToString:@"Session Expired"])
            {
                ((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage=@"Session Expired";
                
                UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Your session has expired. Please login again." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
                sessionAlertView.tag=1;
                [sessionAlertView show];
                [sessionAlertView release];            
            }
            else if ([msgStr isEqualToString:@"Membership Denied"])
            {
                UIAlertView * MembershipAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Please upgrade your membership." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];            [MembershipAlertView show];
                [MembershipAlertView release];
                
            }
            else if([msgStr isEqualToString:@"Success"])
            {
                NSString *entityType=(NSString*)[(NSDictionary*)[newsFeedsItemArray objectAtIndex:selectedLike] valueForKey:@"likecount"];
                if ( (entityType == (id)[NSNull null])
                    || (entityType == NULL)
                    || ([entityType isEqualToString:@""])
                    || ([entityType length] == 0) )
                {
                }
                else
                {
                    int likecount=[entityType intValue]-1;
                    NSString *likecountStr=[NSString stringWithFormat:@"%d",likecount];
                    
                    [(NSMutableDictionary*)[newsFeedsItemArray objectAtIndex:selectedLike] setObject:likecountStr forKey:@"likecount"];
                    [(NSMutableDictionary*)[newsFeedsItemArray objectAtIndex:selectedLike] setObject:@"UnLiked" forKey:@"LikeStatusID"];
                    
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:selectedLike inSection:0];
                    [newsFeedTV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
                    
                }
            }
            else
            {
                UIAlertView * alertFailed = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Failed to unlike the post." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];          
                [alertFailed show];
                [alertFailed release];
            }                        
        }
    }
    [JSWaiter HideWaiter];
}


#pragma mark Alert View Delegate

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex 
{
    
    if (actionSheet.tag==1) 
    {
        if (buttonIndex == 0)
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }
        
    }
    
}

@end
