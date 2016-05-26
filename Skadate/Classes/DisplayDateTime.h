//
//  DisplayDateTime.h
//  Skadate
//
//  Created by  on 28/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DisplayDateTime : NSObject


-(NSString*)CalculateTime :(NSString *)serverTime andServerTimeZone : (NSString *)serverTimeZone andDeviceTimeZone : (NSString *)DeviceTimeZone;
-(NSString*)ConvertDateTime :(NSString *)serverTime andServerTimeZone : (NSString *)serverTimeZone andDeviceTimeZone : (NSString *)DeviceTimeZone;
-(NSString*)ConvertTime :(NSString *)serverTime andServerTimeZone : (NSString *)serverTimeZone andDeviceTimeZone : (NSString *)DeviceTimeZone;
-(NSString*)ConvertMailBoxDateTime :(NSString *)serverTime andServerTimeZone : (NSString *)serverTimeZone andDeviceTimeZone : (NSString *)DeviceTimeZone;

@end
