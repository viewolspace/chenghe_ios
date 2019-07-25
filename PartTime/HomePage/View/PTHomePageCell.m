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


- (void)setDataWithModel:(PTHotAndChoiceRecommentModel *)model
{
    self.ptTitleLabel.text = model.title;
}

@end
