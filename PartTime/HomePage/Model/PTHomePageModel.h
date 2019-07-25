//
//  PTHomePageModel.h
//  PartTime
//
//  Created by Mac on 2019/7/22.
//  Copyright © 2019 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class PTHotAndChoiceRecommentModel;

@interface PTHomePageModel : NSObject

@property (nonatomic,copy)CompleteBlock completeBlock;
@property (nonatomic,copy)NSArray <PTHotAndChoiceRecommentModel *>*modelArr;


/**
  rId 1 热门 2 精选
 */
+ (void)requestHotOrChoiseWithId:(int)rId
                       pageIndex:(int)pageIndex
                        pageSize:(int)pageSize
                   completeBlock:(CompleteBlock)completeBlock
                      faileBlock:(FaileBlock)faileBlock;

@end

@interface PTHotAndChoiceRecommentModel : NSObject

@property (nonatomic,assign)int aId;
@property (nonatomic,assign)int companyId;
@property (nonatomic,assign)int recommend;
@property (nonatomic,copy)NSString *categoryId;
@property (nonatomic,copy)NSString *categoryName;
@property (nonatomic,assign)int topNum;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,assign)int salary;
@property (nonatomic,assign)int cycle;
@property (nonatomic,copy)NSString *lable;
@property (nonatomic,assign)int contactType;
@property (nonatomic,copy)NSString *contact;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,assign)int num;
@property (nonatomic,copy)NSString *workTime;
@property (nonatomic,copy)NSString *workAddress;
@property (nonatomic,assign)int status;
@property (nonatomic,copy)NSString *getsTime;
@property (nonatomic,assign)int browseNum;
@property (nonatomic,assign)int copyNum;
@property (nonatomic,assign)int joinNum;
@property (nonatomic,copy)NSString *getcTime;

@end

NS_ASSUME_NONNULL_END
