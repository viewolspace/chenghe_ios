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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
