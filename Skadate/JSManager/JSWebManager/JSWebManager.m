//
//  WebManager.m
//  WebTest
//
//  Created by ZhiXing Li on 9/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JSWebManager.h"

@implementation JSWebManager
@synthesize delegate;

-(id)initWithAsyncOption:(BOOL)isAsync
{
    if (self = [super init])
    {
        m_jsonManager = [[JSONManager alloc] initWithAsyncOption:isAsync];
        [m_jsonManager setDelegate:self];
        m_url = @"http://www.muaythaiu.com/index.php";
        m_isAsync = isAsync;
        m_requestActionName = None;
    }
    return self;
}

-(void)SetUrl:(NSString*)url
{
    m_url = [url retain];
}

-(void)dealloc
{
    [super dealloc];
    [m_jsonManager release];
}

-(void)CancelRequest
{
    [m_jsonManager RequestCancel];
}

-(void)JSONRequestFinished:(ASIHTTPRequest*)request decoder:(JSONDecoder*)jsonDecoder
{
    if (delegate)
        [delegate ReceivedValue:request];
}

-(void)JSONRequestFailed:(NSError*)error
{
    if (delegate != nil)
    {
        [delegate WebManagerFailed:error];
    }
    m_requestActionName = None;
}

- (void)FileDownload:(NSString*)url savePath:(NSString *)path
{
    [m_jsonManager DownloadFile:url SavePath:path];
}

#pragma APIs
-(NSDictionary*)GetDataFromUrl:(NSString*)url
{
    NSDictionary* ret = nil;
    ASIHTTPRequest* obj = [m_jsonManager JSONRequest:url params:nil requestMethod:GET];
    if (obj.error)
    {
        ret = [NSDictionary dictionaryWithObjectsAndKeys:obj.error, @"error", nil];
    }
    else
    {
        NSLog(@"%@", [obj responseString]);
        ret = [NSDictionary dictionaryWithObjectsAndKeys:[m_jsonManager->m_jsonDecoder objectWithData:[obj responseData]], @"data", [obj responseString], @"text", nil];
    }
    return ret;
}
@end
