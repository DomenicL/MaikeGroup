//
//  WeiboLayoutFrame.h
//  MicroBlog
//
//  Created by 李迪琛 on 16/1/14.
//  Copyright © 2016年 Dominic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeModel.h"
#define kMultipleImgSpace 5     //多图之间的间隔

@interface WeiboLayoutFrame : NSObject

@property (nonatomic, strong)HomeModel *homeModel;

@property (nonatomic, assign)CGRect textFrame;      //正文内容
//@property (nonatomic, assign)CGRect imageFrame;     //正文图片
//@property (nonatomic, assign)CGFloat cellHeight;    //cell高度
@property (nonatomic, assign)CGRect retweetTextFrame; //被转发内容
//@property (nonatomic, assign)CGRect retweetImgFrame; //被转发图片
@property (nonatomic, assign)CGRect weiboFrame; //微博内容整体
@property (nonatomic, assign)CGRect bkgFrame;   //被转发微博背景

//微博多图每张图片的frame
@property(nonatomic, strong)NSMutableArray *imgFrameArr;

//转发微博多图每张图片的frame
@property(nonatomic, strong)NSMutableArray *retweetImgFrameArr;

@end
