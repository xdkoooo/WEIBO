//
//  XDKDropdownMenu.m
//  XDK微博
//
//  Created by 徐宽阔 on 15/6/3.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import "XDKDropdownMenu.h"

@interface XDKDropdownMenu()
/**
 *  显示具体内容的容器
 */
@property (nonatomic,weak)UIImageView *containerView;

@end

@implementation XDKDropdownMenu
/**
 *  重写set方法
 *
 *  @param content 调用containerView的懒加载
 */
-(void)setContent:(UIView *)content
{
    _content = content;
    
    // 调整内容的位置
    content.x = 10;
    content.y = 15;
    // 调整内容的宽度
//    content.width = self.containerView.width - 2 * content.x;
    
    // 设置灰色容器的尺寸
    // 宽度
    self.containerView.width = CGRectGetMaxX(content.frame) + 10;
    // 高度
    self.containerView.height = CGRectGetMaxY(content.frame) + 11;

    [self.containerView addSubview:content];
}


-(void)setContentController:(UIViewController *)contentController
{
    _contentController = contentController;
    self.content = contentController.view;
}

-(UIImageView *)containerView
{
    if (!_containerView) {
        UIImageView *containerView = [[UIImageView alloc] init];
        containerView.image = [UIImage imageNamed:@"popover_background"];
        containerView.userInteractionEnabled = YES;
//        containerView.width = 217;
//        containerView.height = 217;
        [self addSubview:containerView];
        self.containerView = containerView;
    }
    return _containerView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

+(instancetype)menu
{
    return [[self alloc] init];
}

-(void)showFrom:(UIView *)from
{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    self.frame = window.frame;
    
    // 调整灰色图片的位置
    // 默认情况下，frame是以父控件左上角为坐标原点
    // 可以转换坐标系原点，改变frame的参照点
    CGRect newFrame = [from convertRect:from.bounds toView:window];
//    CGRect newFrame = [from.superview convertRect:from.frame toView:window];
    self.containerView.y = CGRectGetMaxY(newFrame);
    
//    self.containerView.x = (self.width - self.containerView.width) * 0.5;
    
    self.containerView.centerX = CGRectGetMidX(newFrame);
    
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidShow:)]) {
        [self.delegate dropdownMenuDidShow:self];
    }
    
}

-(void)disMiss
{
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidDisMiss:)]) {
        [self.delegate dropdownMenuDidDisMiss:self];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self disMiss];
}


@end
