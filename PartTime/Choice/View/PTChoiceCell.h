//
//  PTChoiceCell.h
//  PartTime
//
//  Created by Mac on 2019/7/23.
//  Copyright © 2019 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PTChoiceCell : UITableViewCell

/** haveImage ? 24 : 10 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *noImageChangeTopConstraint;

/** haveImage ? 93 : 0 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeightConstraint;

@end

NS_ASSUME_NONNULL_END
