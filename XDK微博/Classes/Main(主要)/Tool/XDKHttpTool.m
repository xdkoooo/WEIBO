//
//  XDKHttpTool.m
//  XDK微博
//
//  Created by 徐宽阔 on 15/7/25.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import "XDKHttpTool.h"
#import "AFNetworking.h"

@implementation XDKHttpTool
+(void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void(^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void(^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
