//
//  XDKUser.m
//  XDK微博
//
//  Created by 徐宽阔 on 15/6/26.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import "XDKUser.h"

@implementation XDKUser

- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    
    self.vip = mbtype > 2;
}

//- (BOOL)isVip
//{
//    return self.mbrank > 2;
//}


@end
