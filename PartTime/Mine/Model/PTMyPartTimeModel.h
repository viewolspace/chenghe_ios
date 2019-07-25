//
//  PTMyPartTimeModel.h
//  PartTime
//
//  Created by Mac on 2019/7/25.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTMyPartTimeModel : BaseModel

@property (nonatomic,copy)NSArray <PartTimeModel *>*modelArr;

+ (void)requestMyPartTimeWithUserId:(NSInteger)userId
                          pageIndex:(NSInteger)pageIndex
                           pageSize:(NSInteger)pageSize
                      completeBlock:(CompleteBlock)completeBlock
                         faileBlock:(FaileBlock)faileBlock;

@end

NS_ASSUME_NONNULL_END
