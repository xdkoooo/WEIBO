//
//  XDKComposeToolbar.m
//  XDK微博
//
//  Created by 徐宽阔 on 15/7/24.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import "XDKComposeToolbar.h"

@implementation XDKComposeToolbar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        
        [self setUpbtnsWithImage:@"compose_camerabutton_background" highlightImage:@"compose_camerabutton_background_highlighted" type:XDKComposeToolbarButtonTypeCamera];
        [self setUpbtnsWithImage:@"compose_toolbar_picture" highlightImage:@"compose_toolbar_picture_highlighted" type:XDKComposeToolbarButtonTypePicture];
        [self setUpbtnsWithImage:@"compose_mentionbutton_background" highlightImage:@"compose_mentionbutton_background_highlighted" type:XDKComposeToolbarButtonTypeMention];
        [self setUpbtnsWithImage:@"compose_trendbutton_background" highlightImage:@"compose_trendbutton_background_highlighted" type:XDKComposeToolbarButtonTypeTrend];
        [self setUpbtnsWithImage:@"compose_emoticonbutton_background" highlightImage:@"compose_emoticonbutton_background_highlighted" type:XDKComposeToolbarButtonTypeEmotion];
    }
    return self;
}

-(void)setUpbtnsWithImage:(NSString *)image highlightImage:(NSString *)highlightImage type:(XDKComposeToolbarButtonType)type
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlightImage] forState:UIControlStateHighlighted];
    btn.tag = type;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}

-(void)layoutSubviews
{
    NSUInteger count = self.subviews.count;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = self.width / count;
    CGFloat h = self.height;
    
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        x = i * w;
        btn.frame = CGRectMake(x, y, w, h);
    }
}

-(void)btnClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(composeToolbar:didClickButton:)]) {
        [self.delegate composeToolbar:self didClickButton:(XDKComposeToolbarButtonType)btn.tag];
    }
}

@end
