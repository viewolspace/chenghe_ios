//
//  PTDetailContentCell.m
//  PartTime
//
//  Created by Mac on 2019/7/22.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "PTDetailContentCell.h"

@implementation PTDetailContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)openAction:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (void)setDataWithModel:(PartTimeModel *)model
{
    if (model.content) {
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineSpacing = 5.f;
        
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:model.content attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.f],NSForegroundColorAttributeName:[PTTool colorFromHexRGB:@"#656565"],NSParagraphStyleAttributeName:style}];
        
        self.contentLabel.attributedText = str;
    }
  
   
        self.showMoreBtn.hidden = model.isHiddenContent;
    self.lineView.hidden = model.isHiddenContent;
    
}


@end
