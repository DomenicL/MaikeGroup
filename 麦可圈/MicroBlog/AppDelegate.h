//
//  AppDelegate.h
//  MicroBlog
//
//  Created by 李迪琛 on 16/1/11.
//  Copyright © 2016年 Dominic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMDrawerController.h"
@class SinaWeibo;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong)SinaWeibo *sinaWeibo;
@property (nonatomic, strong)MMDrawerController *drawerCtrl;

@end

