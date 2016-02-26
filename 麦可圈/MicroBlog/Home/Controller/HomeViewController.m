//
//  HomeViewController.m
//  MicroBlog
//
//  Created by 李迪琛 on 16/1/11.
//  Copyright © 2016年 Dominic. All rights reserved.
//

#import "HomeViewController.h"
#import "SinaWeibo.h"
#import "AppDelegate.h"
#import "HomeModel.h"
#import "HomeTableCell.h"
#import "WeiboLayoutFrame.h"
#import "CommentViewController.h"
#import "MessageTableView.h"
#import "WXRefresh.h"

#define kHomeCell @"homeTableCell"

@interface HomeViewController ()<SinaWeiboRequestDelegate>
{
    NSString *_urlString;
}

@end

@implementation HomeViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kImageViewNotification object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    if (![self sinaWeibo].isAuthValid) {
        [[self sinaWeibo] logIn];
    }
    if ([[self sinaWeibo] isLoggedIn]) {
        
        NSDictionary *dic = @{
                              @"count":@"20"
                              };
        
        [[self sinaWeibo]requestWithURL:@"statuses/home_timeline.json" params:[dic mutableCopy] httpMethod:@"GET" delegate:self];
    }

}

-(void)awakeFromNib
{
     [super awakeFromNib];
   
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(change) name:kImageViewNotification object:nil];
    
    self.navigationController.navigationBar.translucent = NO;
    
    _urlString = @"statuses/home_timeline.json";
    
    __weak HomeViewController *weakSelf = self;
    [weakSelf.tableView addPullDownRefreshBlock:^{
        [weakSelf uploadTop];
    }];
    [weakSelf.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf uploadBottom];
    }];
    [self uploadTop];
}

- (void)change
{
     [self.tableView reloadData];
}

- (SinaWeibo *)sinaWeibo
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.sinaWeibo;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)request:(SinaWeiboRequest *)request didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"登录成功");
}

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"出现错误，错误是%@",error);
}
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    NSLog(@"%@",result);
    NSArray *statuses = [result objectForKey:@"statuses"];
    
    _models = [NSMutableArray arrayWithCapacity:statuses.count];
    
    for (NSDictionary *status in statuses) {
        HomeModel *model = [[HomeModel alloc] initWithDictionary:status error:nil];
        WeiboLayoutFrame *layoutFrame = [[WeiboLayoutFrame alloc] init];
        layoutFrame.homeModel = model;
        [self.models addObject:layoutFrame];
    }
    [self.tableView reloadData];
   
}

- (void)uploadTop
{
    long since_id = 0;
    if (self.models.count > 0) {
        
        WeiboLayoutFrame *layoutFrame = self.models[0];
        since_id = layoutFrame.homeModel.id;
    }
    
    AppDelegate *aDelegant = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[NSString stringWithFormat:@"%ld",since_id] forKey: @"since_id"];
    
    [aDelegant.sinaWeibo requestWithURL:_urlString params:dic httpMethod:@"GET" finishBlock:^(SinaWeiboRequest *request, id result) {
        
        [self loadDataFinish:result IsSinceID:YES];
        
    } failBlock:^(SinaWeiboRequest *request, NSError *error) {
        
        [self loadDataFail:error];
    }];
}

- (void)uploadBottom
{
    long max_id = 0;
    if (self.models.count > 0) {
        
        WeiboLayoutFrame *layoutFrame = [self.models lastObject];
        max_id = layoutFrame.homeModel.id;
    }
    
    AppDelegate *aDelegant = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[NSString stringWithFormat:@"%ld",max_id] forKey: @"max_id"];
    [aDelegant.sinaWeibo requestWithURL:_urlString params:dic httpMethod:@"GET" finishBlock:^(SinaWeiboRequest *request, id result) {
        [self loadDataFinish:result IsSinceID:NO];
    } failBlock:^(SinaWeiboRequest *request, NSError *error) {
        [self loadDataFail:error];
    }];
}

- (void)loadDataFinish:(id)result IsSinceID:(BOOL)isSinceID
{
    NSMutableArray *array = [NSMutableArray array];
    NSArray *arr = result[@"statuses"];
    for (NSDictionary *dic in arr) {
        HomeModel *model = [[HomeModel alloc] initWithDictionary:dic error:NULL];
        WeiboLayoutFrame *weiboLayout = [[WeiboLayoutFrame alloc] init];
        weiboLayout.homeModel = model;
        [array addObject:weiboLayout];
    }
    if (array.count > 0) {
        if (isSinceID) {
            [array addObjectsFromArray:self.models];
            self.models = array;
        }else
        {
            WeiboLayoutFrame *last = [self.models lastObject];
            WeiboLayoutFrame *first = array[0];
            if (last.homeModel.id == first.homeModel.id) {
                [array removeObject:first];
            }
            if (array.count > 0) {
                [self.models addObjectsFromArray:array];
            }
        }
        [self.tableView reloadData];
    }
    [self stopRefresh];
}

-(void)loadDataFail:(NSError *)error
{
    [self stopRefresh];
}

- (void)stopRefresh
{
    [self.tableView.pullToRefreshView stopAnimating];
    [self.tableView.infiniteScrollingView stopAnimating];
}



#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:kHomeCell forIndexPath:indexPath];
    cell.weiboLayoutModel = _models[indexPath.row];
    cell.backgroundColor = nil;

    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeiboLayoutFrame *frame = _models[indexPath.row];
    CGFloat height = frame.weiboFrame.size.height;
    return height + 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *stb = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
    CommentViewController *commentVC = [stb instantiateViewControllerWithIdentifier:@"commentVC"];
    commentVC.weiboLayout = self.models[indexPath.row];
    [self.navigationController pushViewController:commentVC animated:YES];
    
    //退出来取消选择状态
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
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
