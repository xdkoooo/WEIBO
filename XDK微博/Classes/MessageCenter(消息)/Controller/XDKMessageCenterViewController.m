//
//  XDKMessageCenterViewController.m
//  XDK微博
//
//  Created by 徐宽阔 on 15/5/30.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import "XDKMessageCenterViewController.h"
#import "XDKTest1ViewController.h"

@interface XDKMessageCenterViewController ()

@end

@implementation XDKMessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"写私信" style:UIBarButtonItemStylePlain target:self action:@selector(composeMsg)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

-(void)composeMsg
{
    XDKLog(@"composeMsg");
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"text-message-%d",indexPath.row];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XDKTest1ViewController *test1 = [[XDKTest1ViewController alloc] init];
    test1.title = @"测试控制器1";
    test1.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:test1 animated:NO];
}


@end
