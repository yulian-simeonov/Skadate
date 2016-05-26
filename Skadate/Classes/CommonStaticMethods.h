//
//  CommonStaticMethods.h
//  Skadate
//
//  Created by  on 07/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SkadateAppDelegate.h"
#import <UIKit/UIKit.h>

@interface CommonStaticMethods : NSObject
{
    NSString *resultStr;
}

@property (nonatomic, retain) NSString *resultStr;

+(NSString *) getUserStatus ;
+(BOOL)directoryExistsAtAbsolutePath:(NSString*)path ;
+(NSString*)GetMonthName : (NSString*) monthNumber;
+(NSString*)GetMonthNumber : (NSString*) monthName;

@end
