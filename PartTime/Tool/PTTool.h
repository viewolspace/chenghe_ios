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



/** 获取用户id */
+ (NSString *)getUserId;
/** 存储用户id */
+ (void)setUserId:(NSString *)userId;


@end

NS_ASSUME_NONNULL_END
