//
//  XDKTabBar.m
//  XDK微博
//
//  Created by 徐宽阔 on 15/6/4.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import "XDKTabBar.h"

@interface XDKTabBar()

@property (nonatomic,weak) UIButton *plusBtn;

@end
@implementation XDKTabBar


- (instancetype)init
{
    self = [super init];
    if (self) {
        UIButton *plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        plusBtn.size = plusBtn.currentBackgroundImage.size;
        
        self.plusBtn = plusBtn;
        [plusBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:plusBtn];
        
    }
    return self;
}


-(void)plusClick
{
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegate tabBarDidClickPlusButton:self];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.plusBtn.centerX = self.width * 0.5;
    self.plusBtn.centerY = self.height * 0.5;
    
    CGFloat tabbarButtonW = self.width / 5 ;
    CGFloat tabbarButtonIndex = 0;
    
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            child.width = tabbarButtonW;
            child.x = tabbarButtonIndex * tabbarButtonW;
            tabbarButtonIndex ++;
            
            if (tabbarButtonIndex == 2) {
                tabbarButtonIndex ++;
            }
        }
        
    }
}

@end
