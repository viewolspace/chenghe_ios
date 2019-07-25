//
//  PTHomePageModel.m
//  PartTime
//
//  Created by Mac on 2019/7/22.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "PTHomePageModel.h"

@implementation PTHomePageModel

- (void)jsonToObject:(NSDictionary *)dic
       completeBlock:(nonnull CompleteBlock)completeBlock
{
    NSString *message = dic[@"message"];
    NSString *status  = dic[@"status"];
    NSArray *resultArr = dic[@"result"];
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:resultArr.count];
    for (NSDictionary *resultDic in resultArr) {
        PartTimeModel *model = [PartTimeModel new];
        [model setValuesForKeysWithDictionary:resultDic];
        [model calculateCellHeight];
        [arr addObject:model];
    }
    
    _modelArr = arr;
    completeBlock(self);
    NSLog(@"热门or精选 %@ %@",message,status);
}


+ (void)requestHotOrChoiseWithId:(int)rId
                       pageIndex:(NSInteger)pageIndex
                        pageSize:(NSInteger)pageSize
                   completeBlock:(CompleteBlock)completeBlock
                      faileBlock:(FaileBlock)faileBlock
{
    NSString *hotUrl = [NSString stringWithFormat:@"%@partTime/queryRecommnet?recommend=%d&pageIndex=%ld&pageSize=%ld",PartTimeAddress,rId,pageIndex,pageSize];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:hotUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        PTHomePageModel *model = [PTHomePageModel new];
        [model jsonToObject:responseObject completeBlock:completeBlock];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faileBlock(error);
    }];
}

@end


@implementation PTHotAndChoiceRecommentModel
@end
