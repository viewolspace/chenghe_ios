//
//  UINavigationController+ClickAdCategory.m
//  PartTime
//
//  Created by Mac on 2019/7/26.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "UINavigationController+ClickAdCategory.h"
#import "PTDetailViewController.h"
#import "PTSignUpViewController.h"

@implementation UINavigationController (ClickAdCategory)

- (void)clickAdAction:(PartTimeAdModel *)model
              chileVC:(nonnull UIViewController *)chileVC
{
    NSURL *url = [NSURL URLWithString:model.adUrl];
    NSString *host = url.scheme;
    NSString *path = [url path];
    NSLog(@"scheme: %@", [url scheme]);
    NSLog(@"host: %@", host);
    NSLog(@"path: %@", path);
    NSDictionary *dic = [self queryComponents:url];
    
    if ([host isEqualToString:@"http"]) {
      
        PTWebViewController *vc = [[PTWebViewController alloc] init];
        vc.model = model;
        chileVC.hidesBottomBarWhenPushed = YES;
        [self pushViewController:vc animated:YES];
        chileVC.hidesBottomBarWhenPushed = NO;
        
    }else if([host isEqualToString:@"jzq"] && [path isEqualToString:@"/list"]){
        NSLog(@"跳转到列表页");
        PTSignUpViewController *vc = [PTSignUpViewController new];
        vc.categoryId = dic[@"categoryId"];
        chileVC.hidesBottomBarWhenPushed = YES;
        [self pushViewController:vc animated:YES];
        chileVC.hidesBottomBarWhenPushed = NO;
        
    }else if([host isEqualToString:@"jzq"] && [path isEqualToString:@"/detail"]){
        NSLog(@"跳转到具体详情页");
        int ptId = [dic[@"id"]intValue];
        chileVC.hidesBottomBarWhenPushed = YES;
        PTDetailViewController *vc = [[PTDetailViewController alloc] init];
        vc.ptId = ptId;
        [self pushViewController:vc animated:YES];
        chileVC.hidesBottomBarWhenPushed = NO;
    }
    
    //广告点击
    [PartTimeAdClickModel requestClickADWithAdId:model.adId completeBlock:^(id obj) {
        
    } faileBlock:^(id error) {
        
    }];
}

-(NSDictionary *)queryComponents:(NSURL *)url{
    
    NSArray *components = [[url query] componentsSeparatedByString:@"&"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    for (NSString *component in components) {
        NSArray *subcomponents = [component componentsSeparatedByString:@"="];
        if ([subcomponents count]<2) {
            continue;
        }
        [dic setObject:[subcomponents[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
                forKey:[subcomponents[0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    return dic;
}

@end
