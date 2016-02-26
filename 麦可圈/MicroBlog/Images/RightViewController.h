//
//  RightViewController.h
//  MicroBlog
//
//  Created by 李迪琛 on 16/1/21.
//  Copyright © 2016年 Dominic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightViewController : UIViewController

@property (weak, nonatomic) IBOutlet BaseButton *writeBtn;
@property (weak, nonatomic) IBOutlet BaseButton *camaraBtn;
@property (weak, nonatomic) IBOutlet BaseButton *photoBtn;
@property (weak, nonatomic) IBOutlet BaseButton *videoBtn;
@property (weak, nonatomic) IBOutlet BaseButton *multBtn;
@property (weak, nonatomic) IBOutlet BaseButton *locationBtn;
- (IBAction)writeBegin:(id)sender;

@end
