//
//  PTDetailTitleCell.m
//  PartTime
//
//  Created by Mac on 2019/7/22.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "PTDetailTitleCell.h"

@implementation PTDetailTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    CAGradientLayer *layer = [PTTool customLayer:self.ptCopyBtn haveCorner:YES];
    [self.ptCopyBtn.layer addSublayer:layer];
}

- (IBAction)copyAction:(UIButton *)sender {
    
    if (self.copyBlock) {
        self.copyBlock(self.model);
    }
}


- (void)setDataWithModel:(PartTimeModel *)model
{
    if (!model) {
        return;
    }
    
    self.model = model;
    //标题
    self.ptTitleLabel.text = model.title;
    
    //更新时间
    
    
    //薪水
    //0 小时 1 天 2 周 3 月 4 季度
    NSArray *payArr = @[@"小时",@"天",@"周",@"月",@"季度"];
    if (model.cycle > payArr.count - 1) {
        model.cycle = 0;
    }
    NSString *date = [NSString stringWithFormat:@" 元/%@",payArr[model.cycle]];
    NSString *money = [NSString stringWithFormat:@"%d",model.salary];
    NSString *payStr = [NSString stringWithFormat:@"%@%@",money,date];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:payStr attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11.f],NSForegroundColorAttributeName:[PTTool colorFromHexRGB:@"#db6d70"]}];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:23.f] range:NSMakeRange(0, money.length)];
    self.ptPayLabel.attributedText = str;
    
    //subLebel
    NSArray *subViews = self.subLabelView.subviews;
    for (UIView *view in subViews) {
        [view removeFromSuperview];
    }
    
    self.subLabelViewHeightConstraint.constant = 30;
    
    CGFloat labelPage = 5.f;
    CGFloat textPage = 9.f;
    NSArray *subLabels = [model.lable componentsSeparatedByString:@","];
    UIFont *font = [UIFont systemFontOfSize:13.f];
    CGFloat right = 0;
    CGFloat top   = 2;
    for (int i = 0; i < subLabels.count; i ++) {
        NSString *subTitle = subLabels[i];
        CGFloat width = [subTitle boundingRectWithSize:CGSizeMake(0, 13.f) options:1 attributes:@{NSFontAttributeName:font} context:nil].size.width;
        
        if (width + right + textPage * 2.0 > WIDTH_OF_SCREEN - 28) {
            top += 30;
            right = 0;
            self.subLabelViewHeightConstraint.constant += 30;

        }
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(right, top, width + textPage * 2.0, 26)];
        label.text = subTitle;
        label.textColor = [PTTool colorFromHexRGB:@"#A0A2A4"];
        label.font = [UIFont systemFontOfSize:13.f];
        label.backgroundColor = [PTTool colorFromHexRGB:@"#f2f4f5"];
        label.textAlignment = NSTextAlignmentCenter;
        [self.subLabelView addSubview:label];
        
        right = label.right + labelPage;

    }
    
    //工作时间
    self.ptWorkTimelabel.text = [NSString stringWithFormat:@"工作时间：%@",model.workTime];
    
    //工作地点
    self.ptWorkAddress.text = [NSString stringWithFormat:@"工作地点：%@",model.workAddress];
    NSString *contactStr = @"QQ";
    if (model.contactType == 1) {
        contactStr = [NSString stringWithFormat:@"点击复制联系方式    QQ:%@",model.contact];
    }else if(model.contactType == 2){
        contactStr = [NSString stringWithFormat:@"点击复制联系方式    微信:%@",model.contact];
    }else{
        contactStr = [NSString stringWithFormat:@"点击复制联系方式    手机:%@",model.contact];
    }
    [self.ptCopyBtn setTitle:contactStr forState:UIControlStateNormal];
    
    
    //更新时间
    NSString *timeStr = [PTTool time_timestampToString:model.cTime];
    self.ptUpDateLabel.text = [NSString stringWithFormat:@"更新时间：%@",timeStr];
    
    //是否认证
    if (model.verify == 1) {
        self.verImageView.hidden = NO;
    }else{
        self.verImageView.hidden = YES;
    }
}


@end
