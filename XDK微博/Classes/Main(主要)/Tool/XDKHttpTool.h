//
//  XDKHttpTool.h
//  XDK微博
//
//  Created by 徐宽阔 on 15/7/25.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XDKHttpTool : NSObject

+(void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void(^)(NSError *error))failure;

+(void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void(^)(NSError *error))failure;

@end
