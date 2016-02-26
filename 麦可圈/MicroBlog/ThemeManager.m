//
//  ThemeManager.m
//  MicroBlog
//
//  Created by 李迪琛 on 16/1/12.
//  Copyright © 2016年 Dominic. All rights reserved.
//
#define kInitialImage @"Happy Toy"

#import "ThemeManager.h"

@implementation ThemeManager
{
//    NSDictionary *_plist;
    NSDictionary *_colorConfig;
}

+ (instancetype)defultManager
{
    static ThemeManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:nil] init];
    });
    return instance;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [self defultManager];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _themeName = kInitialImage;
        
        NSString *saveName = [[NSUserDefaults standardUserDefaults] objectForKey:kSaveThemeName];
        if (saveName.length > 0) {
            _themeName = saveName;
        }
        NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"theme" ofType:@"plist"];
        _plist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
        
        _colorConfig = [NSDictionary dictionaryWithContentsOfFile: [[self themePath] stringByAppendingPathComponent:@"config.plist"]];
    }
    return self;
}

- (void)setThemeName:(NSString *)themeName
{
    if (_themeName != themeName)
    {

        _themeName = themeName;
        _colorConfig = [NSDictionary dictionaryWithContentsOfFile: [[self themePath] stringByAppendingPathComponent:@"config.plist"]];
        [[NSNotificationCenter defaultCenter]postNotificationName:kImageViewNotification object:self userInfo:nil];
        
    }
}

- (NSString *)themePath
{
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[_plist objectForKey:_themeName]];
    return path;
}

- (UIImage *)changeTheme:(NSString *)themeName
{
    if (themeName.length == 0) {
        return nil;
    }
    NSString *wholePath = [[self themePath] stringByAppendingPathComponent:themeName];
    UIImage *image = [UIImage imageWithContentsOfFile:wholePath];
    
    return image;
}

- (UIColor *)changeColor:(NSString *)colorName
{
    if (colorName.length == 0) {
        return nil;
    }
    
    NSDictionary *rgbDic = [_colorConfig objectForKey:colorName];
    //解包
    CGFloat r = [rgbDic[@"R"] floatValue];
    CGFloat g = [rgbDic[@"G"] floatValue];
    CGFloat b = [rgbDic[@"B"] floatValue];
    CGFloat alpha = [rgbDic[@"alpha"] floatValue];
    //注意alpha值可能为nil
    if (rgbDic[@"alpha"] == nil) {
        alpha = 1;
    }
    
    UIColor *color = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:alpha];
    
    return color;
}

@end
