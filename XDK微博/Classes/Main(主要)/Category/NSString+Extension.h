//
//  NSString+Extension.h
//  XDK微博
//
//  Created by 徐宽阔 on 15/7/18.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

- (CGSize)sizeWithTextFont:(UIFont *)font maxW:(CGFloat)maxW;

- (CGSize)sizeWithTextFont:(UIFont *)font;
@end
