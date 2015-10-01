//
//  UIWindow+XDKExtension.m
//  XDK微博
//
//  Created by 徐宽阔 on 15/6/22.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import "UIWindow+XDKExtension.h"
#import "XDKTabBarViewController.h"
#import "XDKNewfeatureController.h"

@implementation UIWindow (XDKExtension)
-(void)switchRootViewController
{
    // 上一次的使用版本（存储在沙盒中的版本号）
    NSString *key = @"CFBundleVersion";
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    // 当前软件的版本号（从Info.plist中获得）CFBundleVersion
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    if ([lastVersion isEqualToString:currentVersion]) {
        self.rootViewController = [[XDKTabBarViewController alloc] init];
    }else{
        self.rootViewController = [[XDKNewfeatureController alloc] init];
        // 将当前版本号存进沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
@end
