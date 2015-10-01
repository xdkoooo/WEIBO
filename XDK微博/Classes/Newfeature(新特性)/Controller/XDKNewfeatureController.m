//
//  XDKNewfeatureController.m
//  XDK微博
//
//  Created by 徐宽阔 on 15/6/7.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import "XDKNewfeatureController.h"
#import "XDKTabBarViewController.h"
#define XDKNewfeatureCount 4

@interface XDKNewfeatureController() <UIScrollViewDelegate>
@property (nonatomic,weak)UIPageControl *pageControl;
@end
@implementation XDKNewfeatureController
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.创建一个scrollView，显示所有新特性图片
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    // 2.添加图片到scrollView中
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;
    for (int i = 0; i < XDKNewfeatureCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.width = scrollW;
        imageView.height = scrollH;
        imageView.x = i * scrollW;
        imageView.y = 0;
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"new_feature_%d",i + 1]];
        imageView.image = image;
        [scrollView addSubview:imageView];
        
        if (i == XDKNewfeatureCount - 1) {
            [self setupLastImageView:(UIImageView *)imageView];
        }
    }
    
    // 3.设置scrollView的其他属性
    scrollView.contentSize = CGSizeMake(scrollW * XDKNewfeatureCount, 0);
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    // 4.添加pageControl：分页，展示目前看的是第几页
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = XDKNewfeatureCount;
    pageControl.currentPageIndicatorTintColor = XDKColor(253, 98, 42);
    pageControl.pageIndicatorTintColor = XDKColor(189, 189, 189);
    
//    pageControl.width = 100;
//    pageControl.height = 50;
//    pageControl.backgroundColor = [UIColor redColor];
    pageControl.centerX = scrollView.width * 0.5;
    pageControl.centerY = scrollView.height - 50;
    self.pageControl = pageControl;
    [self.view addSubview:pageControl];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(page + 0.5);
}

-(void)setupLastImageView:(UIImageView *)imageView
{
    imageView.userInteractionEnabled = YES;
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    shareBtn.width = 200;
    shareBtn.height = 30;
    shareBtn.centerX = self.view.width * 0.5;
    shareBtn.centerY = self.view.height * 0.65;
    [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:shareBtn];
    
//    shareBtn.titleEdgeInsets
//    shareBtn.imageEdgeInsets

    //    EdgeInsets:自切
    //    contentEdgeInsets  影响按钮内部的所有内容（里面的imageView 和 titleLabel）
    //    titleEdgeInsets    只影响按钮内部的titleLabel
    //    imageEdgeInsets    只影响按钮内部的imageView
    
    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    shareBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    
    startBtn.size = startBtn.currentBackgroundImage.size;
    startBtn.centerX = shareBtn.centerX;
    startBtn.centerY = self.view.height * 0.75;
    
    [imageView addSubview:startBtn];
    
}

-(void)shareClick:(UIButton *)shareBtn
{
    shareBtn.selected = !shareBtn.isSelected;
}

-(void)startClick
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[XDKTabBarViewController alloc] init];
}
@end
