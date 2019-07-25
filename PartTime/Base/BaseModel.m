//
//  BaseModel.m
//  PartTime
//
//  Created by Mac on 2019/7/25.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (void)jsonToObject:(NSDictionary *)dic
       completeBlock:(CompleteBlock)completeBlock
{}

@end

@implementation PartTimeModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.aId = [value intValue];
    }
}

@end
