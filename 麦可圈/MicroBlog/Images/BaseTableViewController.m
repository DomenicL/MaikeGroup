//
//  BaseTableViewController.m
//  MicroBlog
//
//  Created by 李迪琛 on 16/1/13.
//  Copyright © 2016年 Dominic. All rights reserved.
//

#import "BaseTableViewController.h"

@implementation BaseTableViewController
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kImageViewNotification object:nil];
}

- (void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(bgColorChange) name:kImageViewNotification object:nil];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[[ThemeManager defultManager] changeTheme:@"bg_home.jpg"]];
}

- (void)bgColorChange
{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[[ThemeManager defultManager] changeTheme:@"bg_home.jpg"]];
}

@end
