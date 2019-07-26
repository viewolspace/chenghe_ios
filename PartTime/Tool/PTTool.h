//
//  PTTool.h
//  PartTime
//
//  Created by Mac on 2019/7/22.
//  Copyright © 2019 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface PTTool : NSObject
/** 16进制颜色方法 */
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString;


/** 通用的按钮渐变色 */
+ (CAGradientLayer *)customLayer:(UIView *)superView
                      haveCorner:(BOOL)haveCorner;



@end



@interface PTUserUtil : NSObject


/** 获取用户登录状态 */
+ (BOOL)loginStatus;
/** 设置用户登录状态 */
+ (void)setLoginStatus:(BOOL)isLogin;


/** 获取用户id */
+ (NSInteger)getUserId;
/** 存储用户id */
+ (void)setUserId:(NSInteger)userId;


/** 存储用户信息 */
+ (void)setUserInfo:(id)userInfo;
/** 获取用户信息 */
+ (id)getUserInfo;

@end

NS_ASSUME_NONNULL_END
