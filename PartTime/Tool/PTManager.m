//
//  PTManager.m
//  PartTime
//
//  Created by Mac on 2019/7/23.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "PTManager.h"
static PTManager *manager = nil;
@implementation PTManager

+ (PTManager *)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[super allocWithZone:NULL] init];
        }
    });
    
    return manager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [PTManager shareManager];
}


+ (AFHTTPSessionManager *)shareAFManager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *userStr = [NSString stringWithFormat:@"%ld",[PTUserUtil getUserId]];
    [manager.requestSerializer setValue:userStr forHTTPHeaderField:@"userId"];
    
    return manager;
}

@end
