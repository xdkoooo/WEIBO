//
//  XDKIconView.m
//  XDK微博
//
//  Created by 徐宽阔 on 15/7/18.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import "XDKIconView.h"
#import "UIImageView+WebCache.h"
#import "XDKUser.h"

@interface XDKIconView()

@property (nonatomic,weak)UIImageView * verifiedView;
@end

@implementation XDKIconView

-(UIImageView *)verifiedView
{
    if (_verifiedView == nil) {
        UIImageView *verifiedView = [[UIImageView alloc] init];
        [self addSubview:verifiedView];
        _verifiedView = verifiedView;
    }
    return _verifiedView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //
    }
    return self;
}

-(void)setUser:(XDKUser *)user
{
    _user = user;
    
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
    
//    XDKUserVerifiedNone = -1,
//    XDKUserVerifiedPersonal = 0,
//    XDKUserVerifiedEnterprice = 2,
//    XDKUserVerifiedOrgMedia = 3,
//    XDKUserVerifiedOrgWebsite = 5,
//    XDKUserVerifiedDaren = 220
    
    switch (user.verified_type) {
        case XDKUserVerifiedPersonal:
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_vip"];
            break;
        case XDKUserVerifiedEnterprice:
        case XDKUserVerifiedOrgMedia:
        case XDKUserVerifiedOrgWebsite:
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
            
        case XDKUserVerifiedDaren:
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_grassroot"];
            break;
            
        default:
            self.verifiedView.hidden = YES;
            break;
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.verifiedView.size = self.verifiedView.image.size;
    self.verifiedView.x = self.width - self.verifiedView.width * 0.6;
    self.verifiedView.y = self.height - self.verifiedView.height * 0.6;
}

@end
