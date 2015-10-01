//
//  XDKHomeCell.m
//  XDK微博
//
//  Created by 徐宽阔 on 15/7/10.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import "XDKHomeCell.h"
#import "XDKStatusFrame.h"
#import "XDKUser.h"
#import "XDKStatus.h"
//SDWebImage,缓存图片
#import "UIImageView+WebCache.h"
#import "XDKPhoto.h"
#import "XDKStatusToolBar.h"
#import "XDKStatusPhotosView.h"
#import "XDKIconView.h"

@interface XDKHomeCell()
/** 原创微博*/
@property (nonatomic,weak)UIView * originalContainer;
@property (nonatomic,weak)XDKIconView * iconImageView;
@property (nonatomic,weak)UILabel * nameLabel;
@property (nonatomic,weak)UIImageView * vipImageView;
@property (nonatomic,weak)UILabel * sourceLabel;
@property (nonatomic,weak)UILabel * text_label;
@property (nonatomic,weak)UILabel * timeLabel;
@property (nonatomic,weak)XDKStatusPhotosView * photosView;

/** 转发微博*/
@property (nonatomic,weak)UIView * retweetContainer;
@property (nonatomic,weak)XDKStatusPhotosView * retweetphotosView;
@property (nonatomic,weak)UILabel * retweetContentLabel;

/** 工具条*/
@property (nonatomic,weak)XDKStatusToolBar * toolBar;

@end

@implementation XDKHomeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        // 点击cell时候不会变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupOriginalStatus];
        
        [self setupRetweetStatus];
        
        [self setupToolBar];
    }
    return self;
}

//-(void)setFrame:(CGRect)frame
//{
//    frame.origin.y += XDKStatusCellMargin;
//    [super setFrame:frame];
//}

-(void)setupOriginalStatus
{
    // 原创微博整体
    UIView *originalContainer = [[UIView alloc] init];
    self.originalContainer = originalContainer;
    originalContainer.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:originalContainer];
    
    // 头像
    XDKIconView * iconImageView = [[XDKIconView alloc] init];
    self.iconImageView = iconImageView;
    [originalContainer addSubview:iconImageView];
    
    // 昵称
    UILabel * nameLabel = [[UILabel alloc] init];
    self.nameLabel = nameLabel;
    nameLabel.font = XDKStatusCellNameFont;
    [originalContainer addSubview:nameLabel];
    
    // 会员图标
    UIImageView * vipImageView = [[UIImageView alloc] init];
    self.vipImageView = vipImageView;
    vipImageView.contentMode = UIViewContentModeCenter;
    [originalContainer addSubview:vipImageView];
    
    // 来源
    UILabel * sourceLabel = [[UILabel alloc] init];
    self.sourceLabel = sourceLabel;
    sourceLabel.font = XDKStatusCellSourceFont;
    [originalContainer addSubview:sourceLabel];
    
    // 正文
    UILabel * text_label = [[UILabel alloc] init];
    self.text_label = text_label;
    text_label.numberOfLines = 0;
    text_label.font = XDKStatusCellContentFont;
    [originalContainer addSubview:text_label];
    
    // 时间
    UILabel * timelabel = [[UILabel alloc] init];
    self.timeLabel = timelabel;
    timelabel.font = XDKStatusCellTimeFont;
    [originalContainer addSubview:timelabel];
    
    // 配图
    XDKStatusPhotosView * photosView = [[XDKStatusPhotosView alloc] init];
    self.photosView = photosView;
    [originalContainer addSubview:photosView];

}


-(void)setupRetweetStatus
{
    // 转发微博整体
    UIView *retweetContainer = [[UIView alloc] init];
    self.retweetContainer = retweetContainer;
    retweetContainer.backgroundColor = XDKColor(247, 247, 247);
    [self.contentView addSubview:retweetContainer];
    
    // 头像
    XDKStatusPhotosView * retweetphotosView = [[XDKStatusPhotosView alloc] init];
    self.retweetphotosView = retweetphotosView;
    [retweetContainer addSubview:retweetphotosView];
    
    // 昵称
    UILabel * retweetContentLabel = [[UILabel alloc] init];
    self.retweetContentLabel = retweetContentLabel;
    retweetContentLabel.font = XDKStatusCellRetweetContentFont;
    retweetContentLabel.numberOfLines = 0;
    [retweetContainer addSubview:retweetContentLabel];

}

-(void)setupToolBar
{
    /** 工具条*/
    XDKStatusToolBar *toolBar = [XDKStatusToolBar toolbar];
    self.toolBar = toolBar;
    [self.contentView addSubview:toolBar];
}

-(void)setStatusFrame:(XDKStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    XDKStatus *status = statusFrame.status;
    XDKUser *user = status.user;
    
    /** 原创微博*/
    // 原创微博整体
    self.originalContainer.frame = _statusFrame.originalFrame;

    // 头像
    self.iconImageView.frame = _statusFrame.iconFrame;
    self.iconImageView.user = user;
    
    // 会员图标
    if (user.isVip) {
        self.vipImageView.hidden = NO;
        self.vipImageView.frame = _statusFrame.vipFrame;
        NSString *vipName = [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        self.vipImageView.image = [UIImage imageNamed:vipName];
        self.nameLabel.textColor = [UIColor orangeColor];
    }else{
        self.vipImageView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    // 配图
    if (status.pic_urls.count) {
        self.photosView.frame = _statusFrame.photosFrame;
        self.photosView.photos = status.pic_urls;
//        [self.photosView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.photosView.hidden = NO;
    }else{
        self.photosView.hidden = YES;
    }
    
    // 昵称
    self.nameLabel.frame = _statusFrame.nameFrame;
    self.nameLabel.text = user.name;
    
    // 时间
//    self.timeLabel.frame = _statusFrame.timeFrame;
    /** 时间 */
    NSString *newTime = status.created_at;
    CGFloat timeX = statusFrame.nameFrame.origin.x;
    CGFloat timeY = CGRectGetMaxY(statusFrame.nameFrame) + XDKStatusCellBorderW;
    CGSize timeSize = [newTime sizeWithTextFont:XDKStatusCellTimeFont];
    self.timeLabel.frame = (CGRect){{timeX, timeY}, timeSize};
    self.timeLabel.text = newTime;
    
    
    /** 来源 */
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + XDKStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithTextFont:XDKStatusCellSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceX, sourceY}, sourceSize};
    self.sourceLabel.text = status.source;

    // 来源
//    self.sourceLabel.text = status.source;
//    XDKLog(@"%@",status.source);
//    self.sourceLabel.frame = _statusFrame.sourceFrame;
    
    // 正文
    self.text_label.frame = _statusFrame.textFrame;
    self.text_label.text = status.text;
    
    
    /** 被转发微博*/
    if (status.retweeted_status) {
        XDKStatus *retweet_status = status.retweeted_status;
        XDKUser *retweet_status_user = retweet_status.user;
        
        self.retweetContainer.hidden = NO;
        // 被转发的整体view
        self.retweetContainer.frame = _statusFrame.retweetContainerFrame;
        // 被转发微博的正文
        self.retweetContentLabel.frame = _statusFrame.retweetContentLabelFrame;
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweet_status_user.name,retweet_status.text];
        self.retweetContentLabel.text = retweetContent;
        // 被转发微博的配图
        if (retweet_status.pic_urls.count) {
            self.retweetphotosView.frame = _statusFrame.retweetphotosFrame;
            self.retweetphotosView.photos = retweet_status.pic_urls;
//            [self.retweetphotosView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
            self.retweetphotosView.hidden = NO;
        }else{
            self.retweetphotosView.hidden = YES;
        }
    }else{
        self.retweetContainer.hidden = YES;
    }
    
    /** 工具条*/
    self.toolBar.frame = _statusFrame.toolBarFrame;
    self.toolBar.status = status;
}


@end
