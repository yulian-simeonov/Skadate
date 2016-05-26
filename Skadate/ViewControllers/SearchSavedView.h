//
//  SearchSavedView.h
//  Skadate
//
//  Created by SREEJITH P.R. on 20/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSWaiter.h"
#import "JSWebManager.h"

@interface SearchSavedView : UIViewController<UIAlertViewDelegate>
{    
    IBOutlet UINavigationBar *navBar;
    IBOutlet UILabel *searchsavedlab;
    IBOutlet UIButton *btnBack; 
    IBOutlet UITableView *table;
    IBOutlet UISegmentedControl *control1;
    
    NSString *domain;
    NSString *urlReq;
    NSMutableArray *listOfNames;
    NSMutableArray *searchId;
    	   
    int fromView;
    float NewXval;
} 

@property (nonatomic, retain) IBOutlet UITableView *table;
@property (nonatomic, retain) IBOutlet UISegmentedControl *control1;
@property (nonatomic, retain) IBOutlet UIButton *btnBack;
@property (nonatomic, retain) IBOutlet UINavigationBar *navBar;
@property (nonatomic, retain) IBOutlet UILabel *searchsavedlab;

@property(nonatomic, retain) NSString *domain;
@property (nonatomic,retain) NSString *urlReq;
@property (nonatomic,retain) NSMutableArray *listOfNames;
@property (nonatomic,retain) NSMutableArray *searchId;

@property (nonatomic) int fromView;
@property (nonatomic,assign)float NewXval;

-(IBAction)clickedBackButton:(id) sender;
-(IBAction)clickedSegmentControllerSearchedSaved;

@end
