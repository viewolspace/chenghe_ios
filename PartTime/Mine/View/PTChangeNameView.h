//
//  PTChangeNameView.h
//  PartTime
//
//  Created by Mac on 2019/7/24.
//  Copyright © 2019 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTChangeNameView : UIView
+(instancetype)initWithXib;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIView *alertView;
@property (nonatomic,copy)void (^cancelBlock)(void);
@property (nonatomic,copy)void (^confirmBlock)(NSString *text);

/** 默认为0，中间位置*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;



@end

NS_ASSUME_NONNULL_END
