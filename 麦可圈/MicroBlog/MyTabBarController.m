//
//  MyTabBarController.m
//  MicroBlog
//
//  Created by 李迪琛 on 16/1/11.
//  Copyright © 2016年 Dominic. All rights reserved.
//

#import "MyTabBarController.h"
#import "NavigationController.h"

@interface MyTabBarController ()
{
    BaseImageView *_tabBarView;
    BaseImageView *_selectView;
}

@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // [self _createTabBar];
    self.viewControllers = [self _createControllers];
    [self _createTabBar];

}

- (void)setSelectIndex:(NSInteger)selectIndex
{
    if (_selectIndex != selectIndex) {
        NavigationController *na1 = self.viewControllers[_selectIndex];
        NavigationController *na2 = self.viewControllers[selectIndex];
        [na1.view removeFromSuperview];
        [self.view insertSubview:na2.view belowSubview:_tabBarView];
       
    }
     _selectIndex = selectIndex;
}

- (NSArray *)_createControllers
{
    UIStoryboard *homeSB = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
    NavigationController *homeVC = [homeSB instantiateViewControllerWithIdentifier:@"HomeStoryboard"];
    homeVC.topViewController.title = @"HOME";
    
    UIStoryboard *messageSB = [UIStoryboard storyboardWithName:@"Message" bundle:nil];
    NavigationController *messageVC = [messageSB instantiateViewControllerWithIdentifier:@"MessageStoryboard"];
//    messageVC.topViewController.title = @"MESSAGE";
    
    UIStoryboard *profileSB = [UIStoryboard storyboardWithName:@"Profile" bundle:nil];
    NavigationController *profileVC = [profileSB instantiateViewControllerWithIdentifier:@"ProfileStoryboard"];
    profileVC.topViewController.title = @"PROFILE";
    
    UIStoryboard *discoverSB = [UIStoryboard storyboardWithName:@"Discover" bundle:nil];
    NavigationController *discoverVC = [discoverSB instantiateViewControllerWithIdentifier:@"DiscoverStoryboard"];
    discoverVC.topViewController.title = @"DISCOVER";
    
    UIStoryboard *moreSB = [UIStoryboard storyboardWithName:@"More" bundle:nil];
    NavigationController *moreVC = [moreSB instantiateViewControllerWithIdentifier:@"MoreStoryboard"];
    moreVC.topViewController.title = @"MORE";
   
    NSArray *array = @[homeVC,messageVC,profileVC,discoverVC,moreVC];
    
    return array;
}

- (void)_createTabBar
{
    _tabBarView = [[BaseImageView alloc] initWithFrame:CGRectMake(0, -7, kSCreenWidth, 56)];
    [_tabBarView setThemeName:@"mask_navbar.png"];
    _tabBarView.userInteractionEnabled = YES;
    [self.tabBar addSubview:_tabBarView];
    
    _selectView = [[BaseImageView alloc] initWithFrame:CGRectMake(0, 0, 64, 49)];
    _selectView.themeName = @"home_bottom_tab_arrow.png";
    [_tabBarView addSubview:_selectView];
    NSArray *imgNames = @[
                          @"home_tab_icon_1.png",
                          @"home_tab_icon_2.png",
                          @"home_tab_icon_3.png",
                          @"home_tab_icon_4.png",
                          @"home_tab_icon_5.png",
                          ];

    
    CGFloat itemWidth = kSCreenWidth/5.0;
    for (int i = 0; i < imgNames.count; i++) {
        NSString *name = imgNames[i];
        
        BaseButton *button = [BaseButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(itemWidth*i, 0, itemWidth, 56);
        button.buttonName = name;
        button.tag = i;
        [button addTarget:self action:@selector(selectTab:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            _selectView.center = button.center;
            self.selectIndex = button.tag;
        }
        [_tabBarView addSubview:button];
    }
}

- (void)selectTab:(UIButton *)sender
{
    [UIView animateWithDuration:0.2 animations:^{
        _selectView.center = sender.center;
    }];
    self.selectedIndex = sender.tag;
    
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
