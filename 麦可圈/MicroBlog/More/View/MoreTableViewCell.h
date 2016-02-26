//
//  MoreTableViewCell.h
//  MicroBlog
//
//  Created by 李迪琛 on 16/1/12.
//  Copyright © 2016年 Dominic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet BaseLabel *name;
@property (weak, nonatomic) IBOutlet BaseImageView *icon;
@property (weak, nonatomic) IBOutlet BaseLabel *themeText;


@end
