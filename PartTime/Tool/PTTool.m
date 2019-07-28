//
//  PTTool.m
//  PartTime
//
//  Created by Mac on 2019/7/22.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "PTTool.h"

@implementation PTTool

+ (UIColor *)colorFromHexRGB:(NSString *)inColorString {
    NSString *cString = [[inColorString
                          stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6)
        return [UIColor blackColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor blackColor];
    
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != cString) {
        NSScanner *scanner = [NSScanner scannerWithString:cString];
        (void)[scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char)(colorCode >> 16);
    greenByte = (unsigned char)(colorCode >> 8);
    blueByte = (unsigned char)(colorCode); // masks off high bits
    result = [UIColor colorWithRed:(float)redByte / 0xff
                             green:(float)greenByte / 0xff
                              blue:(float)blueByte / 0xff
                             alpha:1.0];
    return result;
}

+ (CAGradientLayer *)customLayer:(UIView *)superView
                      haveCorner:(BOOL)haveCorner
{
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = superView.bounds;
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:88/255.0 green:128/255.0 blue:254/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:81/255.0 green:168/255.0 blue:254/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:85/255.0 green:192/255.0 blue:246/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(0.6),@(1.0)];
    if (haveCorner) {
        gl.cornerRadius = superView.height / 2.0;
    }
    return gl;
}

+ (void)setDash:(UIView *)superView
{
    
}

/**
 *  通过 CAShapeLayer 方式绘制虚线
 *
 *  param lineView:       需要绘制成虚线的view
 *  param lineLength:     虚线的宽度
 *  param lineSpacing:    虚线的间距
 *  param lineColor:      虚线的颜色
 *  param lineDirection   虚线的方向  YES 为水平方向， NO 为垂直方向
 **/
+ (void)drawLineOfDashByCAShapeLayer:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor lineDirection:(BOOL)isHorizonal {
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    [shapeLayer setBounds:lineView.bounds];
    
    if (isHorizonal) {
        
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
        
    } else{
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame)/2)];
    }
    
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    if (isHorizonal) {
        [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    } else {
        
        [shapeLayer setLineWidth:CGRectGetWidth(lineView.frame)];
    }
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    
    if (isHorizonal) {
        CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    } else {
        CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(lineView.frame));
    }
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

///时间戳转化为字符转0000-00-00 00:00
+ (NSString *)time_timestampToString:(NSInteger)timestamp{
    
    timestamp = timestamp / 1000.f;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    NSString* string=[dateFormat stringFromDate:confromTimesp];
    
    return string;
    
}

@end



@implementation PTUserUtil

+ (BOOL)loginStatus{
    return [[NSUserDefaults standardUserDefaults]boolForKey:PT_USER_LOGIN];
}

+ (void)setLoginStatus:(BOOL)isLogin
{
    [[NSUserDefaults standardUserDefaults]setBool:isLogin forKey:PT_USER_LOGIN];
}

+ (NSInteger)getUserId
{
    
    return [[NSUserDefaults standardUserDefaults] integerForKey:PT_USER_ID];
}

+ (void)setUserId:(NSInteger)userId
{
    [[NSUserDefaults standardUserDefaults] setInteger:userId forKey:PT_USER_ID];
}

+ (void)setUserInfo:(id)userInfo
{
    NSData *data = [FastCoder dataWithRootObject:userInfo];
    [[NSUserDefaults standardUserDefaults]setObject:data forKey:PT_USER_INFO];
    
}

+ (id)getUserInfo
{
    NSData *data = [[NSUserDefaults standardUserDefaults]objectForKey:PT_USER_INFO];
    return [FastCoder objectWithData:data];
}





@end
