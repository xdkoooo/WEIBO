//
//  XDKStatusToolBar.m
//  XDK微博
//
//  Created by 徐宽阔 on 15/7/15.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import "XDKStatusToolBar.h"
#import "XDKStatus.h"

@interface XDKStatusToolBar()

@property (nonatomic,weak)UIButton * repostBtn;
@property (nonatomic,weak)UIButton * commentBtn;
@property (nonatomic,weak)UIButton * attitudeBtn;

@end

@implementation XDKStatusToolBar

+(instancetype)toolbar
{
    return [[self alloc] init];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
       self.repostBtn = [self setupBtnWithTitle:@"转发" imageName:@"timeline_icon_retweet"];
       self.commentBtn = [self setupBtnWithTitle:@"评论" imageName:@"timeline_icon_comment"];
       self.attitudeBtn = [self setupBtnWithTitle:@"赞" imageName:@"timeline_icon_unlike"];
    }
    return self;
}


-(UIButton *)setupBtnWithTitle:(NSString *)title imageName:(NSString *)imagename
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imagename] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
    [self addSubview:btn];
    return btn;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat btnW = self.width / 3;
    CGFloat btnH = self.height;
    for (int i=0; i<3; i++) {
        UIButton *btn = self.subviews[i];
        CGFloat x = i * btnW;
        CGFloat y = 0;
        btn.frame = CGRectMake(x, y, btnW, btnH);
    }
}

-(void)setStatus:(XDKStatus *)status
{
    _status = status;
    [self setupBtncount:status.reposts_count btn:self.repostBtn title:@"转发"];
    [self setupBtncount:status.comments_count btn:self.commentBtn title:@"评论"];
    [self setupBtncount:status.attitudes_count btn:self.attitudeBtn title:@"赞"];
}

-(void)setupBtncount:(int)count btn:(UIButton *)btn title:(NSString *)title
{
    if (count) {
        if (count < 10000) {
            title = [NSString stringWithFormat:@"%d",count];
        }else{
            double wan = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万",wan];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
    }
    [btn setTitle:title forState:UIControlStateNormal];
}
@end
