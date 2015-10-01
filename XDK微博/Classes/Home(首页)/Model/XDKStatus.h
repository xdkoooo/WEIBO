//
//  XDKStatus.h
//  XDK微博
//
//  Created by 徐宽阔 on 15/6/26.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XDKUser;
@interface XDKStatus : NSObject

/** UID */
@property (nonatomic,copy)NSString * idstr;

/** 微博信息内容 */
@property (nonatomic,copy)NSString * text;

/** 微博作者的用户信息字段 详细 */
@property (nonatomic,strong)XDKUser * user;

/**	string	微博创建时间*/
@property (nonatomic, copy) NSString *created_at;

/**	string	微博来源*/
@property (nonatomic, copy) NSString *source;

/**	array 微博配图地址*/
@property (nonatomic, copy) NSArray *pic_urls;

@property (nonatomic,strong) XDKStatus *retweeted_status;

/** reposts_count转发数 */
@property (nonatomic,assign)int reposts_count;
/** comments_count评论数 */
@property (nonatomic,assign)int comments_count;
/** attitudes_count点赞数 */
@property (nonatomic,assign)int attitudes_count;
@end
