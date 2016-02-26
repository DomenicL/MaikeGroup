//
//  ProfileViewController.m
//  MicroBlog
//
//  Created by 李迪琛 on 16/1/11.
//  Copyright © 2016年 Dominic. All rights reserved.
//

#import "ProfileViewController.h"
#import "AppDelegate.h"
#import "SinaWeibo.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController


- (void)viewDidLoad {
    [super viewDidLoad];
//    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
////    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"documents/emotions.plist"];
////    NSLog(@"%@",filePath);
////    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
//    
//        [delegate.sinaWeibo requestWithURL:@"emotions.json" params:nil httpMethod:@"GET" finishBlock:^(SinaWeiboRequest *request, id result) {
//            NSArray *arr = result;
//            
//            for (NSDictionary *dic in arr) {
//                NSString *name = dic[@"value"];
//                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:dic[@"url"]]];
//                [data writeToFile:[NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"documents/%@",name]] atomically:YES];
//                    NSLog(@"%@",NSHomeDirectory());
//            }
////            if ([arr writeToFile:filePath atomically:YES]) {
////                NSLog(@"保存成功");
////            }
//        } failBlock:^(SinaWeiboRequest *request, NSError *error) {
//            
//        }];
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
