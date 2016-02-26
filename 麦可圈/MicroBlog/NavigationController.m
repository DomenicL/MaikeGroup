//
//  NavigationController.m
//  MicroBlog
//
//  Created by 李迪琛 on 16/1/11.
//  Copyright © 2016年 Dominic. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()

@end

@implementation NavigationController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kImageViewNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadImage];
  
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadImage) name:kImageViewNotification object:nil];
}

- (void)loadImage
{
    UIImage *bgImg = [[ThemeManager defultManager] changeTheme:@"mask_titlebar@2x.png"];
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(bgImg.CGImage, CGRectMake(0, 0, kSCreenWidth, 64));
    [self.navigationBar setBackgroundImage:[UIImage imageWithCGImage:imageRef] forBarMetrics:UIBarMetricsDefault];
    UIColor *color = [[ThemeManager defultManager] changeColor:@"Background_Detail_color"];
    NSDictionary *textAttribute = @{
               NSForegroundColorAttributeName:color
               };
//    NSLog(@"%@",color);
    
    self.navigationBar.titleTextAttributes = textAttribute;
    self.navigationBar.tintColor = [[ThemeManager defultManager] changeColor:@"Mask_Title_color"];
    
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
