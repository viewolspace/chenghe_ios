//
//  NewShowLabel.m
//  SimuStock
//
//  Created by moulin wang on 14-7-25.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "NewShowLabel.h"

/** 提示内容文字与label的左右间距 */
static CGFloat marginToLeftAndRight = 15.f;
/** 提示label高度 */
static CGFloat newShowLabelHeight = 29.f;

@implementation NewShowLabel
static NewShowLabel *newShowLab;

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
  
  }
  return self;
}
+ (NewShowLabel *)newShowLabel {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    newShowLab = [[NewShowLabel alloc] init];
      newShowLab.backgroundColor = [[PTTool colorFromHexRGB:@"#0873d2"] colorWithAlphaComponent:0.8];
    [newShowLab.layer setMasksToBounds:YES];
    newShowLab.layer.cornerRadius = 1.5f;
    newShowLab.textColor = [UIColor whiteColor];
    newShowLab.textAlignment = NSTextAlignmentCenter;
    newShowLab.font = [UIFont systemFontOfSize:15];
    newShowLab.numberOfLines = 0;
    newShowLab.hidden = YES;
    newShowLab.minimumScaleFactor = 0.6f;
    newShowLab.adjustsFontSizeToFitWidth = YES;
    newShowLab.Userinfo = [[NSMutableDictionary alloc] init];
  });
  return newShowLab;
}

/**显示网络不给力提示 */
+ (void)showNoNetworkTip {
  [NewShowLabel setMessageContent:@"网络不给力"];
}

+ (void)setMessageContent:(NSString *)message {
  [NewShowLabel setMessageContent:message withShouldInKeyBoard:YES];
}

+ (void)setMessageContentNotInKeyBoard:(NSString *)message {
  [NewShowLabel setMessageContent:message withShouldInKeyBoard:NO];
}

+ (CGSize)boundingRectWithSize:(NSString *)string withFont:(float)font withSize:(CGSize)labelSize {
    NSDictionary *attribute = @{NSFontAttributeName : [UIFont systemFontOfSize:font]};
    CGSize size = [string boundingRectWithSize:labelSize
                                       options:(NSStringDrawingTruncatesLastVisibleLine |
                                                NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                    attributes:attribute
                                       context:nil]
    .size;
    size = CGSizeMake(size.width + 2, size.height + 5);
    return size;
}

+ (void)setMessageContent:(NSString *)message withShouldInKeyBoard:(BOOL)shouldInKeyBoard {
  if (!message || [message length] == 0) {
    return;
  }
  CGSize fsize = CGSizeMake(260.0, 40.0);
  CGSize labelsize =
      [NewShowLabel boundingRectWithSize:message withFont:13.f withSize:fsize];
  //横竖屏切换
  newShowLab.transform = CGAffineTransformMakeRotation(newShowLab.isLandscape ? M_PI / 2 : 0);

  
  if (newShowLab.isLandscape) {
    newShowLab.frame = CGRectMake(100 - (labelsize.width - labelsize.height) / 2,
                                  (HEIGHT_OF_SCREEN - labelsize.width - 10) / 2,
                                  labelsize.height + 10.0, labelsize.width + 10.0);

  } else {
    newShowLab.frame = CGRectMake((WIDTH_OF_SCREEN - labelsize.width - marginToLeftAndRight * 2) / 2,
                                  HEIGHT_OF_SCREEN - labelsize.height - 100.0,
                                  labelsize.width + marginToLeftAndRight * 2, newShowLabelHeight);
  }

  newShowLab.text = message;
  newShowLab.textAlignment = NSTextAlignmentCenter;
  newShowLab.numberOfLines = 0;
    newShowLab.backgroundColor = [[PTTool colorFromHexRGB:@"#0873d2"]colorWithAlphaComponent:0.8];
  [newShowLab removeFromSuperview];

  [[PTManager shareManager].highestWindow addSubview:newShowLab];
    [PTManager shareManager].highestWindow.hidden = NO;
  newShowLab.hidden = NO;
  newShowLab.alpha = 1.f;

  //取消上一个正在执行的延迟操作，适合快速点击时调用

  [newShowLab performSelector:@selector(hideNewShowLabel) withObject:nil afterDelay:2.0f];
}

- (NSString *)replaceUnicode:(NSString *)unicodeStr {

  NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
  NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
  NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
  NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
  NSString *returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                         mutabilityOption:NSPropertyListImmutable
                                                                   format:NULL
                                                         errorDescription:NULL];
  NSLog(@"%@", returnStr);
  return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}
///隐藏自己
- (void)hideNewShowLabel {
  newShowLab.hidden = YES;
    [PTManager shareManager].highestWindow.hidden = YES;
  //必须及时从当前window层剔除，否则多指针引用，不过单例影响不大
}

- (void)landscapeStyle:(BOOL)isLandscape {
  _isLandscape = isLandscape;
}

@end
