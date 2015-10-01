//
//  XDKLoadMoreView.m
//  XDK微博
//
//  Created by 徐宽阔 on 15/6/30.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import "XDKLoadMoreView.h"

@implementation XDKLoadMoreView

+(instancetype)footer
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

@end
