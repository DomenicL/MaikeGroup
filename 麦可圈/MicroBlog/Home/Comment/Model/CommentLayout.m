//
//  CommentLayout.m
//  MicroBlog
//
//  Created by 李迪琛 on 16/1/19.
//  Copyright © 2016年 Dominic. All rights reserved.
//

#import "CommentLayout.h"

@implementation CommentLayout
- (void)setCommentModel:(CommentModel *)commentModel
{
    if (_commentModel != commentModel) {
        _commentModel = commentModel;
        [self returnCellHeight];
    }
}

- (void)returnCellHeight
{
    self.cellHeight = [WXLabel getTextHeight:14 width:230 text:self.commentModel.text linespace:5];
}
@end
