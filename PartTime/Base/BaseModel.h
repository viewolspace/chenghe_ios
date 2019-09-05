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

@property (nonatomic,copy)NSString *message;
@property (nonatomic,copy)NSString *status;

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
@property (nonatomic,assign)NSInteger cTime;
/** 精选列表图片 */
@property (nonatomic,copy)NSString *pic;
/** 是否认证 */
@property (nonatomic ,assign)int verify;

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



/** 点击广告 */
@interface PartTimeAdClickModel : BaseModel

+ (void)requestClickADWithAdId:(int)adId
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



@interface PartTimeCategoryModel : BaseModel

@property (nonatomic,copy)NSArray <PartTimeModel *>*modelArr;
@property (nonatomic,copy)NSString *name;
/** 根据广告id查询内容 */
+ (void)requestPartTimeWithCategoryId:(NSString *)categoryId
                            pageIndex:(NSInteger)pageIndex
                             pageSize:(NSInteger)pageSize
                        completeBlock:(CompleteBlock)completeBlock
                           faileBlock:(FaileBlock)faileBlock;

@end


@interface PartTimeUserJoinModel : BaseModel

@property (nonatomic ,assign)int flag;


/** 参加兼职 */
+ (void)requestJoinPartTimeWithUserId:(NSInteger)userId
                                  aid:(NSInteger)aid
                        completeBlock:(CompleteBlock)completeBlock
                           faileBlock:(FaileBlock)faileBlock;

@end



/** 我的兼职 */
@interface PTMyPartTimeModel : BaseModel

@property (nonatomic,copy)NSArray <PartTimeModel *>*modelArr;

+ (void)requestMyPartTimeWithUserId:(NSInteger)userId
                          pageIndex:(NSInteger)pageIndex
                           pageSize:(NSInteger)pageSize
                      completeBlock:(CompleteBlock)completeBlock
                         faileBlock:(FaileBlock)faileBlock;

@end



/** 兼职详情查询 */
@interface PartTimeDetailModel : BaseModel

@property (nonatomic,strong)PartTimeModel *model;
@property (nonatomic,assign)BOOL isJoin; //0 未报名 1 已报名
@property (nonatomic,assign)int star; //星星数量
@property (nonatomic,copy)NSString *logo; //公司logo
@property (nonatomic,copy)NSString *qq;
@property (nonatomic,copy)NSString *wx;
@property (nonatomic,copy)NSString *phone;
@property (nonatomic,assign)int comId; //公司id
@property (nonatomic,copy)NSString *des; //公司描述
@property (nonatomic,copy)NSString *name; //公司名称



+ (void)requestDetailPartTimeWithUserId:(NSInteger)userId
                                    aid:(NSInteger)aid
                          completeBlock:(CompleteBlock)completeBlock
                             faileBlock:(FaileBlock)faileBlock;

@end




/** rId 1 热门 2 精选 */
@interface PTHomePageModel : BaseModel

@property (nonatomic,copy)CompleteBlock completeBlock;
@property (nonatomic,copy)NSArray <PartTimeModel *>*modelArr;



+ (void)requestHotOrChoiseWithId:(int)rId
                       pageIndex:(NSInteger)pageIndex
                        pageSize:(NSInteger)pageSize
                   completeBlock:(CompleteBlock)completeBlock
                      faileBlock:(FaileBlock)faileBlock;

@end



#pragma mark --------------User-----------------
/** 用户信息 */
@interface UserModel : BaseModel

/** userId */
@property (nonatomic,assign)NSInteger userId;
/** 手机 */
@property (nonatomic,copy)NSString *phone;
/** */
@property (nonatomic,copy)NSString *pwd;
/** */
@property (nonatomic,copy)NSString *idfa;
/** 头像 */
@property (nonatomic,copy)NSString *headPic;
/** 创建时间 */
@property (nonatomic,copy)NSString *cTime;
/** 修改时间 */
@property (nonatomic,copy)NSString *mTime;
/** 真是姓名 */
@property (nonatomic,copy)NSString *realName;
/** 昵称 */
@property (nonatomic,copy)NSString *nickName;
/** 性别 */
@property (nonatomic,assign)int sex;
/** 生日 */
@property (nonatomic,copy)NSString *birthday;
/** 工作经验 */
@property (nonatomic,copy)NSString *exp;
/** 自我介绍 */
@property (nonatomic,copy)NSString *des;


@end

/** 获取token (getToken)*/
@interface PartTimeUserGetTokenModel : BaseModel

@property (nonatomic,copy)NSString *token;

/** 获取token (getToken)*/
+ (void)requestTokenWithPhone:(NSString *)phone
                completeBlock:(CompleteBlock)completeBlock
                   faileBlock:(FaileBlock)faileBlock;

@end



/** copy 调用接口 */
@interface PartTimeCopyModel : BaseModel

+ (void)requestTokenWithId:(NSInteger)aId
             completeBlock:(CompleteBlock)completeBlock
                faileBlock:(FaileBlock)faileBlock;

@end


/** 获取验证码 (getRand)*/
@interface PartTimeUserGetRandModel : BaseModel

@property (nonatomic,copy)NSString *rand;

/** 获取验证码 (getRand)*/
+ (void)requestTokenWithPhone:(NSString *)phone
                        token:(NSString *)token
                completeBlock:(CompleteBlock)completeBlock
                   faileBlock:(FaileBlock)faileBlock;

@end



/** 登录状态下获取user信息 (getUser) */
@interface PartTimeUserGetInfoModel : BaseModel

/** 登录状态下获取user信息 (getUser) */
+ (void)requestUserWithUserId:(NSInteger)userId
                completeBlock:(CompleteBlock)completeBlock
                   faileBlock:(FaileBlock)faileBlock;

@end



@interface PartTimeUserUpDateInfoModel : BaseModel
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
                       realName:(NSString *)realName
                  completeBlock:(CompleteBlock)completeBlock
                     faileBlock:(FaileBlock)faileBlock;

@end




/** 修改昵称 */
@interface PartTimeUserChangeNameModel : BaseModel


+ (void)requestNickName:(NSString *)nickName
                 userId:(NSInteger)userId
          completeBlock:(CompleteBlock)completeBlock
             faileBlock:(FaileBlock)faileBlock;

@end


/** 首次激活登录 (active) */
@interface PartTimeUserFirstActiveModel: BaseModel
/** 首次激活登录 (active) */
+ (void)requestFirstActiveCompleteBlock:(CompleteBlock)completeBlock
                             faileBlock:(FaileBlock)faileBlock;

@end


/** 手机号验证码登录 (login) */
@interface PartTimeUserLoginModel : BaseModel


@property (nonatomic,strong)UserModel *model;

/** 手机号验证码登录 (login) */
+ (void)requestLoginWithPhone:(NSString *)phone
                         rand:(NSString *)rand
                completeBlock:(CompleteBlock)completeBlock
                   faileBlock:(FaileBlock)faileBlock;

@end

NS_ASSUME_NONNULL_END
