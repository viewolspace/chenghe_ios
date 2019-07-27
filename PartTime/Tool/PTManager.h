//
//  PTManager.h
//  PartTime
//
//  Created by Mac on 2019/7/23.
//  Copyright © 2019 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTManager : NSObject

+ (PTManager *)shareManager;

@property (nonatomic,assign)CGFloat statusBarHeight;
@property (nonatomic,assign)CGFloat tabbarHeight;
@property (nonatomic,assign)CGFloat navigationBarHeight;
@property (nonatomic,strong)UITabBarController *tabbarVC;
@property (nonatomic,strong)UIWindow *hightWindow;  //最上层window,在状态栏之上
@property (nonatomic,strong)UIWindow *highestWindow; //最高级，主要用于显示 prompt

+ (AFHTTPSessionManager *)shareAFManager;


@end

NS_ASSUME_NONNULL_END
