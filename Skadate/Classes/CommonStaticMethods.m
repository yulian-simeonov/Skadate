//
//  CommonStaticMethods.m
//  Skadate
//
//  Created by  on 07/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "CommonStaticMethods.h"

@implementation CommonStaticMethods
@synthesize resultStr;

static CommonStaticMethods *sharedObject;

#pragma mark Class Methods

+ (CommonStaticMethods*)sharedInstance

{
    if (sharedObject == nil)
    {
       sharedObject = [[super allocWithZone:NULL] init];
    }
   return sharedObject;
}

+(NSString*)GetMonthName : (NSString*) monthNumber
{
    NSString *MonthName=@"";
        
    switch ([monthNumber integerValue]) 
    {
        case 1:
                MonthName = @"January";
                break;
        case 2:
                MonthName = @"February";
                break;
        case 3:
                MonthName = @"March";
                break;
        case 4:
                MonthName = @"April";
                break;
        case 5:
                MonthName = @"May";
                break;
        case 6:
                MonthName = @"June";
                break;
        case 7:
                MonthName = @"July";
                break;
        case 8:
                MonthName = @"August";
                break;
        case 9:
                MonthName = @"September";
                break;
        case 10:
                MonthName = @"October";
                break;
        case 11:
                MonthName = @"November";
                break;
        case 12:
                MonthName = @"December";
                break;
        default:
                MonthName=@"";
                break;
    }
   return MonthName; 
}


+(NSString*)GetMonthNumber : (NSString*) monthName
{
    NSString *MonthNumber=@"";
        
    if( [monthName isEqualToString:@"January"])
    {
        MonthNumber=@"01";
    }
    else if( [monthName isEqualToString:@"February"])
    {
        MonthNumber=@"02";
    }
    else if( [monthName isEqualToString:@"March"])
    {
        MonthNumber=@"03";
    }
    
    else if( [monthName isEqualToString:@"April"])
    {
        MonthNumber=@"04";
    }
    else if( [monthName isEqualToString:@"May"])
    {
        MonthNumber=@"05";
    }
    else if( [monthName isEqualToString:@"June"])
    {
        MonthNumber=@"06";
    }
    else if( [monthName isEqualToString:@"July"])
    {
        MonthNumber=@"07";
    }
    else if( [monthName isEqualToString:@"August"])
    {
        MonthNumber=@"08";
    }
    else if( [monthName isEqualToString:@"September"])
    {
        MonthNumber=@"09";
    }
            
    else if( [monthName isEqualToString:@"October"])
    {
        MonthNumber=@"10";
    }
    else if( [monthName isEqualToString:@"November"])
    {
        MonthNumber=@"11";
    }
    else if( [monthName isEqualToString:@"December"])
    {
        MonthNumber=@"12";
    }
    return MonthNumber; 
}


+(NSString *) getUserStatus
{
    
    CommonStaticMethods *shared = [CommonStaticMethods sharedInstance];
    shared.resultStr=@"";
    NSString *UserStatus=((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserStatus;
    NSString *UserUnRegistered=((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserUnRegistered;
    NSString *sessionExpired=((SkadateAppDelegate *)[UIApplication sharedApplication].delegate).loggedUserMessage;
    if ([sessionExpired isEqualToString:@""]||(sessionExpired == (id)[NSNull null])||([sessionExpired length] == 0)||(sessionExpired==NULL)) 
    {
        sessionExpired=@"";
    }
    if([sessionExpired isEqualToString:@"Session Expired"])
    {
        shared.resultStr=@"Your session has expired. Please login again.";
    }
    else if([sessionExpired isEqualToString:@"Site suspended"])
    {
        shared.resultStr=@"Site suspended. Please try after sometime.";
    }
    else
    {
        if ([UserStatus isEqualToString:@""]||(UserStatus == (id)[NSNull null])||([UserStatus length] == 0)||(UserStatus==NULL)) 
        {
            if ([UserUnRegistered isEqualToString:@""]||(UserUnRegistered == (id)[NSNull null])||([UserUnRegistered length] == 0)||(UserUnRegistered==NULL))
            {
                shared.resultStr=@"";
            }
            else
            {
                // UserUnRegistered=0 (normal) or 1 (deleted)
                if ([UserUnRegistered isEqualToString:@"1"])
                {
                    shared.resultStr=@"You have been deleted. Contact our support for any concerns!";
                }
                else if ([UserUnRegistered isEqualToString:@"0"])
                {
                    shared.resultStr=@"You have been un-registered. Contact our support for any concerns!";
                }
                else
                {
                    shared.resultStr=@"";
                }
            }
        }
        else
        {
            // status=suspended or active
            if ([UserStatus isEqualToString:@"suspended"])
            {
                shared.resultStr=@"You have been suspended. Contact our support for any concerns!";
            }
            else
            {
                if ([UserStatus isEqualToString:@"active"])
                {
                    shared.resultStr=@"";
                }
                else
                {
                    if ([UserUnRegistered isEqualToString:@""]||(UserUnRegistered == (id)[NSNull null])||([UserUnRegistered length] == 0)||(UserUnRegistered==NULL))
                    {
                        shared.resultStr=@"";
                    }
                    else
                    {
                        // UserUnRegistered=0 (normal) or 1 (deleted)
                        if ([UserUnRegistered isEqualToString:@"1"] && UserStatus )
                        {
                            shared.resultStr=@"You have been deleted. Contact our support for any concerns!";
                        }
                        else if ([UserUnRegistered isEqualToString:@"0"])
                        {
                            shared.resultStr=@"You have been un-registered. Contact our support for any concerns!";
                        }
                        else
                        {
                            shared.resultStr=@"";
                        }
                    }
                    
                }
                
            }
            
        }
        
    }
    
    return shared.resultStr;
}


+(BOOL)directoryExistsAtAbsolutePath:(NSString*)path 
{
    NSFileManager* fm = [NSFileManager defaultManager];
    BOOL isDir;
    BOOL exists = [fm fileExistsAtPath:path isDirectory:&isDir];
    if (exists)
    {
        return TRUE;
    }
    return FALSE;
}


@end
