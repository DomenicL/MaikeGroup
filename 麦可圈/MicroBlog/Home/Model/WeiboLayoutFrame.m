//
//  WeiboLayoutFrame.m
//  MicroBlog
//
//  Created by 李迪琛 on 16/1/14.
//  Copyright © 2016年 Dominic. All rights reserved.
//

#import "WeiboLayoutFrame.h"

@implementation WeiboLayoutFrame

- (instancetype)init
{
    self = [super init];
    if (self) {
        _retweetImgFrameArr = [NSMutableArray array];
        _imgFrameArr = [NSMutableArray array];
        for (int i=0; i<9; i++) {
            [_imgFrameArr addObject:[NSValue valueWithCGRect:CGRectZero]];
            [_retweetImgFrameArr addObject:[NSValue valueWithCGRect:CGRectZero]];
        }
    }
    return self;
}

- (void)setHomeModel:(HomeModel *)homeModel
{
    if (_homeModel != homeModel) {
        _homeModel = homeModel;
        
        [self layoutFrame];
    }
}

- (void)layoutFrame
{
    //微博视图
    self.weiboFrame = CGRectMake(10, 60, kSCreenWidth - 20, 0);
    
    //计算正文文本
    CGFloat textWidth = CGRectGetWidth(self.weiboFrame) - 20;
    CGFloat textHeight = [WXLabel getTextHeight:15 width:textWidth text:self.homeModel.text linespace:5];
    self.textFrame = CGRectMake(10, 0, textWidth, textHeight);
    
    //计算正文图片
    if (self.homeModel.pic_urls.count > 0) {
        int row = 0;
        int piece = 0;
        CGFloat imageX = CGRectGetMinX(self.textFrame);
        CGFloat imageY = CGRectGetMaxY(self.textFrame) + 5;

        CGRect imgFrame = CGRectZero;
        CGFloat imgSize = (textWidth - kMultipleImgSpace * 2)/3;
        
        for (int i = 0; i < self.homeModel.pic_urls.count; i++) {
            row = i / 3;
            piece = i % 3;
            imgFrame = CGRectMake(imageX + piece *(kMultipleImgSpace + imgSize), imageY + row *(kMultipleImgSpace + imgSize), imgSize, imgSize);
            [self.imgFrameArr replaceObjectAtIndex:i withObject:[NSValue valueWithCGRect:imgFrame]];
        }
        
    }
    
    //计算被转发文本
    if (self.homeModel.retweeted_status) {
        
        CGFloat retextWidth = self.textFrame.size.width - 20;
        CGFloat retextHeight = [WXLabel getTextHeight:14 width:retextWidth text:self.homeModel.retweeted_status.text linespace:5] + 25;
        self.retweetTextFrame = CGRectMake( 10, 0, retextWidth, retextHeight);
        
        NSArray *reWeiboImage = _homeModel.retweeted_status.pic_urls;
        //被转发图片 多图
        if (reWeiboImage.count > 0) {
            CGFloat reImageY = CGRectGetMaxY(self.retweetTextFrame) + 5;
            int row = 0;
            int piece = 0;
            CGRect reimgFrame = CGRectZero;
            CGFloat imgSize = (retextWidth - kMultipleImgSpace * 2)/3;
            

            for (int i = 0; i < reWeiboImage.count; i++) {
                row = i / 3;
                piece = i % 3;
                reimgFrame = CGRectMake(10 + piece *(kMultipleImgSpace + imgSize), reImageY + row *(kMultipleImgSpace + imgSize), imgSize, imgSize);
                [self.retweetImgFrameArr replaceObjectAtIndex:i withObject:[NSValue valueWithCGRect:reimgFrame]];
            }
        }
        
        NSInteger line = (_homeModel.pic_urls.count+2)/3;
        CGFloat bkgImageX = CGRectGetMinX(self.textFrame);
        CGFloat bkgImageY = CGRectGetMaxY(self.textFrame) + line * ((textWidth - kMultipleImgSpace * 2)/3);
        CGFloat bgWidth = CGRectGetWidth(self.textFrame);
        CGFloat bgHeight = CGRectGetHeight(self.retweetTextFrame);
        if (self.homeModel.retweeted_status.pic_urls.count > 0) {
            CGFloat imgSize = (retextWidth - kMultipleImgSpace * 2)/3;
            bgHeight = CGRectGetHeight(self.retweetTextFrame) + (_homeModel.retweeted_status.pic_urls.count+2)/3 * imgSize;
        }
        self.bkgFrame = CGRectMake(bkgImageX, bkgImageY, bgWidth, bgHeight + 10);
    }
    
    CGRect frame = self.weiboFrame;
    frame.size.height = CGRectGetHeight(self.bkgFrame) + CGRectGetHeight(self.textFrame) + ((_homeModel.pic_urls.count+2)/3 * ((textWidth - kMultipleImgSpace * 2)/3 + kMultipleImgSpace));
    self.weiboFrame = frame;
    
}

@end
