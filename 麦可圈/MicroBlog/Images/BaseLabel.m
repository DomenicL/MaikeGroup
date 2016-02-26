//
//  BaseLabel.m
//  MicroBlog
//
//  Created by 李迪琛 on 16/1/13.
//  Copyright © 2016年 Dominic. All rights reserved.
//

#import "BaseLabel.h"

@implementation BaseLabel
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kImageViewNotification object:nil];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadThemeColor) name:kImageViewNotification object:nil];
    }
    return self;
}

- (void)setLabelName:(NSString *)labelName
{
    if (_labelName != labelName) {
        _labelName = labelName;
        [self loadThemeColor];
    }
}

- (void)loadThemeColor
{
    ThemeManager *manager = [ThemeManager defultManager];
    self.textColor = [manager changeColor:self.labelName];
}
@end
