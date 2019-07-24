//
//  PTChangeNameView.m
//  PartTime
//
//  Created by Mac on 2019/7/24.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "PTChangeNameView.h"

@implementation PTChangeNameView

+(instancetype)initWithXib{
    PTChangeNameView *view = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].lastObject;
    [view awakeFromNib];
    view.alertView.layer.cornerRadius = 10.f;
    view.alertView.layer.masksToBounds = YES;
    return view;
}

- (IBAction)cancelAction:(UIButton *)sender {
    [self endEditing:YES];
    [self removeFromSuperview];
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (IBAction)confirmAction:(UIButton *)sender {
    [self endEditing:YES];
    if (self.confirmBlock) {
        self.confirmBlock(self.nameTextField.text);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

@end
