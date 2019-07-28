//
//  PTHomePageCell.m
//  PartTime
//
//  Created by Mac on 2019/7/22.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "PTHomePageCell.h"

@implementation PTHomePageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (IBAction)lookAction:(UIButton *)sender {
    NSLog(@"查看");
}


- (void)setDataWithModel:(PartTimeModel *)model
{
    self.ptTitleLabel.text = model.title;
   
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
