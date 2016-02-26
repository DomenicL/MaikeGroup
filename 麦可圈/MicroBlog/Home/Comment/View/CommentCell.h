//
//  CommentCell.h
//  MicroBlog
//
//  Created by 李迪琛 on 16/1/19.
//  Copyright © 2016年 Dominic. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CommentLayout;
@interface CommentCell : UITableViewCell<WXLabelDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet WXLabel *comment;
@property (nonatomic, strong)CommentLayout *commentLayout;


@end
