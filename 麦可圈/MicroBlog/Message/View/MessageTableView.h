//
//  MessageTableView.h
//  MicroBlog
//
//  Created by 李迪琛 on 16/1/21.
//  Copyright © 2016年 Dominic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)NSMutableArray *layoutModels;

@end
