//
//  PTHomePageModel.h
//  PartTime
//
//  Created by Mac on 2019/7/22.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@class PTHotAndChoiceRecommentModel;

@interface PTHomePageModel : BaseModel

@property (nonatomic,copy)CompleteBlock completeBlock;
@property (nonatomic,copy)NSArray <PTHotAndChoiceRecommentModel *>*modelArr;


/**
  rId 1 热门 2 精选
 */
+ (void)requestHotOrChoiseWithId:(int)rId
                       pageIndex:(NSInteger)pageIndex
                        pageSize:(NSInteger)pageSize
                   completeBlock:(CompleteBlock)completeBlock
                      faileBlock:(FaileBlock)faileBlock;

@end

@interface PTHotAndChoiceRecommentModel : PartTimeModel


@end

NS_ASSUME_NONNULL_END
