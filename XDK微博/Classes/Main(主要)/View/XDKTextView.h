//
//  XDKTextView.h
//  XDK微博
//
//  Created by 徐宽阔 on 15/7/24.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XDKTextView : UITextView
/** placeholder */
@property (nonatomic,copy)NSString * placeholder;
/** placeholderColor */
@property (nonatomic,strong) UIColor  *placeholderColor;
@end
