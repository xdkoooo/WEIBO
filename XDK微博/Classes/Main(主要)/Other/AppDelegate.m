//
//  AppDelegate.m
//  XDK微博
//
//  Created by 徐宽阔 on 15/5/28.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import "AppDelegate.h"
#import "XDKOAuthViewController.h"
#import "XDKAccountTool.h"
#import "UIWindow+XDKExtension.h"
#import "SDWebImageManager.h"


/**
 * 
 git仓库初始化方法：打开到文件夹
                  git init
                  git add .
                  git commit -m "初始化"
 git reflog :查看版本号
 git reset --hard +版本号  :回到某个版本
 git config alias.rst 'reset --hard'   == git rst +版本号 ：取别名(在当前文件夹的config配置文件中)
 */


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 1.创建窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    // 2.显示窗口
    [self.window makeKeyAndVisible];

    
    // 3.设置根控制器
    XDKAccount *account = [XDKAccountTool account];
    
    if (account) {
        [self.window switchRootViewController];

    }else{
        self.window.rootViewController = [[XDKOAuthViewController alloc] init];
    }
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    //进入后台保持程序继续运行
    UIBackgroundTaskIdentifier task = [application beginBackgroundTaskWithExpirationHandler:^{
        // 关闭时间不可控
        [application endBackgroundTask:task];
    }];
    
    // 循环播放0kb的mp3文件
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
    
    // 1.取消下载
    [mgr cancelAll];
    // 2.清楚所有缓存图片
    [mgr.imageCache clearMemory];
}

@end
