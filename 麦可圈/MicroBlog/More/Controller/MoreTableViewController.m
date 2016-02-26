//
//  MoreTableViewController.m
//  MicroBlog
//
//  Created by 李迪琛 on 16/1/12.
//  Copyright © 2016年 Dominic. All rights reserved.
//

#import "MoreTableViewController.h"
#import "MoreTableViewCell.h"
#import "ThemeTableViewController.h"
#import "SinaWeibo.h"
#import "AppDelegate.h"

@implementation MoreTableViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kImageViewNotification object:nil];
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[[ThemeManager defultManager] changeTheme:@"bg_home.jpg"]];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeBackImage) name:kImageViewNotification object:nil];
}

- (void)changeBackImage
{
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[[ThemeManager defultManager] changeTheme:@"bg_home.jpg"]];
    [self.tableView reloadData];
}


#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"moreCell"];
    
//    cell.name.labelName = @"More_Item_Text_color";
    cell.name.textColor = [[ThemeManager defultManager] changeColor:@"More_Item_Text_color"];
    
//    cell.themeText.labelName = @"More_Item_Text_color";
     cell.themeText.textColor = [[ThemeManager defultManager] changeColor:@"More_Item_Text_color"];
    
    cell.backgroundColor = [[ThemeManager defultManager] changeColor:@"More_Item_color"];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.name.text = @"主题选择";
            cell.themeText.text = [ThemeManager defultManager].themeName;
            cell.themeText.textAlignment = NSTextAlignmentRight;
            cell.icon.image = [[ThemeManager defultManager] changeTheme:@"more_icon_theme"];
        }else
        {
            cell.name.text = @"账户管理";
            cell.themeText.text = nil;
            cell.icon.image = [[ThemeManager defultManager] changeTheme:@"more_icon_account"];
        }
    }else if (indexPath.section == 1)
    {
        cell.name.text = @"意见反馈";
        cell.themeText.text = nil;
        cell.icon.image = [[ThemeManager defultManager] changeTheme:@"more_icon_feedback"];
    }else
    {
        cell.name.text = @"登出当前帐号";
        cell.name.textAlignment = NSTextAlignmentCenter;
        cell.themeText.text = nil;
    }

    
    return cell;
}
#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"themeTableVC"] animated:YES];
    }else if (indexPath.section == 2 && indexPath.row == 0)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定要离开我么？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            AppDelegate *delegant = [UIApplication sharedApplication].delegate;
            [delegant.sinaWeibo logOut];
            
            UIAlertController *exit = [UIAlertController alertControllerWithTitle:@"退出程序？" message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            [exit addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
                _Exit(0);
                
            }]];
            
            [exit addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                AppDelegate *delegant = [UIApplication sharedApplication].delegate;
                [delegant.sinaWeibo logIn];
            }]];
            
            [self presentViewController:exit animated:YES completion:NULL];
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [self presentViewController:alertController animated:YES completion:NULL];
        
    }
}

@end
