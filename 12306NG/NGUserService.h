//
//  NGUserService.h
//  12306NG
//
//  Created by Lei Sun on 12/29/12.
//  Copyright (c) 2012 12306NG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface NGUserService : NSObject
{
    
}
+(id)sharedService;
-(UIImage*)getValidateCodeImage;
-(BOOL)LoginInWithName:(NSString*)userName andPwd:(NSString*)userPwd andCode:(NSString*)code;
-(void)LoginOut;
-(NSMutableDictionary*)getUserInfo;
@end
