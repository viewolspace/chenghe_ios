//
//  NewShowLabel.h
//  SimuStock
//
//  Created by moulin wang on 14-7-25.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface NewShowLabel : UILabel

@property(nonatomic) BOOL isLandscape;
@property(nonatomic, strong) NSMutableDictionary *Userinfo;

@property (nonatomic,strong)UIImage *talkPlaceHolderImage;

/** 自定义提示文本 */
+ (void)setMessageContent:(NSString *)message;

+ (void)setMessageContentNotInKeyBoard:(NSString *)message;

+ (NewShowLabel *)newShowLabel;

/**显示网络不给力提示 */
+ (void)showNoNetworkTip;

///横竖屏切换
- (void)landscapeStyle:(BOOL)isLandscape;
@end
