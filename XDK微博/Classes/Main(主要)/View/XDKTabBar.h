//
//  XDKTabBar.h
//  XDK微博
//
//  Created by 徐宽阔 on 15/6/4.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XDKTabBar;
@protocol XDKTabBarDelegate <UITabBarDelegate>

@optional

-(void)tabBarDidClickPlusButton:(XDKTabBar *)tabbar;

@end


@interface XDKTabBar : UITabBar

@property (nonatomic,weak) id<XDKTabBarDelegate> delegate;
@end
