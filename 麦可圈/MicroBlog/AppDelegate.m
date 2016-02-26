//
//  AppDelegate.m
//  MicroBlog
//
//  Created by 李迪琛 on 16/1/11.
//  Copyright © 2016年 Dominic. All rights reserved.
//

#import "AppDelegate.h"
#import "MyTabBarController.h"
#import "SinaWeibo.h"
#import "JSONModel.h"
#import "MMExampleDrawerVisualStateManager.h"

@interface AppDelegate ()<SinaWeiboDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.sinaWeibo = [[SinaWeibo alloc] initWithAppKey:kAppkey appSecret:kSecret appRedirectURI:kAppRedirectURI andDelegate:self];
    
    //设置JSONKey特殊字段的映射关系
    JSONKeyMapper *mapper = [[JSONKeyMapper alloc] initWithDictionary:@{/*@"id":@"ID",*/@"description":@"desc"}];
    [JSONModel setGlobalKeyMapper:mapper];
    
    UIStoryboard *leftStbd = [UIStoryboard storyboardWithName:@"LeftStoryboard" bundle:nil];
    UIStoryboard *rightStbd = [UIStoryboard storyboardWithName:@"RightStoryboard" bundle:nil];
    UINavigationController *leftNavCtrl = [leftStbd instantiateInitialViewController];
    UINavigationController *rightNavCtrl = [rightStbd instantiateInitialViewController];
    
    MyTabBarController *tabbarCtrl = [[MyTabBarController alloc] init];
    self.drawerCtrl = [[MMDrawerController alloc]
                       initWithCenterViewController:tabbarCtrl
                       leftDrawerViewController:leftNavCtrl
                       rightDrawerViewController:rightNavCtrl];
    
    //设置左右viewCtrl的宽度
    [self.drawerCtrl setMaximumLeftDrawerWidth:160];
    [self.drawerCtrl setMaximumRightDrawerWidth:80];
    
    //设置手势操作的区域
    [self.drawerCtrl setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerCtrl setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    self.drawerCtrl.view.backgroundColor = [UIColor clearColor];
    
    //配置管理动画的block
    [self.drawerCtrl
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         MMDrawerControllerDrawerVisualStateBlock block;
         block = [[MMExampleDrawerVisualStateManager sharedManager]
                  drawerVisualStateBlockForDrawerSide:drawerSide];
         if(block){
             block(drawerController, drawerSide, percentVisible);
         }
     }];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChange) name:kImageViewNotification object:nil];
    
    //从本地化的数据当中取出存入的新浪微博账户信息
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaWeiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    if ([sinaWeiboInfo objectForKey:@"AccessTokenKey"] && [sinaWeiboInfo objectForKey:@"ExpirationDateKey"] && [sinaWeiboInfo objectForKey:@"UserIDKey"]) {
        _sinaWeibo.accessToken = [sinaWeiboInfo objectForKey:@"AccessTokenKey"];
        _sinaWeibo.expirationDate = [sinaWeiboInfo objectForKey:@"ExpirationDateKey"];
        _sinaWeibo.userID = [sinaWeiboInfo objectForKey:@"UserIDKey"];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    [self themeDidChange];
    self.window.rootViewController = self.drawerCtrl;
    return YES;
}

- (void)themeDidChange
{
    UIImage *img = [[ThemeManager defultManager] changeTheme:@"mask_bg.jpg"];
    self.window.backgroundColor = [UIColor colorWithPatternImage:img];
}

- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken,@"AccessTokenKey",
                              sinaweibo.expirationDate,@"ExpirationDateKey",
                              sinaweibo.userID,@"UserIDKey",
                              sinaweibo.refreshToken,@"refresh_token",nil];
    [[NSUserDefaults standardUserDefaults]setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
