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

- (NSAttributedString *)attributedStringWithHTMLString:(NSString *)htmlString

{
    
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                               
                               NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
    
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
    
}

- (void)setDataWithModel:(PartTimeModel *)model
{
    if (model.content) {
      
      //  NSString *styleS = @"<style> body { font-family: Avenir; font-size: 16px; color: #656565; } p:last-of-type { margin: 5; }</style>";
        NSString *styleS = @"<style> body { font-family: Avenir; font-size: 16px; color: #656565;}</style>";
        NSString *html = [NSString stringWithFormat:@"%@%@",styleS,model.content];
        self.contentLabel.attributedText = [self attributedStringWithHTMLString:html];
    }
  
   
//        self.showMoreBtn.hidden = model.isHiddenContent;
//    self.lineView.hidden = model.isHiddenContent;
    
}


@end
