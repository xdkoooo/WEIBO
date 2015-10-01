//
//  XDKDropdownMenu.h
//  XDK微博
//
//  Created by 徐宽阔 on 15/6/3.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XDKDropdownMenu;

@protocol XDKDropdownMenuDelegate <NSObject>

@optional

-(void)dropdownMenuDidDisMiss:(XDKDropdownMenu *)menu;

-(void)dropdownMenuDidShow:(XDKDropdownMenu *)menu;

@end

@interface XDKDropdownMenu : UIView
/**
 *  具体内容
 */
@property (nonatomic,strong)UIView *content;
@property (nonatomic,strong)UIViewController *contentController;

@property (nonatomic,weak) id<XDKDropdownMenuDelegate> delegate;

+(instancetype)menu;

-(void)showFrom:(UIView *)from;

-(void)disMiss;
@end
