//
//  NKGameMatrix.h
//  My2048Demo
//
//  Created by 陆金龙 on 15/12/27.
//  Copyright © 2015年 Nick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NKGameEngine.h"
#import "NKNumbelLabel.h"

@interface NKGameMatrix : NSObject 


- (NSMutableArray *)array;
+ (NSMutableArray *)gameMatrixWithSize:(NSInteger)size;

@end
