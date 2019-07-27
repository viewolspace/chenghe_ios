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
    if (self.openBlock) {
        self.openBlock(sender.selected);
    }
}

- (void)setDataWithModel:(PartTimeModel *)model
{
    if (model.content) {
      
      //  NSString *styleS = @"<style> body { font-family: Avenir; font-size: 16px; color: #656565; } p:last-of-type { margin: 5; }</style>";
        NSString *styleS = @"<style> body { font-family: Avenir; font-size: 16px; color: #656565; margin: 5px;}</style>";
        
        NSString *styledHtml = [NSString stringWithFormat:@"%@%@", styleS, model.content];
        NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:16.f],NSForegroundColorAttributeName:[PTTool colorFromHexRGB:@"#656565"],NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};
        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[styledHtml dataUsingEncoding:NSUnicodeStringEncoding] options:dic
                                                             documentAttributes:nil error:nil];
        
      
   
        self.contentLabel.attributedText = attrStr;
    }
  
   
//        self.showMoreBtn.hidden = model.isHiddenContent;
//    self.lineView.hidden = model.isHiddenContent;
    
}


@end
