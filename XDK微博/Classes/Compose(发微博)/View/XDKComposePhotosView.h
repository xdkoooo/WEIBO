//
//  XDKComposePhotosView.h
//  XDK微博
//
//  Created by 徐宽阔 on 15/7/24.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XDKComposePhotosView : UIView
-(void)addPhoto:(UIImage *)image;
//-(NSArray *)photos;
/** photos */
@property (nonatomic,strong,readonly) NSMutableArray  *photos;
@end
