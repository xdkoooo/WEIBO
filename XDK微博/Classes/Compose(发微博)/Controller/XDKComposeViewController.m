//
//  XDKComposeViewController.m
//  XDK微博
//
//  Created by 徐宽阔 on 15/7/19.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import "XDKComposeViewController.h"
#import "XDKAccountTool.h"
#import "XDKTextView.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "XDKComposeToolbar.h"
#import "XDKComposePhotosView.h"

@interface XDKComposeViewController() <UITextViewDelegate,XDKComposeToolbarDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic,weak)XDKTextView * textView;
@property (nonatomic,weak)XDKComposeToolbar * toolbar;
@property (nonatomic,weak)XDKComposePhotosView *photosView;
@end

@implementation XDKComposeViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航栏内容
    [self setUpNav];
    // 设置输入控件
    [self setUpTextView];
    
    // 设置toolbar
    [self setUpToolBar];
    
    // 设置photosView
    [self setUpPhotosView];
    
    // 自动调整scrollView的内边距
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}

// 设置导航栏内容
-(void)setUpNav
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    
    NSString *prefix = @"发微博";
    NSString *name = [XDKAccountTool account].name;
    if (name) {
        UILabel *titleView = [[UILabel alloc] init];
        titleView.numberOfLines = 0;
        titleView.textAlignment = NSTextAlignmentCenter;
        titleView.width = 100;
        titleView.height = 44;
        
        
        NSString *str = [NSString stringWithFormat:@"%@\n%@",prefix,name];
        NSRange range = [str rangeOfString:name];
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:str];
        [text setAttributes:@{NSFontAttributeName :[UIFont boldSystemFontOfSize:16]} range:[str rangeOfString:prefix]];
        [text setAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:13]}  range:range];
        [text setAttributes:@{NSForegroundColorAttributeName :[UIColor orangeColor]}  range:range];
        
        titleView.attributedText = text;
        self.navigationItem.titleView = titleView;

    }else{
        self.title = prefix;
    }
}

// 设置输入控件
-(void)setUpTextView
{
    XDKTextView *textView = [[XDKTextView alloc] init];
    // 垂直方向上永远可以拖拽
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    textView.frame = self.view.bounds;
    textView.font = [UIFont systemFontOfSize:15];
    textView.placeholder = @"分享新鲜事...";
    textView.placeholderColor = [UIColor redColor];
    [self.view addSubview:textView];
    // 进入即调出键盘
//    [textView becomeFirstResponder];
    self.textView = textView;
    
    // 监听textView输入通知
    [XDKNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    // 监听键盘显示隐藏的通知
    [XDKNotificationCenter addObserver:self selector:@selector(keyboardChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

// 监听通知方法
-(void)textDidChange
{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}
-(void)keyboardChangeFrame:(NSNotification *)note
{
//    NSLog(@"%@",note.userInfo);
    /*
     UIKeyboardFrameEndUserInfoKey = NSRect: {{0, 315}, {320, 253}},
     UIKeyboardAnimationDurationUserInfoKey = 0.25,
     UIKeyboardAnimationCurveUserInfoKey = 7
     */
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    double duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.y = keyboardF.origin.y - self.toolbar.height;
        
        if (keyboardF.origin.y > self.view.height) {
            self.toolbar.y = self.view.height - self.toolbar.height;
        }else{
            self.toolbar.y = keyboardF.origin.y - self.toolbar.height;
        }
    }];
    
}

-(void)dealloc
{
    [XDKNotificationCenter removeObserver:self];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}


-(void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)send
{
    if (self.photosView.photos.count) {
        [self sendWithImage];
    }else{
        [self sendWithoutImage];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)sendWithImage
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    XDKAccount *account = [XDKAccountTool account];
    params[@"access_token"] = account.access_token;
    params[@"status"] = self.textView.text;
    
    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        UIImage *image = [self.photosView.photos firstObject];
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showSuccess:@"发送失败"];
    }];
}

-(void)sendWithoutImage
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    XDKAccount *account = [XDKAccountTool account];
    params[@"access_token"] = account.access_token;
    params[@"status"] = self.textView.text;
    
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        XDKLog(@"%@",responseObject);
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        XDKLog(@"%@",error);
        [MBProgressHUD showError:@"发送失败"];
    }];
}

-(void)setUpToolBar
{
    XDKComposeToolbar *toolbar = [[XDKComposeToolbar alloc] init];
    toolbar.delegate = self;
    toolbar.width = self.view.width;
    toolbar.height = 44;
    toolbar.y = self.view.height - toolbar.height;
//    self.textView.inputAccessoryView = toolbar;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
}

#pragma mark - <UITextViewDelegate>
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.textView endEditing:YES];
}
#pragma mark - <XDKComposeToolbarDelegate>
-(void)composeToolbar:(XDKComposeToolbar *)toolbar didClickButton:(XDKComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case XDKComposeToolbarButtonTypeCamera:
            [self openCamera];
            break;
        case XDKComposeToolbarButtonTypePicture:
            [self openAlbum];
            break;
        case XDKComposeToolbarButtonTypeMention:
            break;
        case XDKComposeToolbarButtonTypeTrend:
            break;
        case XDKComposeToolbarButtonTypeEmotion:
            break;
        default:
            break;
    }
}

-(void)openCamera
{
    [self getImage:UIImagePickerControllerSourceTypeCamera];
}

-(void)openAlbum
{
    [self getImage:UIImagePickerControllerSourceTypePhotoLibrary];
}

-(void)getImage:(UIImagePickerControllerSourceType)type
{
    if (![UIImagePickerController isSourceTypeAvailable:type]) return;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = type;
    [self presentViewController:picker animated:YES completion:nil];
}
#pragma mark - <UIImagePickerControllerDelegate>
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
//    NSLog(@"%@",info);
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.photosView addPhoto:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
}


-(void)setUpPhotosView
{
    XDKComposePhotosView *photosView = [[XDKComposePhotosView alloc] init];
    photosView.width = self.view.width;
    photosView.height = self.view.height;
    photosView.y = 100;
//    photosView.backgroundColor = [UIColor blueColor];
    [self.textView addSubview:photosView];
    self.photosView = photosView;
}
@end


















