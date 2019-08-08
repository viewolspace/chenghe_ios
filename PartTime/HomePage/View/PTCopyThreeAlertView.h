//
//  PTCopyThreeAlertView.h
//  PartTime
//
//  Created by Mac on 2019/7/27.
//  Copyright © 2019 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTCopyThreeAlertView : UIView
+(instancetype)initWithXib;
@property (weak, nonatomic) IBOutlet UILabel *btnLabel;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *alertView;
@property (nonatomic,copy)void (^phoneBlock)(void);
@property (nonatomic,copy)void (^resumeBlock)(void);

/** 联系方式类型 1 qq 2 微信 3 手机 4 完善简历*/
@property (nonatomic,assign)int contactType;
@end

NS_ASSUME_NONNULL_END
