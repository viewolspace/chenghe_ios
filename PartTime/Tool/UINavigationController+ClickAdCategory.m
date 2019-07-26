//
//  UINavigationController+ClickAdCategory.m
//  PartTime
//
//  Created by Mac on 2019/7/26.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "UINavigationController+ClickAdCategory.h"

@implementation UINavigationController (ClickAdCategory)

- (void)clickAdAction:(PartTimeAdModel *)model
              chileVC:(nonnull UIViewController *)chileVC
{
    NSURL *url = [NSURL URLWithString:model.adUrl];
    NSString *host = url.scheme;
    
    if ([host isEqualToString:@"http"]) {
        PTWebViewController *vc = [[PTWebViewController alloc] init];
        vc.model = model;
        chileVC.hidesBottomBarWhenPushed = YES;
        [self pushViewController:vc animated:YES];
        chileVC.hidesBottomBarWhenPushed = NO;
    }
}

@end
