//
//  PTDetailCompanyCell.m
//  PartTime
//
//  Created by Mac on 2019/7/22.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "PTDetailCompanyCell.h"

@implementation PTDetailCompanyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setStarsLight:3];
    self.companyBgView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.companyBgView.layer.shadowOffset = CGSizeMake(0, 0);
    self.companyBgView.layer.shadowOpacity = 0.1;
}

- (void)setStarsLight:(NSInteger)lightStar
{
    for (int i = 0; i < self.stars.count; i ++) {
        UIImageView *imageView = self.stars[i];
        if (i < lightStar) {
            imageView.image = [UIImage imageNamed:@"星星_点亮"];
        }else{
            imageView.image = [UIImage imageNamed:@"星星_未点亮"];
        }
    }
}

- (void)setDataWithModel:(PartTimeModel *)model
{
    if (!model) {
        return;
    }
    
    self.companyNameLabel.text = model.title;
   
    CGFloat companyNameHeight = [model.title boundingRectWithSize:CGSizeMake(WIDTH_OF_SCREEN - 80 - 94, 0) options:1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.f]} context:nil].size.height;
    if (companyNameHeight > 20.f ) {
        self.companyHeightConstraint.constant = 79  + companyNameHeight - 20;
    }else{
        self.companyHeightConstraint.constant = 79.f;
    }
}

@end
