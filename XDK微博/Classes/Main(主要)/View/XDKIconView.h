//
//  XDKIconView.h
//  XDK微博
//
//  Created by 徐宽阔 on 15/7/18.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XDKUser;
@interface XDKIconView : UIImageView
/** User */
@property (nonatomic,strong) XDKUser  *user;
@end
