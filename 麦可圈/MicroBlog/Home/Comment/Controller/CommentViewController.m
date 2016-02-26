//
//  CommentViewController.m
//  MicroBlog
//
//  Created by 李迪琛 on 16/1/20.
//  Copyright © 2016年 Dominic. All rights reserved.
//

#import "CommentViewController.h"
#import "WeiboLayoutFrame.h"
#import "AppDelegate.h"
#import "SinaWeibo.h"
#import "CommentModel.h"
#import "CommentLayout.h"
#import "CommentTableView.h"
#import "HomeTableCell.h"
#import "HomeViewController.h"

@interface CommentViewController ()

@property (weak, nonatomic) IBOutlet CommentTableView *commentTV;

@end

@implementation CommentViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self _loadWebJson];
    [self _createHeadView];
}

- (void)_loadWebJson
{
    NSString *weiboID = [NSString stringWithFormat:@"%ld",self.weiboLayout.homeModel.id];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:weiboID forKey:@"id"];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.sinaWeibo requestWithURL:@"comments/show.json" params:dic httpMethod:@"GET" finishBlock:^(SinaWeiboRequest *request, id result) {
        NSLog(@"1-----%@",result);
        [self saveInModel:result];
        
    } failBlock:^(SinaWeiboRequest *request, NSError *error) {
        
    }];
}

- (void)_createHeadView
{
    UIStoryboard *stb = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
    HomeViewController *viewController = (HomeViewController *)[stb instantiateViewControllerWithIdentifier:@"homeVC"];
    HomeTableCell *cellHead = (HomeTableCell *)[viewController.tableView dequeueReusableCellWithIdentifier:@"homeTableCell"];
    cellHead.weiboLayoutModel = self.weiboLayout;
    cellHead.frame = CGRectMake(CGRectGetMinX(_commentTV.frame), CGRectGetMinY(_commentTV.frame), CGRectGetWidth(_commentTV.frame), self.weiboLayout.weiboFrame.size.height + 60);
    cellHead.contentView.frame = cellHead.frame;
    cellHead.backgroundColor = [UIColor clearColor];
    self.commentTV.tableHeaderView = cellHead;
    
}

- (void)saveInModel:(id)result
{
    NSArray *arr = [result objectForKey:@"comments"];
    NSMutableArray *comments = [NSMutableArray arrayWithCapacity:arr.count];
    for (NSDictionary *dic in arr) {
        CommentModel *model = [[CommentModel alloc] initWithDictionary:dic error:nil];
        CommentLayout *layout = [[CommentLayout alloc] init];
        layout.commentModel = model;
        [comments addObject:layout];
    }
    _commentTV.models = comments;
    [_commentTV reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
