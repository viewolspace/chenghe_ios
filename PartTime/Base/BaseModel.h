//
//  BaseModel.h
//  PartTime
//
//  Created by Mac on 2019/7/25.
//  Copyright © 2019 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseModel : NSObject


/** 解析数据 */
- (void)jsonToObject:(NSDictionary *)dic
       completeBlock:(CompleteBlock)completeBlock;

@end


@interface PartTimeModel : BaseModel

@property (nonatomic,assign)int aId;

/** 公司id */
@property (nonatomic,assign)int companyId;
/** 1热门 2 精选 0 默认 */
@property (nonatomic,assign)int recommend;
/** 分类id */
@property (nonatomic,copy)NSString *categoryId;
/** 分类名称 */
@property (nonatomic,copy)NSString *categoryName;
/** 排序数 */
@property (nonatomic,assign)int topNum;
/** 标题 */
@property (nonatomic,copy)NSString *title;
/** 结算金额  */
@property (nonatomic,assign)int salary;
/** 结算周期 0 小时 1 天 2 周 3 月 4 季度 */
@property (nonatomic,assign)int cycle;
/** 标签 例如：日结 长期 男女不限 多个使用空格分开，客户端需要按照显示处理 */
@property (nonatomic,copy)NSString *lable;
/** 联系方式类型 1 qq 2 微信 3 手机 */
@property (nonatomic,assign)int contactType;
/** 具体的联系方式号码 */
@property (nonatomic,copy)NSString *contact;
/** 内容 */
@property (nonatomic,copy)NSString *content;
/** 招聘人数 */
@property (nonatomic,assign)int num;
/** 工作时间 */
@property (nonatomic,copy)NSString *workTime;
/** 工作地点 */
@property (nonatomic,copy)NSString *workAddress;
/** 创建、更新时间 */
@property (nonatomic,copy)NSString *cTime;
/** 精选列表图片 */
@property (nonatomic,copy)NSString *pic;


/** 详情页 如果内容过多，隐藏一部分 */
@property (nonatomic,assign)BOOL isHiddenContent;
@property (nonatomic,assign)CGFloat homePageCellHeight;
@property (nonatomic,assign)CGFloat detailTitleCellHeight;
@property (nonatomic,assign)CGFloat detailCompanyCellHeight;
/** 未展开信息的高度*/
@property (nonatomic,assign)CGFloat detailContentCellHeight;
/** 展开信息的高度 */
@property (nonatomic,assign)CGFloat detailContentRealCellHeight;
/** 可能有图片的cell类型高度 (搜索页面和精选页面) */
@property (nonatomic,assign)CGFloat havePicCellHeight;
/** cell里含有图片 */
@property (nonatomic,assign)BOOL haveImage;

@property (nonatomic,assign)int status;
@property (nonatomic,assign)int browseNum;
@property (nonatomic,assign)int copyNum;
@property (nonatomic,assign)int joinNum;
@property (nonatomic,copy)NSString *getcTime;


/** 首页格式的cell高度，无图片 */
- (void)calculateCellHeight;


/** 选中和搜索页面cell高度, 可能有图片 */
- (void)calculateHaveImageCellHeight;


@end



@interface PartTimeAdModel : BaseModel

@property (nonatomic,copy)NSArray <PartTimeAdModel *>*adModelArr;

@property (nonatomic,assign)int adId;
@property (nonatomic,strong)NSString *adTitle;
@property (nonatomic,strong)NSString *adUrl;
@property (nonatomic,strong)NSString *adImageUrl;

/** 查询广告 */
+ (void)requestADWithCategoryId:(NSString *)categoryId
                  completeBlock:(CompleteBlock)completeBlock
                     faileBlock:(FaileBlock)faileBlock;

@end


@interface PartTimeQueryModel : BaseModel

@property (nonatomic,copy)NSArray <PartTimeModel *>*modelArr;

/** 根据输入的关键词查询内容 */
+ (void)requestPartTimeWithKeyWord:(NSString *)keyWord
                         pageIndex:(NSInteger)pageIndex
                          pageSize:(NSInteger)pageSize
                     completeBlock:(CompleteBlock)completeBlock
                        faileBlock:(FaileBlock)faileBlock;
@end



@interface PartTimeJoinModel : BaseModel

/** 参加兼职 */
+ (void)requestJoinPartTimeWithUserId:(NSInteger)userId
                                  aid:(NSInteger)aid
                        completeBlock:(CompleteBlock)completeBlock
                           faileBlock:(FaileBlock)faileBlock;

@end

@interface PartTimeDetailModel : BaseModel

@property (nonatomic,strong)PartTimeModel *model;

/** 兼职详情查询 */
+ (void)requestDetailPartTimeWithUserId:(NSInteger)userId
                                    aid:(NSInteger)aid
                          completeBlock:(CompleteBlock)completeBlock
                             faileBlock:(FaileBlock)faileBlock;

@end




@interface PTHomePageModel : BaseModel

@property (nonatomic,copy)CompleteBlock completeBlock;
@property (nonatomic,copy)NSArray <PartTimeModel *>*modelArr;


/**
 rId 1 热门 2 精选
 */
+ (void)requestHotOrChoiseWithId:(int)rId
                       pageIndex:(NSInteger)pageIndex
                        pageSize:(NSInteger)pageSize
                   completeBlock:(CompleteBlock)completeBlock
                      faileBlock:(FaileBlock)faileBlock;

@end



#pragma mark --------------User-----------------
/** 获取token (getToken)*/
@interface UserGetTokenModel : BaseModel

@property (nonatomic,copy)NSString *token;

/** 获取token (getToken)*/
+ (void)requestTokenWithPhone:(NSString *)phone
                completeBlock:(CompleteBlock)completeBlock
                   faileBlock:(FaileBlock)faileBlock;

@end




/** 获取验证码 (getRand)*/
@interface UserGetRandModel : BaseModel

@property (nonatomic,copy)NSString *rand;

/** 获取验证码 (getRand)*/
+ (void)requestTokenWithPhone:(NSString *)phone
                        token:(NSString *)token
                completeBlock:(CompleteBlock)completeBlock
                   faileBlock:(FaileBlock)faileBlock;

@end



/** 手机号验证码登录 (getUser) */
@interface UserGerUserModel : BaseModel

/** 手机号验证码登录 (getUser) */
+ (void)requestUserWithUserId:(NSString *)userId
                completeBlock:(CompleteBlock)completeBlock
                   faileBlock:(FaileBlock)faileBlock;

@end



@interface UserUpdateUserModel : BaseModel
/**
 完善简历

 @param imageStr 图片base65
 @param exp 工作经验
 @param des 自我介绍
 */
+ (void)requestUserWithImageStr:(NSString *)imageStr
                            sex:(NSInteger)sex
                       birthday:(NSString *)birthday
                            exp:(NSString *)exp
                            des:(NSString *)des
                         userId:(NSInteger)userId
                  completeBlock:(CompleteBlock)completeBlock
                     faileBlock:(FaileBlock)faileBlock;

@end




/** 修改昵称 */
@interface UserUpdateNickName : BaseModel


+ (void)requestNickName:(NSString *)nickName
                 userId:(NSInteger)userId
          completeBlock:(CompleteBlock)completeBlock
             faileBlock:(FaileBlock)faileBlock;

@end


/** 首次激活登录 (active) */
@interface UserFirstActiveModel: BaseModel
/** 首次激活登录 (active) */
+ (void)requestFirstActiveCompleteBlock:(CompleteBlock)completeBlock
                             faileBlock:(FaileBlock)faileBlock;

@end


/** 手机号验证码登录 (login) */
@interface UserGetLoginModel : BaseModel
/** 手机号验证码登录 (login) */
+ (void)requestLoginWithPhone:(NSString *)phone
                         rand:(NSString *)rand
                completeBlock:(CompleteBlock)completeBlock
                   faileBlock:(FaileBlock)faileBlock;

@end

NS_ASSUME_NONNULL_END
