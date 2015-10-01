//
//  NSString+Extension.m
//  XDK微博
//
//  Created by 徐宽阔 on 15/7/18.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)


- (CGSize)sizeWithTextFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    
    if (iOS7) {
        return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    }else{
        return [self sizeWithFont:font constrainedToSize:maxSize];
    }
}

- (CGSize)sizeWithTextFont:(UIFont *)font
{
    return [self sizeWithTextFont:font maxW:MAXFLOAT];
}

@end
