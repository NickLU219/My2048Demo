//
//  NKGameMatrix.m
//  My2048Demo
//
//  Created by 陆金龙 on 15/12/27.
//  Copyright © 2015年 Nick. All rights reserved.
//

#import "NKGameMatrix.h"


@implementation NKGameMatrix 
- (instancetype)init {
    if (self = [super init]) {

    }
    return self;
}
- (NSMutableArray *)array {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0 ; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
            NKNumbelLabel *label = [NKNumbelLabel label];
            [array addObject:label];
        }
    }
    return array;
}
+ (NSMutableArray *)gameMatrixWithSize:(NSInteger)size {
    return [[[self alloc] array]mutableCopy];
}


@end
