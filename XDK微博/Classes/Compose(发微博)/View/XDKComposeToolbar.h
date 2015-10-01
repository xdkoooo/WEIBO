//
//  XDKComposeToolbar.h
//  XDK微博
//
//  Created by 徐宽阔 on 15/7/24.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XDKComposeToolbar;

typedef enum {
    XDKComposeToolbarButtonTypeCamera,
    XDKComposeToolbarButtonTypePicture,
    XDKComposeToolbarButtonTypeMention, // @
    XDKComposeToolbarButtonTypeTrend, // #
    XDKComposeToolbarButtonTypeEmotion
} XDKComposeToolbarButtonType;


@protocol XDKComposeToolbarDelegate <NSObject>

@optional

-(void)composeToolbar:(XDKComposeToolbar *)toolbar didClickButton:(XDKComposeToolbarButtonType)buttonType;

@end

@interface XDKComposeToolbar : UIView


@property (nonatomic,weak)id<XDKComposeToolbarDelegate>  delegate;
@end
