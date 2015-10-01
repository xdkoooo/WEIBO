//
//  XDKStatusFrame.m
//  XDK微博
//
//  Created by 徐宽阔 on 15/7/10.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import "XDKStatusFrame.h"
#import "XDKUser.h"
#import "XDKStatus.h"
#import "XDKStatusPhotosView.h"

@implementation XDKStatusFrame

-(void)setStatus:(XDKStatus *)status
{
    _status = status;
    XDKUser *user = status.user;
    
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat iconX = XDKStatusCellBorderW;
    CGFloat iconY = XDKStatusCellBorderW;
    CGFloat iconWH = 30;
    self.iconFrame = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    /** 昵称 */
    CGFloat nameX = CGRectGetMaxX(self.iconFrame) + XDKStatusCellBorderW;
    CGFloat nameY = iconY;
    CGSize nameSize = [user.name sizeWithTextFont:XDKStatusCellNameFont];
    self.nameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    /** 会员图标 */
    if (user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameFrame) + XDKStatusCellBorderW;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = 14;
        self.vipFrame = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    /** 时间 */
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameFrame) + XDKStatusCellBorderW;
    CGSize timeSize = [status.created_at sizeWithTextFont:XDKStatusCellTimeFont];
    self.timeFrame = (CGRect){{timeX, timeY}, timeSize};
    
    /** 来源 */
    CGFloat sourceX = CGRectGetMaxX(self.timeFrame) + XDKStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithTextFont:XDKStatusCellSourceFont];
    self.sourceFrame = (CGRect){{sourceX, sourceY}, sourceSize};
    
    /** 正文 */
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconFrame), CGRectGetMaxY(self.timeFrame)) + XDKStatusCellBorderW;
    CGFloat maxW = cellW - 2 * contentX;
    CGSize contentSize = [status.text sizeWithTextFont:XDKStatusCellContentFont maxW:maxW];
    self.textFrame = (CGRect){{contentX, contentY}, contentSize};
    
    /** 配图 */
    CGFloat originalH = 0;
    if (status.pic_urls.count) {
        CGFloat photoX = contentX;
        CGFloat photoY = CGRectGetMaxY(self.textFrame) + XDKStatusCellBorderW;
        CGSize photoSize = [XDKStatusPhotosView sizeWithCount:(int)status.pic_urls.count];
        self.photosFrame = (CGRect){{photoX,photoY},photoSize};
        
        originalH = CGRectGetMaxY(self.photosFrame) + XDKStatusCellBorderW;
    }else{
        originalH = CGRectGetMaxY(self.textFrame) + XDKStatusCellBorderW;
    }
    
    
    /** 原创微博整体 */
    CGFloat originalX = 0;
    CGFloat originalY = XDKStatusCellMargin;
    CGFloat originalW = cellW;
    self.originalFrame = CGRectMake(originalX, originalY, originalW, originalH);
    
    
    /** 被转发微博*/
    CGFloat toolBarY = 0;
    if (status.retweeted_status) {
        XDKStatus *retweet_status = status.retweeted_status;
        XDKUser *retweet_status_user = retweet_status.user;
        
        // 被转发微博正文
        CGFloat retweetNameLabelX = XDKStatusCellBorderW;
        CGFloat retweetNameLabeY = XDKStatusCellBorderW;
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweet_status_user.name,retweet_status.text];
        CGSize retweetNameSize = [retweetContent sizeWithTextFont:XDKStatusCellRetweetContentFont maxW:maxW];
        self.retweetContentLabelFrame = (CGRect){{retweetNameLabelX, retweetNameLabeY}, retweetNameSize};
       
        CGFloat retweetH = 0;
        if (retweet_status.pic_urls.count) {
            // 被转发微博配图
            CGFloat retweetphotoX = retweetNameLabelX;
            CGFloat retweetphotoY = CGRectGetMaxY(self.retweetContentLabelFrame) + XDKStatusCellBorderW;
            CGSize retweetphotoSize = [XDKStatusPhotosView sizeWithCount:(int)retweet_status.pic_urls.count];
            self.retweetphotosFrame = (CGRect){{retweetphotoX, retweetphotoY},retweetphotoSize};
            
            retweetH = CGRectGetMaxY(self.retweetphotosFrame) + XDKStatusCellBorderW;
        }else{
            retweetH = CGRectGetMaxY(self.retweetContentLabelFrame) + XDKStatusCellBorderW;
        }
        
        /** 被转发微博整体 */
        CGFloat retweetX = 0;
        CGFloat retweetY = CGRectGetMaxY(self.originalFrame);
        CGFloat retweetW = cellW;
        self.retweetContainerFrame = CGRectMake(retweetX, retweetY, retweetW, retweetH);
        
        toolBarY = CGRectGetMaxY(self.retweetContainerFrame);
    }else{
        toolBarY = CGRectGetMaxY(self.originalFrame);
    }
    
    /** 工具条*/
    CGFloat toolBarX = 0;
    CGFloat toolBarW = cellW;
    CGFloat toolBarH = 35;
    self.toolBarFrame = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
//    self.cellHeight = CGRectGetMaxY(self.toolBarFrame) + XDKStatusCellMargin;
    self.cellHeight = CGRectGetMaxY(self.toolBarFrame);
}
@end
