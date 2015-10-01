//
//  XDKAccount.m
//  XDK微博
//
//  Created by 徐宽阔 on 15/6/21.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import "XDKAccount.h"

@implementation XDKAccount


+(instancetype)accountWithDict:(NSDictionary *)dict
{
    XDKAccount *account = [[self alloc] init];
    account.access_token = dict[@"access_token"];
    account.expires_in = dict[@"expires_in"];
    account.uid = dict[@"uid"];
    account.create_time = [NSDate date];
    return account;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in   forKey:@"expires_in"];
    [aCoder encodeObject:self.uid  forKey:@"uid"];
    [aCoder encodeObject:self.create_time  forKey:@"create_time"];
    [aCoder encodeObject:self.name  forKey:@"name"];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.create_time = [aDecoder decodeObjectForKey:@"create_time"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}

@end
