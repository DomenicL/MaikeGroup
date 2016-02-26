//
//  RightViewController.m
//  MicroBlog
//
//  Created by 李迪琛 on 16/1/21.
//  Copyright © 2016年 Dominic. All rights reserved.
//

#import "RightViewController.h"
#import "NavigationController.h"

@interface RightViewController ()

@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _writeBtn.buttonName = @"newbar_icon_1@2x.png";
    _camaraBtn.buttonName = @"newbar_icon_2@2x.png";
    _photoBtn.buttonName = @"newbar_icon_3@2x.png";
    _videoBtn.buttonName = @"newbar_icon_2@2x.png";
    _multBtn.buttonName = @"newbar_icon_4@2x.png";
    _locationBtn.buttonName = @"newbar_icon_5@2x.png";
}

- (IBAction)writeBegin:(id)sender {
    UIButton *button = sender;
    switch (button.tag) {
        case 300:
        {

//            [self presentViewController:[[UIViewController alloc] init] animated:YES completion:NULL];
        }
            break;
            
        default:
            break;
    }
    
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
