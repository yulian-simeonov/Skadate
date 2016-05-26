//
//  DisplayDateTime.m
//  Skadate
//
//  Created by  on 28/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DisplayDateTime.h"

@implementation DisplayDateTime

#pragma mark Custom Methods

-(NSString*)CalculateTime :(NSString *)serverTime andServerTimeZone : (NSString *)serverTimeZone andDeviceTimeZone : (NSString *)DeviceTimeZone
{    
    NSString *DisplayTime=@"";
    NSString *dateStr =serverTime;
    NSString *TimeZone=serverTimeZone;
    NSString *TimeZoneName=DeviceTimeZone; 
       
    NSDateFormatter *dateFormatter1 = [[[NSDateFormatter alloc] init]autorelease]; 
    [dateFormatter1 setDateFormat:@"MM-dd-yyyy HH:mm:ss"]; 
    [dateFormatter1 setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSDate *date = [dateFormatter1 dateFromString:dateStr];
          
    NSTimeZone *currentTimeZone = [NSTimeZone timeZoneWithName:TimeZoneName];
    NSTimeZone *utcTimeZone = [NSTimeZone timeZoneWithName:TimeZone];
    NSInteger currentGMTOffset = [currentTimeZone secondsFromGMTForDate:date];
    NSInteger gmtOffset = [utcTimeZone secondsFromGMTForDate:date];
    NSTimeInterval gmtInterval = currentGMTOffset - gmtOffset;
    NSDate *destinationDate = [[[NSDate alloc] initWithTimeInterval:gmtInterval sinceDate:date]autorelease] ;
       
    NSDateFormatter *dateFormatters = [[[NSDateFormatter alloc] init]autorelease];
    [dateFormatters setDateFormat:@"MM-dd-yyyy HH:mm:ss"]; 
    [dateFormatters setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSString *dateStr1 = [dateFormatters stringFromDate: destinationDate];
        
    NSDate* sourceDate = [NSDate date];
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone* destinationTimeZone = [NSTimeZone timeZoneWithName:TimeZoneName];
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    NSDate* now = [[[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate]autorelease];
    
    //GET # OF DAYS
    NSDateFormatter *df = [[[NSDateFormatter alloc] init]autorelease];
    [df setDateFormat:@"dd MM yyyy"];
    //Remove the time part
    [df setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSString *TodayString = [df stringFromDate:now];
    NSString *TargetDateString = [df stringFromDate:destinationDate];
    NSTimeInterval time = [[df dateFromString:TodayString] timeIntervalSinceDate:[df dateFromString:TargetDateString]];
    
    int days = time / 60 / 60/ 24;
    if (days<=0)
    {        
        NSDateFormatter *df1 = [[[NSDateFormatter alloc] init]autorelease];
        [df1 setDateFormat:@"HH:mm"];
        [df1 setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        NSString *TodayString1 = [df1 stringFromDate:now];
        NSString *TargetDateString1 = [df1 stringFromDate:destinationDate];
        NSTimeInterval time1 = [[df1 dateFromString:TodayString1] timeIntervalSinceDate:[df1 dateFromString:TargetDateString1]];
        
        NSInteger totalSeconds = floor(time1);
        NSInteger minutes = totalSeconds / 60; 
        NSInteger hours = minutes / 60;     
        if(hours>0)
        {
            DisplayTime = [NSString stringWithFormat:@"%i hours ago",hours];
        }
        else
        {
            if(minutes>0)
            {
                DisplayTime = [NSString stringWithFormat:@"%i minutes ago",minutes];
            }
            else
            {
                DisplayTime = [NSString stringWithFormat:@"%@",@"Few seconds ago"];
            }
        }
    }
    else
    {
        switch (days) 
        {
            case 1:
                    DisplayTime = [NSString stringWithFormat:@"%@",@"Yesterday"];
                    break;
            case 2:
                    DisplayTime = [NSString stringWithFormat:@"%@",@"2 days ago"];
                    break;
                
            default:
                    DisplayTime = [NSString stringWithFormat:@"%@",dateStr1];
                    break;
        }
    }
    return DisplayTime;
}


-(NSString*)ConvertDateTime :(NSString *)serverTime andServerTimeZone : (NSString *)serverTimeZone andDeviceTimeZone : (NSString *)DeviceTimeZone
{    
    
    NSString *DisplayTime=@"";
    NSString *dateStr =serverTime;
    NSString *TimeZone=serverTimeZone;
    NSString *TimeZoneName=DeviceTimeZone; 
       
    NSDateFormatter *dateFormatter1 = [[[NSDateFormatter alloc] init]autorelease]; 
    [dateFormatter1 setDateFormat:@"MM-dd-yyyy HH:mm:ss"]; 
    [dateFormatter1 setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSDate *date = [dateFormatter1 dateFromString:dateStr];
    
    NSTimeZone *currentTimeZone = [NSTimeZone timeZoneWithName:TimeZoneName];
    NSTimeZone *utcTimeZone = [NSTimeZone timeZoneWithName:TimeZone];
    NSInteger currentGMTOffset = [currentTimeZone secondsFromGMTForDate:date];
    NSInteger gmtOffset = [utcTimeZone secondsFromGMTForDate:date];
    NSTimeInterval gmtInterval = currentGMTOffset - gmtOffset;
    NSDate *destinationDate = [[[NSDate alloc] initWithTimeInterval:gmtInterval sinceDate:date]autorelease];
    
    NSDateFormatter *dateFormatters = [[[NSDateFormatter alloc] init]autorelease];
    [dateFormatters setDateFormat:@"MM-dd-yyyy HH:mm:ss"]; 
    [dateFormatters setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSString *dateStr1 = [dateFormatters stringFromDate: destinationDate];
       
    NSDate* sourceDate = [NSDate date];
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone* destinationTimeZone = [NSTimeZone timeZoneWithName:TimeZoneName];
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    NSDate* now = [[[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate]autorelease];
     
    //GET # OF DAYS
    NSDateFormatter *df = [[[NSDateFormatter alloc] init]autorelease];
    [df setDateFormat:@"dd MM yyyy"];       //Remove the time part
    [df setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSString *TodayString = [df stringFromDate:now];
    NSString *TargetDateString = [df stringFromDate:destinationDate];
    NSTimeInterval time = [[df dateFromString:TodayString] timeIntervalSinceDate:[df dateFromString:TargetDateString]];
    
    int days = time / 60 / 60/ 24;
    if (days<=0)
    {        
        NSDateFormatter *df1 = [[[NSDateFormatter alloc] init]autorelease];
        [df1 setDateFormat:@"HH:mm"];
        [df1 setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        NSString *formatedTime = [df1 stringFromDate:destinationDate];
        DisplayTime = [NSString stringWithFormat:@"%@",formatedTime];
    }
    else
    {
        DisplayTime = [NSString stringWithFormat:@"%@",dateStr1];
    }
    return DisplayTime;
}


-(NSString*)ConvertTime :(NSString *)serverTime andServerTimeZone : (NSString *)serverTimeZone andDeviceTimeZone : (NSString *)DeviceTimeZone
{        
    NSString *dateStr =serverTime;
    NSString *TimeZone=serverTimeZone;
    NSString *TimeZoneName=DeviceTimeZone; 
        
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init]autorelease]; 
    [dateFormatter setDateFormat:@"MM-dd-yyyy HH:mm:ss"]; 
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSDate *date = [dateFormatter dateFromString:dateStr];
         
    NSTimeZone *currentTimeZone = [NSTimeZone timeZoneWithName:TimeZoneName];
    NSTimeZone *utcTimeZone = [NSTimeZone timeZoneWithName:TimeZone];
    NSInteger currentGMTOffset = [currentTimeZone secondsFromGMTForDate:date];
    NSInteger gmtOffset = [utcTimeZone secondsFromGMTForDate:date];
    NSTimeInterval gmtInterval = currentGMTOffset - gmtOffset;
    NSDate *destinationDate = [[[NSDate alloc] initWithTimeInterval:gmtInterval sinceDate:date]autorelease];
        
    NSDateFormatter *df = [[[NSDateFormatter alloc] init]autorelease];
    [df setDateFormat:@"HH:mm"];
    [df setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSString *timeStr = [df stringFromDate:destinationDate];
           
    return timeStr;   
}


-(NSString*)ConvertMailBoxDateTime :(NSString *)serverTime andServerTimeZone : (NSString *)serverTimeZone andDeviceTimeZone : (NSString *)DeviceTimeZone
{    
    
    NSString *DisplayTime=@"";
    
    NSString *dateStr =serverTime;
    NSString *TimeZone=serverTimeZone;
    NSString *TimeZoneName=DeviceTimeZone; 
    
    NSDateFormatter *dateFormatter1 = [[[NSDateFormatter alloc] init]autorelease]; 
    [dateFormatter1 setDateFormat:@"MM-dd-yyyy HH:mm:ss"]; 
    [dateFormatter1 setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSDate *date = [dateFormatter1 dateFromString:dateStr];
        
    NSTimeZone *currentTimeZone = [NSTimeZone timeZoneWithName:TimeZoneName];
    NSTimeZone *utcTimeZone = [NSTimeZone timeZoneWithName:TimeZone];
    NSInteger currentGMTOffset = [currentTimeZone secondsFromGMTForDate:date];
    NSInteger gmtOffset = [utcTimeZone secondsFromGMTForDate:date];
    NSTimeInterval gmtInterval = currentGMTOffset - gmtOffset;
    NSDate *destinationDate = [[[NSDate alloc] initWithTimeInterval:gmtInterval sinceDate:date]autorelease];
    
    NSDateFormatter *dateFormatters = [[[NSDateFormatter alloc] init]autorelease];
    [dateFormatters setDateFormat:@"MM-dd-yyyy"];
    [dateFormatters setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSString *dateStr1 = [dateFormatters stringFromDate: destinationDate];
    
    NSDate* sourceDate = [NSDate date];
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone* destinationTimeZone = [NSTimeZone timeZoneWithName:TimeZoneName];
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    NSDate* now = [[[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate]autorelease];
        
    //GET # OF DAYS
    NSDateFormatter *df = [[[NSDateFormatter alloc] init]autorelease];
    [df setDateFormat:@"dd MM yyyy"];       //Remove the time part
    [df setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSString *TodayString = [df stringFromDate:now];
    NSString *TargetDateString = [df stringFromDate:destinationDate];
    NSTimeInterval time = [[df dateFromString:TodayString] timeIntervalSinceDate:[df dateFromString:TargetDateString]];
    
    int days = time / 60 / 60/ 24;
    if (days<=0)
    {        
        NSDateFormatter *df1 = [[[NSDateFormatter alloc] init]autorelease];
        [df1 setDateFormat:@"HH:mm"];
        [df1 setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        NSString *formatedTime = [df1 stringFromDate:destinationDate];
        DisplayTime = [NSString stringWithFormat:@"%@",formatedTime];
    }
    else
    {
        if(days==1)
        {
            DisplayTime = [NSString stringWithFormat:@"%@",@"Yesterday"];
        }
        else if((days>1) && (days<=7))
        {            
            NSDateFormatter *myFormatter = [[[NSDateFormatter alloc] init]autorelease];
            [myFormatter setDateFormat:@"EEEE"]; // day, like "Saturday"
            NSString *dayOfWeek = [myFormatter stringFromDate:destinationDate];
            DisplayTime = [NSString stringWithFormat:@"%@",dayOfWeek];
        }
        else
        {
            DisplayTime = [NSString stringWithFormat:@"%@",dateStr1];
        }
    }
    return DisplayTime;
}


@end
