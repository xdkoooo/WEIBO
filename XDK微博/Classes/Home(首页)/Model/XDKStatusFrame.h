//
//  XDKStatusFrame.h
//  XDK微博
//
//  Created by 徐宽阔 on 15/7/10.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <UIKit/UIKit.h>

// 昵称字体
#define XDKStatusCellNameFont [UIFont systemFontOfSize:15]
// 时间字体
#define XDKStatusCellTimeFont [UIFont systemFontOfSize:12]
// 来源字体
#define XDKStatusCellSourceFont XDKStatusCellTimeFont
// 正文字体
#define XDKStatusCellContentFont [UIFont systemFontOfSize:14]
// 被转发微博正文字体
#define XDKStatusCellRetweetContentFont [UIFont systemFontOfSize:13]
// cell之间的间距
#define XDKStatusCellMargin 15

#define XDKStatusCellBorderW 10


@class XDKStatus;
@interface XDKStatusFrame : NSObject

/** 原创微博*/
/** XDKStatus */
@property (nonatomic,strong) XDKStatus  *status;

/** originalFrame */
@property (nonatomic,assign)CGRect originalFrame;

/** iconFrame */
@property (nonatomic,assign)CGRect iconFrame;

/** nameFrame */
@property (nonatomic,assign)CGRect nameFrame;

/** vipFrame */
@property (nonatomic,assign)CGRect vipFrame;

/** sourceFrame */
@property (nonatomic,assign)CGRect sourceFrame;

/** textFrame */
@property (nonatomic,assign)CGRect textFrame;

/** photoFrame */
@property (nonatomic,assign)CGRect photosFrame;

/** timeFrame */
@property (nonatomic,assign)CGRect timeFrame;

/** 转发微博*/
@property (nonatomic,assign)CGRect retweetContainerFrame;
@property (nonatomic,assign)CGRect retweetphotosFrame;
@property (nonatomic,assign)CGRect retweetContentLabelFrame;

/** height */
@property (nonatomic,assign)CGFloat cellHeight;

/** 工具条*/
@property (nonatomic,assign)CGRect toolBarFrame;

@end
