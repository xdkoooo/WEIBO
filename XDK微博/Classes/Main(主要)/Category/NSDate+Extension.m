//
//  NSDate+Extension.m
//  XDK微博
//
//  Created by 徐宽阔 on 15/7/18.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

/**
 *  判断是否为今年
 */
-(BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *createCmps = [calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *nowCmps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return createCmps.year == nowCmps.year;
}

/**
 *  判断是否为昨天
 */
-(BOOL)isYesterday
{
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    
    NSDate *date = [fmt dateFromString:dateStr];
    now = [fmt dateFromString:nowStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit  unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    // 计算两个日期的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:now options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}

/**
 *  判断是否为今天
 */
-(BOOL)isToday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:[NSDate date]];
    
    return [dateStr isEqualToString:nowStr];
}

-(NSDate *)removeHourMinAndSec
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [fmt stringFromDate:self];
    NSDate *date = [fmt dateFromString:dateStr];
    return date;
}
@end
