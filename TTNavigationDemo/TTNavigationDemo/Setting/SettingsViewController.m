//
//  SettingsViewController.m
//  GoForward
//
//  Created by xianmingchen on 16/3/21.
//  Copyright © 2016年 xianmingchen. All rights reserved.
//

#import "SettingsViewController.h"

@implementation SettingsViewController

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@", [indexPath description]);
}

@end