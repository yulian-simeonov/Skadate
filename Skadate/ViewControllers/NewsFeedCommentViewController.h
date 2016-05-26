//
//  NewsFeedCommentViewController.h
//  Skadate
//
//  Created by Heinz Vallonthaiel on 1/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SkadateAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "JSWaiter.h"
#import "JSWebManager.h"

@interface NewsFeedCommentViewController : UIViewController<UITextViewDelegate,UIAlertViewDelegate>
{    
    IBOutlet UINavigationBar *navBar;
    IBOutlet UITextView *commentTextView;
    
    NSString *entityId;
    NSString *domain;
    
    float NewXval;

}
@property(nonatomic,retain) IBOutlet UITextView *commentTextView;

@property (nonatomic,assign)float NewXval;

@property(nonatomic,retain) NSString *entityId;
@property(nonatomic,retain) NSString *domain;

-(IBAction)clickedCancelButton:(id)sender;
-(IBAction)clickedPostButton:(id)sender;

@end
