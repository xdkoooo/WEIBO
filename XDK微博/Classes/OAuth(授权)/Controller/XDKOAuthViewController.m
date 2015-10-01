//
//  XDKOAuthViewController.m
//  XDK微博
//
//  Created by 徐宽阔 on 15/6/18.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import "XDKOAuthViewController.h"
#import "XDKAccountTool.h"
#import "MBProgressHUD+MJ.h"
#import "UIWindow+XDKExtension.h"
#import "XDKHttpTool.h"

@interface XDKOAuthViewController() <UIWebViewDelegate>

@end
@implementation XDKOAuthViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    
    // client_id AppKey
    // 回调地址
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",XDKAppKey,XDKRedirectURI];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    webView.delegate = self;
    
    [self.view addSubview:webView];
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载。。。"];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 1.获得URL
    NSString *url = request.URL.absoluteString;
    XDKLog(@"%@",url);
    // 2.判断是否为回调地址
    NSRange range = [url rangeOfString:@"code="];
    
    if (range.length != 0) {
        // 截取code=后面的字符串
        long fromIndex = (range.location + range.length);
        NSString *code = [url substringFromIndex:fromIndex];
        // 利用code换取一个accessToken
        [self accessTokenWithCode:code];
        
        return NO;
    }
    return YES;
}


-(void)accessTokenWithCode:(NSString *)code
{
    // 1.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = XDKAppKey;
    params[@"client_secret"] = XDKAppSecret;
    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"] = XDKRedirectURI;
    params[@"code"] = code;
    
    [XDKHttpTool post:@"https://api.weibo.com/oauth2/access_token" params:params success:^(id json) {
        [MBProgressHUD hideHUD];
        
        // 将返回的账号数据，存进沙盒
        XDKAccount *account = [XDKAccount accountWithDict:json];
        [XDKAccountTool saveAccount:account];
        
        // 切换根控制器
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchRootViewController];

    } failure:^(NSError *error) {
        XDKLog(@"failure--%@",error);
        [MBProgressHUD hideHUD];
    }];
    
}


@end
