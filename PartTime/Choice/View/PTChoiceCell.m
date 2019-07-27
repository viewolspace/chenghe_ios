//
//  PTChoiceCell.m
//  PartTime
//
//  Created by Mac on 2019/7/23.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "PTChoiceCell.h"

@implementation PTChoiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)lookAction:(UIButton *)sender {
}

- (void)setDataWithModel:(PartTimeModel *)model
{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 5.f;
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:17.f],NSForegroundColorAttributeName:[PTTool colorFromHexRGB:@"#2a2a2a"],NSParagraphStyleAttributeName:style};
    NSAttributedString *titleStr = [[NSAttributedString alloc] initWithString:model.title attributes:dic];
  
    //标题
    self.ptTitleLabel.attributedText = titleStr;
    
    if (model.haveImage) {
        self.imageHeightConstraint.constant = 93;
        self.noImageChangeTopConstraint.constant = 24.f;
        [self.ptImageView sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@""]];
    }else{
        self.imageHeightConstraint.constant = 0;
        self.noImageChangeTopConstraint.constant = 10.f;
    }
    
    
    //小标题
    NSString *subTitleStr = [model.lable stringByReplacingOccurrencesOfString:@"," withString:@" | "];
    self.ptSubTitleLabel.text = subTitleStr;
    
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
    
    
}

@end
