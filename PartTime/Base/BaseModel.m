//
//  BaseModel.m
//  PartTime
//
//  Created by Mac on 2019/7/25.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (void)jsonToObject:(NSDictionary *)dic
       completeBlock:(CompleteBlock)completeBlock
{}

@end

@implementation PartTimeModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.aId = [value intValue];
    }
}


/** 详情页 内容高度 */
- (void)calculateDetailContentHeight
{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 5.f;
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:16.f],NSForegroundColorAttributeName:[PTTool colorFromHexRGB:@"#656565"],NSParagraphStyleAttributeName:style};
    
    //标题高度
    CGFloat titleHeight = 21.5;
    
    //内容高度
    CGFloat contentHeight = [self.content boundingRectWithSize:CGSizeMake(WIDTH_OF_SCREEN - 14 * 2.0, 0) options:1 attributes:dic context:nil].size.height;
    
    CGFloat btnHeight = 44.f;
    //page
    CGFloat page = 22 + 22 + 20;
    
    self.detailContentRealCellHeight = page + titleHeight + contentHeight + btnHeight;
    self.detailContentCellHeight = self.detailContentRealCellHeight;
    
    if (self.detailContentCellHeight > 336.f) {
        self.detailContentCellHeight = 336.f;
        self.isHiddenContent = NO;
    }else{
        //减去按钮的高度，隐藏按钮
        self.detailContentCellHeight -= btnHeight;
        self.detailContentRealCellHeight -= btnHeight;
        self.isHiddenContent = YES;
    }
    
    
    
}

/** 详情页公司高度 */
- (void)calculateDetailCompanyHeight
{
    //标题高
    CGFloat titHeight = 25.f;
    
    //公司名称高度
    CGFloat companyNameHeight = [self.title boundingRectWithSize:CGSizeMake(WIDTH_OF_SCREEN - 80 - 94, 0) options:1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.f]} context:nil].size.height;
    
    //subTitle高度
    CGFloat subHeight = 16.f;
    
    //page
    CGFloat page = 22.f + 25.f + 18.f + 14.f + 19.f + 23.f;
    
    self.detailCompanyCellHeight = page + subHeight + companyNameHeight + titHeight + 50;
    
}

/** 详情页titleCell高度 */
- (void)calculateDetailTitleHeight
{
    CGFloat titleWidth = WIDTH_OF_SCREEN - 14.f * 2.0;
   
    UIFont *titleFont = [UIFont systemFontOfSize:21];
    UIFont *subFont   = [UIFont systemFontOfSize:13.f];
    
    //标题高度
    CGFloat titleHeight = [self.title boundingRectWithSize:CGSizeMake(titleWidth, 0) options:1 attributes:@{NSFontAttributeName:titleFont} context:nil].size.height;
    
    //更新时间高度
    CGFloat upDateHeight = 16.f;
    
    //薪水高度
    CGFloat payHeight = 27.5;
    
    //sub title 高度
    CGFloat labelPage = 5.f;
    CGFloat textPage = 9.f;
    NSArray *subLabels = [self.lable componentsSeparatedByString:@" "];
    CGFloat right = 0;
    CGFloat top = 2;
    CGFloat subHeight = 30;
    for (int i = 0; i < subLabels.count; i ++) {
        NSString *subTitle = subLabels[i];
        CGFloat width = [subTitle boundingRectWithSize:CGSizeMake(0, 13.f) options:1 attributes:@{NSFontAttributeName:subFont} context:nil].size.width;
        
        if (width + right + textPage * 2.0 > WIDTH_OF_SCREEN - 28) {
            top += 30;
            right = 0;
        }
        
        right = right + width + textPage * 2.0 + labelPage;
    }
    
    subHeight = top + subHeight;
    
    //工作时间高度
    NSString *workTimes = [NSString stringWithFormat:@"工作时间：%@",self.workTime];
    CGFloat timeHeight = [workTimes boundingRectWithSize:CGSizeMake(titleWidth, 0) options:1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.f]} context:nil].size.height;
    
    //工作地点高度
    NSString *workAddress = [NSString stringWithFormat:@"工作地点：%@",self.workAddress];
    CGFloat workAddressHeight = [workAddress boundingRectWithSize:CGSizeMake(titleWidth, 0) options:1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.f]} context:nil].size.height;
    
    //按钮高度
    CGFloat btnHeight = 40.f;
    
    //page
    CGFloat page = 22.f + 11.f + 15.f + 15.f + 26.f + 16.f + 21.f + 21.f;
    
    self.detailTitleCellHeight = titleHeight + upDateHeight + payHeight + subHeight +   timeHeight + workAddressHeight  + page + btnHeight;
}

- (void)calculateCellHeight
{
    CGFloat titleWidth = WIDTH_OF_SCREEN - 130.f;
    UIFont *titleFont = [UIFont systemFontOfSize:16.f];
    UIFont *subFont   = [UIFont systemFontOfSize:13.f];
    //标题高度
    CGFloat titleHeight = [self.title boundingRectWithSize:CGSizeMake(titleWidth, 0) options:1 attributes:@{NSFontAttributeName:titleFont} context:nil].size.height;
    
    //薪水高度
    CGFloat payHeight = 27.5;
    
    //subTitle高度
    CGFloat subHeight = [self.lable boundingRectWithSize:CGSizeMake(titleWidth, 0) options:1 attributes:@{NSFontAttributeName:subFont} context:nil].size.height;
    
    CGFloat page = 20 + 12 + 12 + 22;
    
    self.homePageCellHeight = page + titleHeight + subHeight + payHeight;
    
}

- (void)calculateHaveImageCellHeight
{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 5.f;
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:17.f],NSForegroundColorAttributeName:[PTTool colorFromHexRGB:@"#2a2a2a"],NSParagraphStyleAttributeName:style};
    CGFloat titleWidth = WIDTH_OF_SCREEN - 14 * 2.0;
   
    //标题高度
    CGFloat titleHeight = [self.title boundingRectWithSize:CGSizeMake(titleWidth, 0) options:1 attributes:dic context:nil].size.height;
    
    //sub高度
    CGFloat subHeight = 30.f;
    
    //图片高度
    CGFloat picHeight = 93.f;
    if (self.haveImage) {
        picHeight = 93.f;
    }else{
        picHeight = 0.f;
    }
    
    //page
    CGFloat page = 24 + 15 + 24;
    
    self.havePicCellHeight = titleHeight + subHeight + picHeight + page;
    
}

@end

@implementation ADModel

- (void)jsonToObject:(NSDictionary *)dic
       completeBlock:(CompleteBlock)completeBlock
{
    NSLog(@"%@",dic);
}

+ (void)requestADWithCategoryId:(NSString *)categoryId
                  completeBlock:(CompleteBlock)completeBlock
                     faileBlock:(FaileBlock)faileBlock
{
    NSString *myPartTimeUrl = [NSString stringWithFormat:@"%@ad/queryAdList?id=%@",PartTimeAddress,categoryId];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:myPartTimeUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ADModel *model = [ADModel new];
        [model jsonToObject:responseObject completeBlock:completeBlock];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        faileBlock(error);
    }];
}


@end


#pragma mark -------- 根据关键词查询兼职内容 --------
@implementation QueryPartTimeModel

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
        [model calculateHaveImageCellHeight];
        [arr addObject:model];
    }
    NSLog(@"查询 %@ %@",message,status);

    _modelArr = arr;
    completeBlock(self);
}

+ (void)requestPartTimeWithKeyWord:(NSString *)keyWord
                         pageIndex:(NSInteger)pageIndex
                          pageSize:(NSInteger)pageSize
                     completeBlock:(CompleteBlock)completeBlock
                        faileBlock:(FaileBlock)faileBlock
{
    NSString *partTimeUrl = [NSString stringWithFormat:@"%@partTime/queryAll?keyWord=%@&pageIndex=%ld&pageSize=%ld",PartTimeAddress,keyWord,pageIndex,pageSize];
    partTimeUrl = [partTimeUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:partTimeUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        QueryPartTimeModel *model = [QueryPartTimeModel new];
        [model jsonToObject:responseObject completeBlock:completeBlock];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        faileBlock(error);
    }];
}

@end


@implementation JoinPartTimeModel

- (void)jsonToObject:(NSDictionary *)dic
       completeBlock:(CompleteBlock)completeBlock
{
    NSLog(@"%@",dic);
}

+ (void)requestJoinPartTimeWithUserId:(NSInteger)userId
                                  aid:(NSInteger)aid
                        completeBlock:(CompleteBlock)completeBlock
                           faileBlock:(FaileBlock)faileBlock
{
    NSString *joinUrl = [NSString stringWithFormat:@"%@partTime/joinPartTime?id=%ld&userId=%ld",PartTimeAddress,aid,userId];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:joinUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        JoinPartTimeModel *model = [JoinPartTimeModel new];
        [model jsonToObject:responseObject completeBlock:completeBlock];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        faileBlock(error);
    }];
}

@end

#pragma mark --------- 请求兼职详情信息 ---------
@implementation PartTimeDetailModel
- (void)jsonToObject:(NSDictionary *)dic
       completeBlock:(CompleteBlock)completeBlock
{
    NSString *message = dic[@"message"];
    NSString *status  = dic[@"status"];
    NSDictionary *resultDic = dic[@"result"];
    
    PartTimeModel *model = [PartTimeModel new];
    [model setValuesForKeysWithDictionary:resultDic];
    [model calculateDetailContentHeight];
    [model calculateDetailCompanyHeight];
    [model calculateDetailTitleHeight];
    self.model = model;
   
    completeBlock(self);
    NSLog(@"详情 %@ %@",message,status);
  
}

+ (void)requestDetailPartTimeWithUserId:(NSInteger)userId
                                    aid:(NSInteger)aid
                          completeBlock:(CompleteBlock)completeBlock
                             faileBlock:(FaileBlock)faileBlock
{
    NSString *joinUrl = [NSString stringWithFormat:@"%@partTime/getPartTime?id=%ld&userId=%ld",PartTimeAddress,aid,userId];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:joinUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        PartTimeDetailModel *model = [PartTimeDetailModel new];
        [model jsonToObject:responseObject completeBlock:completeBlock];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        faileBlock(error);
    }];
}

@end




/************************* 用户相关 ************************/

@implementation UserGetTokenModel

- (void)jsonToObject:(NSDictionary *)dic
       completeBlock:(CompleteBlock)completeBlock
{
    NSString *message = dic[@"message"];
    NSString *status  = dic[@"status"];
    self.token        = dic[@"token"];
    NSLog(@"获取token %@ %@ %@",message,status,self.token);
}

+ (void)requestTokenWithPhone:(NSString *)phone
                completeBlock:(CompleteBlock)completeBlock
                   faileBlock:(FaileBlock)faileBlock
{
    NSString *tokenUrl = [NSString stringWithFormat:@"%@user/getToken?phone=%@",PartTimeAddress,phone];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:tokenUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        UserGetTokenModel *model = [UserGetTokenModel new];
        [model jsonToObject:responseObject completeBlock:completeBlock];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        faileBlock(error);
    }];
}

@end


@implementation UserGetRandModel
- (void)jsonToObject:(NSDictionary *)dic
       completeBlock:(CompleteBlock)completeBlock
{
    NSString *message = dic[@"message"];
    NSString *status  = dic[@"status"];
    self.rand        = dic[@"token"];
    NSLog(@"获取token %@ %@ %@",message,status,self.rand);
}

+ (void)requestTokenWithPhone:(NSString *)phone
                        token:(NSString *)token
                completeBlock:(CompleteBlock)completeBlock
                   faileBlock:(FaileBlock)faileBlock
{
    NSString *tokenUrl = [NSString stringWithFormat:@"%@user/getRand?phone=%@&token=%@",PartTimeAddress,phone,token];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:tokenUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        UserGetRandModel *model = [UserGetRandModel new];
        [model jsonToObject:responseObject completeBlock:completeBlock];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        faileBlock(error);
    }];
}

@end


@implementation UserGerUserModel

- (void)jsonToObject:(NSDictionary *)dic
       completeBlock:(CompleteBlock)completeBlock
{
    NSLog(@"%@",dic);
}

+ (void)requestUserWithUserId:(NSString *)userId
                completeBlock:(CompleteBlock)completeBlock
                   faileBlock:(FaileBlock)faileBlock
{
    NSString *getUserUrl = [NSString stringWithFormat:@"%@user/getUser?userId=%@",PartTimeAddress,userId];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:getUserUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        UserGerUserModel *model = [UserGerUserModel new];
        [model jsonToObject:responseObject completeBlock:completeBlock];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        faileBlock(error);
    }];
}

@end


@implementation UserUpdateUserModel

- (void)jsonToObject:(NSDictionary *)dic
       completeBlock:(CompleteBlock)completeBlock
{
    NSLog(@"%@",dic);
}

+ (void)requestUserWithImageStr:(NSString *)imageStr
                            sex:(NSInteger)sex
                       birthday:(NSString *)birthday
                            exp:(NSString *)exp
                            des:(NSString *)des
                         userId:(NSInteger)userId
                  completeBlock:(CompleteBlock)completeBlock
                     faileBlock:(FaileBlock)faileBlock
{
    NSString *expUrl = [NSString stringWithFormat:@"%@user/upDateUser",PartTimeAddress];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSDictionary *params = @{
                             @"imageStr":imageStr ? imageStr : @"",
                             @"sex":@(sex),
                             @"birthday":birthday ? birthday : @"",
                             @"exp":exp ? exp : @"",
                             @"des":des ? des : @"",
                             @"userId":@(userId)
                             };
    
    [manager POST:expUrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        UserUpdateUserModel *model = [UserUpdateUserModel new];
        [model jsonToObject:responseObject completeBlock:completeBlock];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

@end



@implementation UserUpdateNickName
- (void)jsonToObject:(NSDictionary *)dic
       completeBlock:(CompleteBlock)completeBlock
{
    NSLog(@"%@",dic);
}

+ (void)requestNickName:(NSString *)nickName
                 userId:(NSInteger)userId
          completeBlock:(CompleteBlock)completeBlock
             faileBlock:(FaileBlock)faileBlock
{
    NSString *nameChangeUrl = [NSString stringWithFormat:@"%@user/upDateNickName",PartTimeAddress];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSDictionary *params = @{
                             @"nickName": nickName ? nickName : @"",
                             @"userId":@(userId)
                             };
    
    [manager POST:nameChangeUrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        UserUpdateNickName *model = [UserUpdateNickName new];
        [model jsonToObject:responseObject completeBlock:completeBlock];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end


@implementation UserFirstActiveModel

- (void)jsonToObject:(NSDictionary *)dic
       completeBlock:(CompleteBlock)completeBlock
{
    NSLog(@"%@",dic);
}

+ (void)requestFirstActiveCompleteBlock:(CompleteBlock)completeBlock
                             faileBlock:(FaileBlock)faileBlock
{
    NSString *idfa = PT_IDFA;
    NSString *activeUrl = [NSString stringWithFormat:@"%@user/active?idfa=%@&os=1",PartTimeAddress,idfa];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:activeUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        UserFirstActiveModel *model = [UserFirstActiveModel new];
        [model jsonToObject:responseObject completeBlock:completeBlock];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        faileBlock(error);
    }];
}

@end

@implementation UserGetLoginModel

- (void)jsonToObject:(NSDictionary *)dic
       completeBlock:(CompleteBlock)completeBlock
{
    NSLog(@"%@",dic);
}

+ (void)requestLoginWithPhone:(NSString *)phone
                         rand:(NSString *)rand
                completeBlock:(CompleteBlock)completeBlock
                   faileBlock:(FaileBlock)faileBlock
{
    NSString *idfa = @"1";
    NSString *loginUrl = [NSString stringWithFormat:@"%@user/login?idfa=%@&phone=%@&rand=%@",PartTimeAddress,idfa,phone,rand];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:loginUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        UserGetLoginModel *model = [UserGetLoginModel new];
        [model jsonToObject:responseObject completeBlock:completeBlock];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        faileBlock(error);
    }];
}

@end
