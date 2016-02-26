//
//  BaseButton.m
//  MicroBlog
//
//  Created by 李迪琛 on 16/1/12.
//  Copyright © 2016年 Dominic. All rights reserved.
//

#import "BaseButton.h"

@implementation BaseButton

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kImageViewNotification object:nil];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeButton) name:kImageViewNotification object:nil];
    }
    return self;
}
- (void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeButton) name:kImageViewNotification object:nil];
}

- (void)setButtonName:(NSString *)buttonName
{
    if (_buttonName != buttonName) {
        _buttonName = buttonName;
        [self changeButton];
    }
}
- (void)changeButton
{
    UIImage *image = [[ThemeManager defultManager] changeTheme:_buttonName];
    
    [self setBackgroundImage:image forState:UIControlStateNormal];
}
@end
