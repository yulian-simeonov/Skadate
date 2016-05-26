//
//  CommonMethods.m
//  Skadate
//
//  Created by SodiPhone_7 on 24/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CommonMethods.h"

@implementation CommonMethods
@synthesize domain;
@synthesize delegate;

#pragma mark Memory Management

- (void)dealloc
{	
	[super dealloc];
}

#pragma mark Custom Methods

-(void )fetchNotification
{    
    if (((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedSessionID)
    {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        domain = [prefs stringForKey:@"URL"];
        NSString *urlReq = [NSString stringWithFormat:@"%@/mobile/NotificationCount/?pid=%@&skey=%@",domain,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedSessionID];        
        
        NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:urlReq, @"url", @"NotificationCountConnection", @"meta", nil];
        [self performSelectorOnMainThread:@selector(WebRequest:) withObject:params waitUntilDone:NO];
    }
}

-(void)fetchProfilePhoto:(NSString *) profileId
{    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    domain = [prefs stringForKey:@"URL"];
    NSString *req = [NSString stringWithFormat:@"%@/mobile/ViewPhotos/?id=%@&vid=%@&skey=%@",domain,profileId,((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedSessionID];
  
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:req, @"url", @"ProfilePhotConnection", @"meta", nil];
    [self performSelectorOnMainThread:@selector(WebRequest:) withObject:params waitUntilDone:NO];
}

#pragma mark -Managing API Calls
-(void)WebRequest:(NSDictionary*)params
{
	NSString* url = [params valueForKey:@"url"];
	NSString* meta = [params valueForKey:@"meta"];
    JSWebManager* webMgr = [[[JSWebManager alloc] initWithAsyncOption:NO] autorelease];
    NSDictionary* ret = [webMgr GetDataFromUrl:url];
    NSError* error = [ret objectForKey:@"error"];
    if (error)
    {
		
    }
    else
    {
        NSDictionary *parsedData = (NSDictionary *)[ret objectForKey:@"data"];
        if (!parsedData)
            return;
        if ([meta isEqualToString:@"NotificationCountConnection"])
        {
            [delegate loadNotificatonCounts:parsedData];
        }
        else if ([meta isEqualToString:@"ProfilePhotConnection"])
        {
            [delegate loadNotificatonCounts:parsedData];
        }
    }
    [JSWaiter HideWaiter];
}
    
@end
