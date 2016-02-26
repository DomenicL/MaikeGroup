//
//  BaseImageView.m
//  MicroBlog
//
//  Created by 李迪琛 on 16/1/12.
//  Copyright © 2016年 Dominic. All rights reserved.
//

#import "BaseImageView.h"

@implementation BaseImageView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kImageViewNotification object:nil];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadTheme) name:kImageViewNotification object:nil];
    }
    return self;
}

- (void)setThemeName:(NSString *)themeName
{
    if (_themeName != themeName) {
        _themeName = themeName;
        [self loadTheme];
    }
}

- (void)loadTheme
{
    ThemeManager *manager = [ThemeManager defultManager];
    self.image = [manager changeTheme:self.themeName];
}
@end
