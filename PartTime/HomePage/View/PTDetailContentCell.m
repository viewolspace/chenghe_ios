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


@end
