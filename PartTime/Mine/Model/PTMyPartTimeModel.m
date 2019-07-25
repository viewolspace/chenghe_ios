//
//  PTMyPartTimeModel.m
//  PartTime
//
//  Created by Mac on 2019/7/25.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "PTMyPartTimeModel.h"

@implementation PTMyPartTimeModel

- (void)jsonToObject:(NSDictionary *)dic
       completeBlock:(CompleteBlock)completeBlock
{
    NSString *message = dic[@"message"];
    NSString *status  = dic[@"status"];
    NSArray *resultArr = dic[@"result"];
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:resultArr.count];
    for (NSDictionary *resultDic in resultArr) {
        PartTimeModel *model = [PartTimeModel new];
        [model setValuesForKeysWithDictionary:resultDic];
        [arr addObject:model];
    }
    
    _modelArr = arr;
    NSLog(@"热门or精选 %@ %@",message,status);
    NSLog(@"%@",dic);
    completeBlock(self);
}

+ (void)requestMyPartTimeWithUserId:(NSInteger)userId
                          pageIndex:(NSInteger)pageIndex
                           pageSize:(NSInteger)pageSize
                      completeBlock:(CompleteBlock)completeBlock
                         faileBlock:(FaileBlock)faileBlock
{
    NSString *myPartTimeUrl = [NSString stringWithFormat:@"%@partTime/queryMyPartTime?userId=%ld&pageIndex=%ld&pageSize=%ld",PartTimeAddress,userId,pageIndex,pageSize];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:myPartTimeUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        PTMyPartTimeModel *model = [PTMyPartTimeModel new];
        [model jsonToObject:responseObject completeBlock:completeBlock];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        faileBlock(error);
    }];
}

@end
