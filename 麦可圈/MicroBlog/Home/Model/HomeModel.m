//
//  HomeModel.m
//  MicroBlog
//
//  Created by 李迪琛 on 16/1/13.
//  Copyright © 2016年 Dominic. All rights reserved.
//

#import "HomeModel.h"
#import "UserModel.h"

@implementation HomeModel

/*
 1、解析数据进行匹配
 2、对请求下来的数据进行处理 适用于本程序
 3、创建时间的时间处理
 4、来源的正则表达式处理
 */

//- (void)setText:(NSString *)text
//{
//    if (_text != text)
//    {
////        NSString *regax = @"\\[\\w+\\]";
////        NSArray *arr = [text componentsMatchedByRegex:regax];
////        
////        NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"documents/emotions.plist"];
////        NSArray *fileArray = [NSArray arrayWithContentsOfFile:filePath];
////        
////        for (NSString *faceName in arr) {
////            NSString *str = [NSString stringWithFormat:@"value='%@'",faceName];
////            NSPredicate *predicate = [NSPredicate predicateWithFormat:str];
////            NSArray *item = [fileArray filteredArrayUsingPredicate:predicate];
////            
////            if (item.count > 0) {
////                NSDictionary *dic = item[0];
////                NSString *image = dic[@"url"];
////                NSString *string = [NSString stringWithFormat:@"<image url = '%@'>",image];
////                text = [text stringByReplacingOccurrencesOfString:faceName withString:string];
////            }
////        }
//        _text = text;
//    }
//}
//
//- (NSDictionary *)attributeMapDictionary:(NSDictionary *)jsonDic
//{
//    //请求下来的值 ： 属性名
//    NSDictionary *mapAtt = @{
//                             @"created_at" :@"createDate",
//                             @"id":@"weiboId",
//                             @"text":@"text",
//                             @"source":@"source",
//                             @"favorited":@"favorited",
//                             @"thumbnail_pic":@"thumbnailImage",
//                             @"bmiddle_pic":@"bmiddlelImage",
//                             @"original_pic":@"originalImage",
//                             @"geo":@"geo",
//                             @"reposts_count":@"repostsCount",
//                             @"comments_count":@"commentsCount",
//                             @"attitudes_count":@"attitudeCount",
//                             @"pic_urls":@"picArray"
//                             };
//    
//    return mapAtt;
//}
//
//- (void)setAttributes:(NSDictionary *)jsonDic {
//    [super setAttributes:jsonDic];
//    
//    NSDictionary *userDic = jsonDic[@"user"];
//    if (userDic != nil) {
//        UserModel *user = [[UserModel alloc] initContentWithDic:userDic];
//        self.user = user;
//    }
//    
//    NSDictionary *retweetDic = jsonDic[@"retweeted_status"];
//    if (retweetDic != nil) {
//        
//        HomeModel *reWeibo = [[HomeModel alloc] initContentWithDic:retweetDic];
//        self.reWeibo = reWeibo;
//    }
//}


@end
