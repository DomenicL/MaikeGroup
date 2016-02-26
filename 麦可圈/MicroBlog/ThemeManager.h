//
//  ThemeManager.h
//  MicroBlog
//
//  Created by 李迪琛 on 16/1/12.
//  Copyright © 2016年 Dominic. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kSaveThemeName @"kSaveThemeName"

@interface ThemeManager : NSObject

@property (nonatomic, copy) NSString *themeName;
@property (nonatomic, strong) NSDictionary *plist;

+ (instancetype)defultManager;

- (UIImage *)changeTheme:(NSString *)themeName;
- (UIColor *)changeColor:(NSString *)colorName;

@end
