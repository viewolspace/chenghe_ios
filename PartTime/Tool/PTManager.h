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

@end

NS_ASSUME_NONNULL_END
