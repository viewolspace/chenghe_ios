//
//  PTTabbarViewController.m
//  PartTime
//
//  Created by Mac on 2019/7/22.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "PTTabbarViewController.h"
@interface PTTabbarViewController ()

@end

@implementation PTTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //初始化
    PTManager *manager = [PTManager shareManager];
    CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
    manager.statusBarHeight = statusRect.size.height;
    manager.tabbarHeight    = self.tabBar.height;
    
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
