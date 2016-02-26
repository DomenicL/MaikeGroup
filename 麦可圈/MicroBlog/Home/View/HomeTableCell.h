//
//  HomeTableCell.h
//  MicroBlog
//
//  Created by 李迪琛 on 16/1/13.
//  Copyright © 2016年 Dominic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboLayoutFrame.h"

@interface HomeTableCell : UITableViewCell<WXLabelDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet BaseLabel *nickName;
@property (weak, nonatomic) IBOutlet BaseLabel *time;
@property (weak, nonatomic) IBOutlet BaseLabel *sourceLabel;
@property (weak, nonatomic) IBOutlet WXLabel *content;

@property (weak, nonatomic) IBOutlet UIView *weiboView;

- (IBAction)repostButton:(id)sender;
- (IBAction)commentButton:(id)sender;
- (IBAction)perferButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *repost;
@property (weak, nonatomic) IBOutlet UIButton *comment;
@property (weak, nonatomic) IBOutlet UIButton *perfer;
@property (weak, nonatomic) IBOutlet WXLabel *retext;

//@property (weak, nonatomic) IBOutlet UIImageView *myImage;
@property (weak, nonatomic) IBOutlet UIView *reBackground;
//@property (weak, nonatomic) IBOutlet UIImageView *reImage;

@property (nonatomic, strong)NSMutableArray *imageArray;
@property (nonatomic, strong)NSMutableArray *reImageArray;

@property (nonatomic, strong)WeiboLayoutFrame *weiboLayoutModel;

@end
