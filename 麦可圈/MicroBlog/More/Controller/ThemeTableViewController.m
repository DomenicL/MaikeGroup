//
//  ThemeTableViewController.m
//  MicroBlog
//
//  Created by 李迪琛 on 16/1/13.
//  Copyright © 2016年 Dominic. All rights reserved.
//

#import "ThemeTableViewController.h"
#import "ThemeTableViewCell.h"

@implementation ThemeTableViewController
{
    NSArray *_keyArray;
    NSInteger _current;
}

-(void)awakeFromNib
{
    _keyArray = [[ThemeManager defultManager].plist allKeys];
    self.hidesBottomBarWhenPushed = YES;
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ThemeManager defultManager].plist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ThemeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"themeCell" forIndexPath:indexPath];
    cell.themeName.text = _keyArray[indexPath.row];
    if ([cell.themeName.text isEqualToString:[ThemeManager defultManager].themeName]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath) {
//       ThemeTableViewCell *cell = (ThemeTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
//    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }else{
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    }
//    }

    [ThemeManager defultManager].themeName = _keyArray[indexPath.row];
    [self.tableView reloadData];

}



@end
