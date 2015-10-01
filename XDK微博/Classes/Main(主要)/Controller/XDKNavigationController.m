//
//  XDKNavigationController.m
//  XDK微博
//
//  Created by 徐宽阔 on 15/6/1.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import "XDKNavigationController.h"
#import "UIBarButtonItem+Extension.h"

@interface XDKNavigationController ()

@end

@implementation XDKNavigationController

+(void)initialize
{
//    [UINavigationBar appearance];  设置导航栏文字
    
    // 设置整个项目所有item的主题样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    // 设置普通样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置不可用样式
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.7];
    disableTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

/**
 *  重写这个方法的目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ( self.viewControllers.count >0 ) {    //push进来的不是跟控制器
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"navigationbar_back" highImage:@"navigationbar_back_hightlighted"];
        
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"navigationbar_more" highImage:@"navigationbar_more_hightlighted"];
        
    }
    
    [super pushViewController:viewController animated:NO];
}

-(void)back
{
    [self popViewControllerAnimated:NO];
}

-(void)more
{
    [self popToRootViewControllerAnimated:NO];
}

@end
