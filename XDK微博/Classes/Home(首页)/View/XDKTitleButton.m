//
//  XDKTitleButton.m
//  XDK微博
//
//  Created by 徐宽阔 on 15/6/26.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import "XDKTitleButton.h"
#import "XDKAccountTool.h"
#define XDKmargin 5

@implementation XDKTitleButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        [self setBackgroundColor:[UIColor redColor]];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
        
        // 设置图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
    
}

// 目的：想在系统计算和设置完按钮的尺寸后，再修改一下尺寸
/**
 *  重写setFrame：方法的目的：拦截设置按钮尺寸的过程
 */
-(void)setFrame:(CGRect)frame
{
    frame.size.width += XDKmargin;
    [super setFrame:frame];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
        
//    NSLog(@"%@,%@",NSStringFromCGRect(self.titleLabel.frame),NSStringFromCGRect(self.imageView.frame));

//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSFontAttributeName] = self.titleLabel.font;
//    CGFloat titleWidth = [self.titleLabel.text sizeWithAttributes:attrs].width;
    
    // 1.计算titleLabel的frame
    self.titleLabel.x = self.imageView.x;
    
//    
//    // 2.计算imageView的frame
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + XDKmargin;
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
}

-(void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self sizeToFit];
}

@end
