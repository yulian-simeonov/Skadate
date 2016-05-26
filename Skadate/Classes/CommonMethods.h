//
//  CommonMethods.h
//  Skadate
//
//  Created by SodiPhone_7 on 24/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON.h"
#import "SkadateAppDelegate.h"
#import "JSWaiter.h"
#import "JSWebManager.h"

@protocol NotificationCountDelegate;

@interface CommonMethods : NSObject
{    
    id <NotificationCountDelegate> delegate;
    NSString *domain;
}

@property (nonatomic,retain) NSString *domain;

@property (nonatomic, assign) id <NotificationCountDelegate> delegate;

-(void)fetchNotification;
-(void)fetchProfilePhoto:(NSString *) profileId;

@end

@protocol NotificationCountDelegate 

- (void)loadNotificatonCounts:(NSDictionary *)notification;

@end

