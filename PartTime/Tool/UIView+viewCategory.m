//
//  UIView+viewCategory.m
//  PartTime
//
//  Created by Mac on 2019/7/26.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "UIView+viewCategory.h"

@implementation UIView (viewCategory)

- (void)removeAllSubVies
{
    NSArray *arr = self.subviews;
    for (UIView *view in arr) {
        [view removeFromSuperview];
    }
}
@end
