//
//  XDKAccountTool.h
//  XDK微博
//
//  Created by 徐宽阔 on 15/6/21.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XDKAccount.h"
@interface XDKAccountTool : NSObject
+(void)saveAccount:(XDKAccount *)account;
+(XDKAccount *)account;
@end
