//
//  XDKAccount.h
//  XDK微博
//
//  Created by 徐宽阔 on 15/6/21.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XDKAccount : NSObject <NSCoding>

/** access_token */
@property (nonatomic,copy)NSString * access_token;

/** expires_in */
@property (nonatomic,copy)NSNumber * expires_in;

/** uid */
@property (nonatomic,copy)NSString * uid;

/** 创建account时间 */
@property (nonatomic,copy)NSDate * create_time;

/** name */
@property (nonatomic,copy)NSString * name;


+(instancetype)accountWithDict:(NSDictionary *)dict;
@end
