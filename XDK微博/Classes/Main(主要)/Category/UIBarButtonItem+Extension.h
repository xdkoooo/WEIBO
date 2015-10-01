//
//  UIBarButtonItem+Extension.h
//  XDK微博
//
//  Created by 徐宽阔 on 15/6/2.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
/**
 *  创建一个item
 *
 *  @param target    点击item后调用哪个对象的方法
 *  @param action    点击对象后调用target的哪个方法
 *  @param image     图片
 *  @param highImage 高亮图片
 *
 *  @return <#return value description#>
 */
+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;
@end
