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

@end



@implementation PTUserUtil

+ (NSString *)getUserId
{
    
    return [[NSUserDefaults standardUserDefaults]stringForKey:PT_USER_ID];
}

+ (void)setUserId:(NSString *)userId
{
    [[NSUserDefaults standardUserDefaults]setValue:userId forKey:PT_USER_ID];
}

@end
