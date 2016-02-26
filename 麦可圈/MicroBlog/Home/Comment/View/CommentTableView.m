//
//  CommentTableView.m
//  MicroBlog
//
//  Created by 李迪琛 on 16/1/20.
//  Copyright © 2016年 Dominic. All rights reserved.
//

#import "CommentTableView.h"
#import "CommentCell.h"
#import "CommentLayout.h"
@interface CommentTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation CommentTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        _models = [NSMutableArray array];
//        self.delegate = self;
//        self.dataSource = self;
//        
//        [self registerNib:[UINib nibWithNibName:@"CommentCell" bundle:nil] forCellReuseIdentifier:@"commentCell"];
//    }
//    return self;
//}

- (void)awakeFromNib
{
    _models = [NSMutableArray array];
    self.delegate = self;
    self.dataSource = self;
    
    [self registerNib:[UINib nibWithNibName:@"CommentCell" bundle:nil] forCellReuseIdentifier:@"commentCell"];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _models.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell" forIndexPath:indexPath];
    cell.commentLayout = _models[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentLayout *layout = _models[indexPath.row];
    return layout.cellHeight + 50;
}

@end
