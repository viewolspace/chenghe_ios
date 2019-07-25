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
        PTHotAndChoiceRecommentModel *model = [PTHotAndChoiceRecommentModel new];
        [model setValuesForKeysWithDictionary:resultDic];
        [arr addObject:model];
    }
    
    _modelArr = arr;
    completeBlock(self);
    NSLog(@"热门or精选 %@ %@",message,status);
}


+ (void)requestHotOrChoiseWithId:(int)rId
                       pageIndex:(int)pageIndex
                        pageSize:(int)pageSize
                   completeBlock:(CompleteBlock)completeBlock
                      faileBlock:(FaileBlock)faileBlock
{
    NSString *hotUrl = [NSString stringWithFormat:@"%@partTime/queryRecommnet?recomment=%d&pageIndex=%d&pageSize=%d",PartTimeAddress,rId,pageIndex,pageSize];
    
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
