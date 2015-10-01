//
//  XDKTitleMenuViewController.m
//  XDK微博
//
//  Created by 徐宽阔 on 15/6/3.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import "XDKTitleMenuViewController.h"

@implementation XDKTitleMenuViewController



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * ID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"好友";
    }else if (indexPath.row == 1)
    {
        cell.textLabel.text = @"联系人";
    }else{
        cell.textLabel.text = @"同学";
    }
    
    return cell;
}

@end
