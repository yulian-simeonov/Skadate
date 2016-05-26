//
//  MyAnnotation.m
//  SimpleMapView
//
//  Created by Mayur Birari .

//

#import "MyAnnotation.h"


@implementation MyAnnotation

@synthesize title,image1;
@synthesize subtitle;
@synthesize coordinate;
@synthesize userProfileId;

#pragma mark Memory Management

- (void)dealloc 
{
	[super dealloc];
	self.title = nil;
	self.subtitle = nil;
}
@end