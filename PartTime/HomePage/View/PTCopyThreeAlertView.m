//
//  PTCopyThreeAlertView.m
//  PartTime
//
//  Created by Mac on 2019/7/27.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "PTCopyThreeAlertView.h"

@implementation PTCopyThreeAlertView

+(instancetype)initWithXib{
    PTCopyThreeAlertView *view = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].lastObject;
    [view awakeFromNib];
    view.alertView.layer.cornerRadius = 10.f;
    view.alertView.layer.masksToBounds = YES;
    view.confirmBtn.layer.masksToBounds = YES;
    view.confirmBtn.layer.cornerRadius = view.confirmBtn.height / 2.0;
    return view;
}

- (IBAction)confirmAction:(id)sender {
    NSLog(@"前往!");
    
    UIWindow *window = [PTManager shareManager].hightWindow;
    window.hidden = YES;
    [self removeFromSuperview];
    
    if (self.phoneBlock) {
        self.phoneBlock();
    }
    
    return;
    
    if (self.contactType == 1) {
        //qq
        [self openQQ];
        
    }else if(self.contactType == 2){
        //wechat
        [self openWechat];

    }else{
        //手机
        if (self.phoneBlock) {
            self.phoneBlock();
        }
    }
    
    
    
}

- (void)openQQ{
    NSURL * url = [NSURL URLWithString:@"mqq://"];
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:url];
    //先判断是否能打开该url
    if (canOpen)
    {   //打开微信
        [[UIApplication sharedApplication] openURL:url];
    }else {
        [NewShowLabel setMessageContent:@"您尚未安装QQ"];
    }
}

-(void)openWechat{
    NSURL * url = [NSURL URLWithString:@"weixin://"];
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:url];
    //先判断是否能打开该url
    if (canOpen)
    {   //打开微信
        [[UIApplication sharedApplication] openURL:url];
    }else {
        [NewShowLabel setMessageContent:@"您尚未安装微信"];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
    UIWindow *window = [PTManager shareManager].hightWindow;
    window.hidden = YES;
}

@end
