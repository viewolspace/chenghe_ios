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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
