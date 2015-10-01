//
//  XDKStatusPhotosView.m
//  XDK微博
//
//  Created by 徐宽阔 on 15/7/18.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import "XDKStatusPhotosView.h"
#import "MJExtension.h"
#import "XDKPhoto.h"
#import "XDKStatusPhotoView.h"

#define XDKStatusPhotoWH 70
#define XDKStatusPhotoMargin 10

#define XDKMaxCols(count) ((count==4)? 2:3)

@implementation XDKStatusPhotosView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}
-(void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    int photoCount = (int)photos.count;
    
    while (self.subviews.count < photos.count) {
        XDKStatusPhotoView *imageView = [[XDKStatusPhotoView alloc] init];
        [self addSubview:imageView];
    }
    
    for (int i = 0; i<self.subviews.count; i++) {
        XDKStatusPhotoView *imageView = self.subviews[i];
        
        if (i < photoCount) {
            imageView.photo = self.photos[i];
            imageView.hidden = NO;
        }else{
            imageView.hidden = YES;
        }
        
    }
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    int count = (int)self.photos.count;
    int maxCols = XDKMaxCols(count);
    int col = 0;
    int row = 0;
    for (int i = 0; i < count; i++) {
        XDKStatusPhotoView *imageView = self.subviews[i];
        col = i % maxCols;
        row = i / maxCols;
        CGFloat w = XDKStatusPhotoWH;
        CGFloat h = XDKStatusPhotoWH;
        CGFloat x = col * (XDKStatusPhotoWH + XDKStatusPhotoMargin);
        CGFloat y = row * (XDKStatusPhotoMargin + XDKStatusPhotoWH);
        imageView.frame = CGRectMake(x, y, w, h);
    }
}

+(CGSize)sizeWithCount:(int)count
{
    int maxCols = XDKMaxCols(count);
    int cols = (count >= maxCols) ? maxCols : count;
    CGFloat photsW = XDKStatusPhotoWH * cols + (cols - 1) * XDKStatusPhotoMargin;
    int rows = (count + maxCols - 1) / maxCols;
    CGFloat photosH = XDKStatusPhotoWH * rows +  (rows - 1) * XDKStatusPhotoMargin;
    return CGSizeMake(photsW, photosH);
}


@end
