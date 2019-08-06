//
//  PTHomePageCell.h
//  PartTime
//
//  Created by Mac on 2019/7/22.
//  Copyright © 2019 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface PTHomePageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *ptTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *ptPayLabel;

@property (weak, nonatomic) IBOutlet UILabel *ptSubTitleLabel;

@property (weak, nonatomic) IBOutlet UIButton *lookBtn;
@property (weak, nonatomic) IBOutlet UIImageView *verImageView;

- (void)setDataWithModel:(PartTimeModel *)model;

@end

NS_ASSUME_NONNULL_END
