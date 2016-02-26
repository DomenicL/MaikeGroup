//
//  LeftTableViewController.m
//  MicroBlog
//
//  Created by 李迪琛 on 16/1/21.
//  Copyright © 2016年 Dominic. All rights reserved.
//

#import "LeftTableViewController.h"
#import "BaseLabel.h"
#import "MoreTableViewCell.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "MoreTableViewController.h"

@interface LeftTableViewController ()

@property(nonatomic, retain)NSMutableDictionary *dataDic;

@end

@implementation LeftTableViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _dataDic = [[NSMutableDictionary alloc] init];
        
        NSArray *arr = @[
                         @"无",
                         @"滑动",
                         @"滑动&缩放",
                         @"飘移门",
                         @"视差滑动"
                         ];
        [_dataDic setObject:arr forKey:@"界面切换动画"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _dataDic.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = [_dataDic allKeys][section];
    NSArray *arr = [_dataDic objectForKey:key];
    return arr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *kHeaderViewID = @"kHeaderViewID";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kHeaderViewID];
    if (!headerView) {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:kHeaderViewID];
        BaseLabel *baseLabel = [[BaseLabel alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 40)];
        baseLabel.tag = 2015;
        baseLabel.textAlignment = NSTextAlignmentCenter;
        baseLabel.font = [UIFont boldSystemFontOfSize:18];
        baseLabel.labelName = @"More_Item_Text_color";
        [headerView.contentView addSubview:baseLabel];
    }
    
    BaseLabel *label = (BaseLabel *)[headerView.contentView viewWithTag:2015];
    label.text = [_dataDic allKeys][section];
    
    return headerView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *stb = [UIStoryboard storyboardWithName:@"More" bundle:nil];
    
    MoreTableViewController *tableVC = (MoreTableViewController *)[stb instantiateViewControllerWithIdentifier:@"moreTableVC"];
    
    MoreTableViewCell *cell = (MoreTableViewCell *)[tableVC.tableView dequeueReusableCellWithIdentifier:@"moreCell"];
    
    NSString *key = [_dataDic allKeys][indexPath.section];
    NSArray *arr = [_dataDic objectForKey:key];
    
    NSString *imgName = [NSString stringWithFormat:@"00%ld@2x.png", indexPath.row+1];
    cell.icon.image = [UIImage imageNamed:imgName];
    cell.name.text = arr[indexPath.row];
    
    if (indexPath.section == 0) {
        MMDrawerAnimationType drawerType = [MMExampleDrawerVisualStateManager sharedManager].leftDrawerAnimationType;
        if (drawerType == indexPath.row) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        [MMExampleDrawerVisualStateManager sharedManager].leftDrawerAnimationType = indexPath.row;
        [MMExampleDrawerVisualStateManager sharedManager].rightDrawerAnimationType = indexPath.row;
        
        //写个方法保存到user default
        //[[MMExampleDrawerVisualStateManager sharedManager] saveConfig];
        
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
    }
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
