//
//  XDKHomeViewController.m
//  XDK微博
//
//  Created by 徐宽阔 on 15/5/30.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import "XDKHomeViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "XDKDropdownMenu.h"
#import "XDKTitleMenuViewController.h"
#import "XDKAccountTool.h"
#import "XDKTitleButton.h"
#import "XDKStatus.h"
#import "XDKUser.h"
#import "MJExtension.h"
#import "XDKLoadMoreView.h"
#import "MJRefresh.h"
#import "xdkstatusFrame.h"
#import "XDKHomeCell.h"
#import "XDKHttpTool.h"

@interface XDKHomeViewController () <XDKDropdownMenuDelegate,MJRefreshBaseViewDelegate>
/** 模型数组 */
@property (nonatomic,strong) NSMutableArray  *statusesFrame;

/** footer */
//@property (nonatomic,weak) MJRefreshFooterView  *footer;

@property (nonatomic,weak) MJRefreshHeaderView  *header;


@end

@implementation XDKHomeViewController

-(NSMutableArray *)statusesFrame
{
    if (_statusesFrame == nil) {
        self.statusesFrame = [NSMutableArray array];
    }
    return _statusesFrame;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = XDKColor(211, 211, 211);
//    self.tableView.contentInset = UIEdgeInsetsMake(XDKStatusCellMargin, 0, 0, 0);
    
    // 1.设置导航栏
    [self setupNav];
    
    // 2.获取用户信息
    [self setupUserInfo];
    
    // 3.下拉刷新
//    [self setupRefreshView];
    [self setupDownRefresh];
   
    // 4.上拉刷新
    [self setupUpRefresh];
    
    // 5.获取未读微博数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(checkUnreadCount) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}

-(void)setupNav
{
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendsearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_hightlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_hightlighted"];
    
    /* 中间的标题按钮 */
    XDKTitleButton *titleButton = [[XDKTitleButton alloc] init];
    titleButton.width = 150;
    titleButton.height = 30;
    NSString *name = [XDKAccountTool account].name;
    [titleButton setTitle:name?name:@"首" forState:UIControlStateNormal];
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
    
    // 如果图片的某个方向上不规则，比如有突起，那么这个方向上不能拉伸
    // 如果按钮内部的图片、文字固定，用imageEdgeInsets titleEdgeInsets 比较合适
    
}


-(void)setupUserInfo
{
    
    // 1.拼接请求参数
    XDKAccount *account = [XDKAccountTool account];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    
    // 2.发送请求
    [XDKHttpTool get:@"https://api.weibo.com/2/users/show.json" params:params success:^(id json) {
        UIButton *titleBtn = (UIButton *)self.navigationItem.titleView;
        
        XDKUser *user = [XDKUser objectWithKeyValues:json];
        // 设置名字
        [titleBtn setTitle:user.name forState:UIControlStateNormal];
        // 存储昵称
        account.name = user.name;
        [XDKAccountTool saveAccount:account];

    } failure:^(NSError *error) {
        XDKLog(@"请求失败--%@",error);
    }];
}


-(void)checkUnreadCount
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    XDKAccount *account = [XDKAccountTool account];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    // 注册图标提示数
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge) categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
    
    [XDKHttpTool get:@"https://rm.api.weibo.com/2/remind/unread_count.json" params:params success:^(id json) {
        NSString *status = [json[@"status"] description];
        XDKLog(@"%@",json[@"status"]);
        if ([status isEqualToString:@"0"]) {
            // 控制器的tabbarItem
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }else{
            self.tabBarItem.badgeValue = status;
            [UIApplication sharedApplication].applicationIconBadgeNumber = status.intValue;
        }

    } failure:^(NSError *error) {
         XDKLog(@"%@",error);
    }];
}

/**
 *  上拉刷新
 */
-(void)setupDownRefresh{
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.delegate = self;
    header.scrollView = self.tableView;
    [header beginRefreshing];
    self.header = header;
}
/**
 *  顺心控件进入开始刷新状态的时候
 *
 *  @param refreshView
 */
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([refreshView isKindOfClass:[MJRefreshHeaderView class]]) {
        [self loadNewData];
    }else{
        //
    }
    
}

-(void)setupUpRefresh
{
    XDKLoadMoreView *footer = [XDKLoadMoreView footer];
    self.tableView.tableFooterView = footer;
    footer.hidden = YES;
}

-(void)dealloc
{
    [self.header free];
}

-(void)loadMoreData
{
    XDKAccount *account = [XDKAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"count"] = @20;
    
    // 取出最前面的微博
    XDKStatusFrame *lastStatusFrame = [self.statusesFrame lastObject];
    
    // 指定参数，返回ID比since_id大的微博
    if (lastStatusFrame) {
        long long maxId = [lastStatusFrame.status.idstr longLongValue] - 1;
        params[@"max_id"] = @(maxId);
    }
    
    [XDKHttpTool get:@"https://api.weibo.com/2/statuses/friends_timeline.json" params:params success:^(id json) {
        NSArray *statusArray = [XDKStatus objectArrayWithKeyValuesArray:json[@"statuses"]];
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (XDKStatus *status in statusArray) {
            XDKStatusFrame *statusFrame = [[XDKStatusFrame alloc] init];
            statusFrame.status = status;
            
            [statusFrameArray addObject:statusFrame];
        }
        // 将数据放到数组的最后面
        [self.statusesFrame addObjectsFromArray:statusFrameArray];
        // 刷新表格
        [self.tableView reloadData];
        self.tableView.tableFooterView.hidden = YES;

    } failure:^(NSError *error) {
        XDKLog(@"获取数据失败--%@",error);
        // 停止刷新
        self.tableView.tableFooterView.hidden = YES;

    }];
}

-(void)loadNewData
{
    XDKAccount *account = [XDKAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"count"] = @20;
    
    // 取出最前面的微博
    XDKStatusFrame *firstStatusFrame = [self.statusesFrame firstObject];
    
    // 指定参数，返回ID比since_id大的微博
    if (firstStatusFrame) {
        params[@"since_id"] = firstStatusFrame.status.idstr;
    }
    
    [XDKHttpTool get:@"https://api.weibo.com/2/statuses/friends_timeline.json" params:params success:^(id json) {
        NSArray *statusArray = [XDKStatus objectArrayWithKeyValuesArray:json[@"statuses"]];
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (XDKStatus *status in statusArray) {
            XDKStatusFrame *statusFrame = [[XDKStatusFrame alloc] init];
            statusFrame.status = status;
            
            [statusFrameArray addObject:statusFrame];
        }
        
        NSRange range = NSMakeRange(0, statusFrameArray.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusesFrame insertObjects:statusFrameArray atIndexes:set];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 停止刷新
        [self.header endRefreshing];
        
        [self showNewStatusCount:(int)statusFrameArray.count];

    } failure:^(NSError *error) {
        XDKLog(@"获取数据失败--%@",error);
        // 停止刷新
        [self.header endRefreshing];

    }];
}

/**
 *  显示最新数据的条数
 *
 *  @param count 刷新得到的条目数
 */
-(void)showNewStatusCount:(int)count
{
    // 刷新成功
    self.tabBarItem.badgeValue  = nil;
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    if (count == 0) {
        label.text = [NSString stringWithFormat:@"共有%d条新的微博数据",count];
    }else{
        label.text = [NSString stringWithFormat:@"共有%d条新的微博数据",count];
    }
    CGFloat W = [UIScreen mainScreen].bounds.size.width;
    CGFloat H = 30;
    CGFloat X = 0;
    CGFloat Y = 64 - H;
    label.frame = CGRectMake(X, Y, W, H);
    
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    [UIView animateWithDuration:1.0 animations:^{
//        label.y += label.height;
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
//            label.y -= label.height;
            // 将控件的transform清空，回到原位
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
    
    
}


-(void)friendsearch
{
    NSLog(@"friendsearch");
}

-(void)pop
{
    NSLog(@"pop");
}


-(void)titleClick:(UIButton *)titleButton
{
    XDKDropdownMenu *menu = [XDKDropdownMenu menu];
    menu.delegate = self;
    XDKTitleMenuViewController *vc = [[XDKTitleMenuViewController alloc] init];
    vc.view.height = 150;
    vc.view.width = 150;
    menu.contentController = vc;
    [menu showFrom:titleButton];
    
    
}

#pragma mark -- XDKDropdownMenuDelegate

-(void)dropdownMenuDidDisMiss:(XDKDropdownMenu *)menu
{
    UIButton *btn = (UIButton *)self.navigationItem.titleView;
    btn.selected = NO;
}

-(void)dropdownMenuDidShow:(XDKDropdownMenu *)menu
{
    UIButton *btn = (UIButton *)self.navigationItem.titleView;
    btn.selected = YES;
}

#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statusesFrame.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * ID = @"status";
    XDKHomeCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[XDKHomeCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.statusFrame = self.statusesFrame[indexPath.row];
    
    return cell;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.statusesFrame.count == 0 || self.tableView.tableFooterView.isHidden == NO) return;
    
    CGFloat offsetY = scrollView.contentOffset.y;
                // <44
    
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    if (offsetY >= judgeOffsetY) { // 最后一个cell完全进入视野范围内
        // 显示footer
        self.tableView.tableFooterView.hidden = NO;
        
        // 加载更多的微博数据
        [self loadMoreData];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XDKStatusFrame *statusFrame = self.statusesFrame[indexPath.row];
    
    return statusFrame.cellHeight;
}

@end
