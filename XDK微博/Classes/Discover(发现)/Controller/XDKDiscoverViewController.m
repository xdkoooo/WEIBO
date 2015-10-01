//
//  XDKDiscoverViewController.m
//  XDK微博
//
//  Created by 徐宽阔 on 15/5/30.
//  Copyright (c) 2015年 xdk. All rights reserved.
//

#import "XDKDiscoverViewController.h"
#import "XDKSearchBar.h"

@interface XDKDiscoverViewController ()

@end

@implementation XDKDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XDKSearchBar *searchBar = [XDKSearchBar searchBar];
    searchBar.width = 300;
    searchBar.height = 30;
    
    self.navigationItem.titleView = searchBar;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/


@end
