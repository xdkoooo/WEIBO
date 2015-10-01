//
//  XDKStatusToolBar.h
//  XDK微博
//
//  Created by 徐宽阔 on 15/7/15.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XDKStatus;
@interface XDKStatusToolBar : UIView

+(instancetype)toolbar;
/** status */
@property (nonatomic,strong) XDKStatus  *status;
@end
