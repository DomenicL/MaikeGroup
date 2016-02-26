//
//  BaseViewController.m
//  MicroBlog
//
//  Created by 李迪琛 on 16/1/11.
//  Copyright © 2016年 Dominic. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kImageViewNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backgroundColorChange) name:kImageViewNotification object:nil];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[[ThemeManager defultManager] changeTheme:@"bg_home.jpg"]];
    // Do any additional setup after loading the view.
}

- (void)backgroundColorChange
{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[[ThemeManager defultManager] changeTheme:@"bg_home.jpg"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
