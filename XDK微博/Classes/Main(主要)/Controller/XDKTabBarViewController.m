//
//  XDKTabBarViewController.m
//  XDK微博
//
//  Created by 徐宽阔 on 15/5/30.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import "XDKTabBarViewController.h"
#import "XDKHomeViewController.h"
#import "XDKMessageCenterViewController.h"
#import "XDKDiscoverViewController.h"
#import "XDKProfileViewController.h"
#import "XDKNavigationController.h"
#import "XDKTabBar.h"
#import "XDKComposeViewController.h"

@interface XDKTabBarViewController () <XDKTabBarDelegate>
@end

@implementation XDKTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.初始化子控制器
    
    XDKHomeViewController *home = [[XDKHomeViewController alloc] init];
    [self addChildVc:home title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    XDKMessageCenterViewController *message = [[XDKMessageCenterViewController alloc] init];
    [self addChildVc:message title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    XDKDiscoverViewController *discover = [[XDKDiscoverViewController alloc] init];
    [self addChildVc:discover title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    XDKProfileViewController *me = [[XDKProfileViewController alloc] init];
    [self addChildVc:me title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
    XDKTabBar *tabbar = [[XDKTabBar alloc] init];
//    tabbar.delegate = self;
    [self setValue:tabbar forKey:@"tabBar"];
}

-(void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字和图片
//    childVc.tabBarItem.title = title;
//    childVc.navigationItem.title = title;
    
    childVc.title = title;// 同时设置tabBar、navigationBar的文字
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    // 声明：这张图片以后按照原始的样子显示出来，不要渲染成其他颜色（比如蓝色）
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    if (iOS7) {
        childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }else{
        childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    }
    
    // 设置文字样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = XDKColor(123, 123, 123);
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
//    childVc.view.backgroundColor = XDKRandomColor;
    XDKNavigationController *nav = [[XDKNavigationController alloc]initWithRootViewController:childVc];
    
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:childVc];
    
    [self addChildViewController:nav];
}

#pragma mark  XDKTabBarDelegate代理协议
-(void)tabBarDidClickPlusButton:(XDKTabBar *)tabbar
{
    XDKComposeViewController *vc = [[XDKComposeViewController alloc] init];
    XDKNavigationController *nav = [[XDKNavigationController alloc] initWithRootViewController:vc];
    
    [self presentViewController:nav animated:YES completion:nil];
}




@end
