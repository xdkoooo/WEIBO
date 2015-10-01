//
//  XDKAccountTool.m
//  XDK微博
//
//  Created by 徐宽阔 on 15/6/21.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#define XDKAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]


#import "XDKAccountTool.h"




@implementation XDKAccountTool


+(void)saveAccount:(XDKAccount *)account
{
//    account.create_time = [NSDate date];
    [NSKeyedArchiver archiveRootObject:account toFile:XDKAccountPath];
}

+(XDKAccount *)account
{
    XDKAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:XDKAccountPath];
    
    NSDate *now = [NSDate date];
    long long expires_in = [account.expires_in longLongValue];
    NSDate *expiresTime = [account.create_time dateByAddingTimeInterval:expires_in];
    
    NSComparisonResult result = [expiresTime compare:now];
    
//    XDKLog(@"%@ , %@",account.create_time, expiresTime);
    
    if (result != NSOrderedDescending) {
        return nil;
    }
    return account;
}

@end
