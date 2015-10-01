//
//  XDKUser.h
//  XDK微博
//
//  Created by 徐宽阔 on 15/6/26.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    XDKUserVerifiedNone = -1,
    XDKUserVerifiedPersonal = 0,
    XDKUserVerifiedEnterprice = 2,
    XDKUserVerifiedOrgMedia = 3,
    XDKUserVerifiedOrgWebsite = 5,
    XDKUserVerifiedDaren = 220
} XDKUserVerifiedType;


@interface XDKUser : NSObject
/** UID */
@property (nonatomic,copy)NSString * idstr;

/** 好友显示名称 */
@property (nonatomic,copy)NSString * name;

/** 用户头像地址 */
@property (nonatomic,copy)NSString * profile_image_url;

/** 会员类型 > 2代表是会员 */
@property (nonatomic, assign) int mbtype;
/** 会员等级 */
@property (nonatomic, assign) int mbrank;
@property (nonatomic, assign, getter = isVip) BOOL vip;

/** 微博认证 */
@property (nonatomic,assign)XDKUserVerifiedType verified_type;


@end
