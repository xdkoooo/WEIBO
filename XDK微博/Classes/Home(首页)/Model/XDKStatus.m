//
//  XDKStatus.m
//  XDK微博
//
//  Created by 徐宽阔 on 15/6/26.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import "XDKStatus.h"
#import "MJExtension.h"
#import "XDKPhoto.h"
@implementation XDKStatus

// 通知数组中的对象类型
-(NSDictionary *)objectClassInArray
{
    return @{@"pic_urls":[XDKPhoto class]};
}



/**
 *  重写get方法
 *
 *  @return set方法在读取数据时调用一次，不能实时刷新数据
 */
-(NSString *)created_at
{
    // 真机调试，转换欧美时间，需要设置locale
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 转换格式
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    fmt.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    
    // 微博的创建日期
    NSDate *createDate = [fmt dateFromString:_created_at];
    // 当前日期
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit  unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |  NSCalendarUnitHour |NSCalendarUnitMinute |  NSCalendarUnitSecond;
    // 计算两个日期的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:createDate toDate:now options:0];
    // 获得某个日期的年月日时分秒
//    NSDateComponents *createCmps = [calendar components:unit fromDate:createDate];
//    NSDateComponents *nowCmps = [calendar components:unit fromDate:now];
    
    if ([createDate isThisYear]) { //今年
        if ([createDate isYesterday]) { //昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        }else if ([createDate isToday]){ //今天
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时前",cmps.hour];
            }else if (cmps.minute >= 1){
                return [NSString stringWithFormat:@"%ld分钟前",cmps.minute];
            }else{
                return @"刚刚";
            }
        }else{ //其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:createDate];
        }
    }else{ //非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }
}



//-(NSString *)source
//{
//    /**
//     *  <a href="http://app.weibo.com/t/feed/1tqBja" rel="nofollow">360安全浏览器</a>
//     */
//}

-(void)setSource:(NSString *)source
{
    _source = source;
    if ( [source rangeOfString:@">"].location == NSNotFound) return;
    NSRange range;
    range.location = [source rangeOfString:@">"].location + 1;
    range.length = [source rangeOfString:@"</"].location - range.location;
    source = [source substringWithRange:range];
    _source = [NSString stringWithFormat:@"来自 %@",source];
}

@end










