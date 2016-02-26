//
//  MessageTableView.m
//  MicroBlog
//
//  Created by 李迪琛 on 16/1/21.
//  Copyright © 2016年 Dominic. All rights reserved.
//

#import "MessageTableView.h"
#import "HomeTableCell.h"
#import "WeiboLayoutFrame.h"
#import "CommentViewController.h"
#import "HomeViewController.h"

@implementation MessageTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.layoutModels = [NSMutableArray array];
        
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.layoutModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *stb = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
    HomeViewController *viewController = (HomeViewController *)[stb instantiateViewControllerWithIdentifier:@"homeVC"];
    HomeTableCell *cell = (HomeTableCell *)[viewController.tableView dequeueReusableCellWithIdentifier:@"homeTableCell"];
    cell.weiboLayoutModel = _layoutModels[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeiboLayoutFrame *layout = self.layoutModels[indexPath.row];
    return layout.weiboFrame.size.height + 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *stbd = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
    CommentViewController *cmmtCtrl = [stbd instantiateViewControllerWithIdentifier:@"commentVC"];
    cmmtCtrl.weiboLayout = self.layoutModels[indexPath.row];
    [[self viewController].navigationController pushViewController:cmmtCtrl animated:YES];
    [self deselectRowAtIndexPath:indexPath animated:YES];
}

-(UIViewController *)viewController
{
    UIResponder *next = self.nextResponder;
    while (next != nil) {
        if ([next isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController *)next;
        }
        
        next = next.nextResponder;
    }
    
    return nil;
}
@end
