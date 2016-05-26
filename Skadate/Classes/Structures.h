//
//  Structures.h
//  Chk
//
//  Created by kavitha on 05/09/11.
//  Copyright 2011 Solutions On Demand Australasia Pty Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct{
	
	NSString *loginStatus;
    NSString *profilePicURL;
    NSString *profileId;
    NSString *gender;
    NSString *skey;
    NSNumber *notifications;
    NSString *TimeZone;
	
}SignInResp;


typedef struct{
	
	NSString *frgtPwStatusMsg;
	
}ForgotPasswordResp;


typedef struct{
	
	NSString *loginNameAvailStat;
	NSString *LoginURLValidity;
    
}SignUpInitialResp;


typedef struct{
    
    NSString *profileID;
    NSString *fullName;
    NSString *realName;
    NSString *sex;
    NSString *match_sex;
    NSString *headline;
    NSString *dob;
    NSString *matchAge;
    NSString *essays;
    NSString *membershipTypeId;
    NSString *hasPhoto;
    NSString *hasMedia;
    NSString *status;
    NSString *featured;
    NSString *bgImageURL;
    NSString *isPrivate;
    
}ProfileResp;


@interface Structures : NSObject {
    
}

@end
