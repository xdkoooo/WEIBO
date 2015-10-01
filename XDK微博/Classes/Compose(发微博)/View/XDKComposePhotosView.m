//
//  XDKComposePhotosView.m
//  XDK微博
//
//  Created by 徐宽阔 on 15/7/24.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import "XDKComposePhotosView.h"

@interface XDKComposePhotosView()

@end

@implementation XDKComposePhotosView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _photos = [NSMutableArray array];
    }
    return self;
}

-(void)addPhoto:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    [self addSubview:imageView];
    
    [self.photos addObject:image];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    NSUInteger count = self.subviews.count;
    int maxCols = 4;
    int col = 0;
    int row = 0;
    CGFloat imageWH = 70;
    CGFloat margin = 10;
    for (int i = 0; i < count; i++) {
        UIImageView *imageView = self.subviews[i];
        col = i % maxCols;
        row = i / maxCols;
        CGFloat x = col * (imageWH + margin);
        CGFloat y = row * (imageWH + margin);
        imageView.frame = CGRectMake(x, y, imageWH,imageWH);
    }

}
@end
