//
//  CommentLayout.h
//  MicroBlog
//
//  Created by 李迪琛 on 16/1/19.
//  Copyright © 2016年 Dominic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXLabel.h"
#import "CommentModel.h"

@interface CommentLayout : NSObject

@property (nonatomic, strong)CommentModel *commentModel;
@property (nonatomic, assign)CGFloat  cellHeight;

@end
