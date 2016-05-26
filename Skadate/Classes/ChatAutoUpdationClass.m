//
//  ChatAutoUpdationClass.m
//  Skadate
//
//  Created by SOD TECH on 12/04/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "ChatAutoUpdationClass.h"

@implementation ChatAutoUpdationClass
@synthesize domain;
@synthesize chatDelegate;

#pragma mark Custom Method

-(void)updateChats:(NSString *) receipientProfileId
{    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    domain = [prefs stringForKey:@"URL"];
    
    NSString *req = [NSString stringWithFormat:@"%@/mobile/PrivateChatMsgReceiving/?sid=%@&rid=%@&skey=%@",domain,receipientProfileId,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID,((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID];

    [self performSelectorOnMainThread:@selector(WebRequest:) withObject:req waitUntilDone:NO];
}

#pragma mark -Managing API Calls

-(void)WebRequest:(NSString*)url
{
    JSWebManager* webMgr = [[[JSWebManager alloc] initWithAsyncOption:NO] autorelease];
    NSDictionary* ret = [webMgr GetDataFromUrl:url];
    NSError* error = [ret objectForKey:@"error"];
    if (error)
    {
		
    }
    else
    {
        [chatDelegate loadChats:[ret objectForKey:@"text"]];
    }
}


@end
