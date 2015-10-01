//
//  XDKSearchBar.m
//  XDK微博
//
//  Created by 徐宽阔 on 15/6/2.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import "XDKSearchBar.h"

@implementation XDKSearchBar


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 创建搜索框对象
        self.font = [UIFont systemFontOfSize:15];
        self.placeholder = @"请输入搜索条件";
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        
        // 设置左边放大镜图标
        UIImageView *searchIcon = [[UIImageView alloc] init];
        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        searchIcon.width = 30;
        searchIcon.height = 30;
        
        searchIcon.contentMode = UIViewContentModeCenter;// 设置图片在view中居中
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}


+(instancetype)searchBar
{
    return [[self alloc] init];
}

@end
