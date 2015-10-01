//
//  XDKTextView.m
//  XDK微博
//
//  Created by 徐宽阔 on 15/7/24.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import "XDKTextView.h"

@implementation XDKTextView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [XDKNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

-(void)textDidChange
{
    // 在下一次消息循环时刻调用 drawRect
    [self setNeedsDisplay];
}


// 重写下列方法，监听属性的改变
-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

-(void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay];
}

-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect {
    if (self.hasText) return;
    
    CGFloat x = 5;
    CGFloat y = 8;
    CGFloat w = self.width - 2 * x;
    CGFloat h = self.height;
    CGRect placeholderRect = CGRectMake(x, y, w, h);
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor?self.placeholderColor:[UIColor grayColor];
    [self.placeholder drawInRect:placeholderRect withAttributes:attrs];
}

-(void)dealloc
{
    [XDKNotificationCenter removeObserver:self];
}


@end
