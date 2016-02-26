//
//  HomeViewController.h
//  MicroBlog
//
//  Created by 李迪琛 on 16/1/11.
//  Copyright © 2016年 Dominic. All rights reserved.
//

#import "BaseTableViewController.h"

@interface HomeViewController : BaseTableViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)NSMutableArray *models;

@end
