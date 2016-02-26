//
//  MessageViewController.m
//  MicroBlog
//
//  Created by 李迪琛 on 16/1/11.
//  Copyright © 2016年 Dominic. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageTableView.h"
#import "WXRefresh.h"
#import "AppDelegate.h"
#import "SinaWeibo.h"
#import "WeiboLayoutFrame.h"

#define kATme @"statuses/mentions.json"

@interface MessageViewController ()
{
    NSString *_urlString;
}
@property (weak, nonatomic) IBOutlet MessageTableView *messageTV;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _urlString = kATme;
    self.navigationController.navigationBar.translucent = NO;
    [self _createButton];
    
    [_messageTV addPullDownRefreshBlock:^{
        [self uploadTop];
    }];
    [_messageTV addInfiniteScrollingWithActionHandler:^{
        [self uploadBottom];
    }];
    [self uploadTop];
}

- (void)_createButton
{
    NSArray *fourButton = @[[UIImage imageNamed:@"navigationbar_mentions"],[UIImage imageNamed:@"navigationbar_comments"],[UIImage imageNamed:@"navigationbar_messages"],[UIImage imageNamed:@"navigationbar_notice"]];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    for (int i = 0; i < fourButton.count; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(50 * i + 10, 5, 30, 30)];
        button.tag = 1000 + i;
        button.showsTouchWhenHighlighted = YES;
        [button setImage:fourButton[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(titleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:button];
    }
    self.navigationItem.titleView = titleView;
}

- (void)uploadTop
{
    long since_id = 0;
    if (_messageTV.layoutModels.count > 0) {
        
        WeiboLayoutFrame *layoutFrame = _messageTV.layoutModels[0];
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
    if (_messageTV.layoutModels.count > 0) {
        
        WeiboLayoutFrame *layoutFrame = [_messageTV.layoutModels lastObject];
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
            [array addObjectsFromArray:_messageTV.layoutModels];
            _messageTV.layoutModels = array;
        }else
        {
            WeiboLayoutFrame *last = [_messageTV.layoutModels lastObject];
            WeiboLayoutFrame *first = array[0];
            if (last.homeModel.id == first.homeModel.id) {
                [array removeObject:first];
            }
            if (array.count > 0) {
                [_messageTV.layoutModels addObjectsFromArray:array];
            }
        }
        [_messageTV reloadData];
    }
    [self stopRefresh];
}

-(void)loadDataFail:(NSError *)error
{
    [self stopRefresh];
}

- (void)stopRefresh
{
    [_messageTV.pullToRefreshView stopAnimating];
    [_messageTV.infiniteScrollingView stopAnimating];
}

- (void)titleButtonAction:(UIButton *)sender
{
    
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
