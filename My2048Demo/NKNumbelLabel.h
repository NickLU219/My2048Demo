//
//  NKNumbelLabel.h
//  My2048Demo
//
//  Created by 陆金龙 on 15/12/25.
//  Copyright © 2015年 Nick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NKNumbelLabel : UILabel

- (instancetype)initWithFrame:(CGRect)frame;

+ (instancetype)labelWithFrame:(CGRect)frame;
+ (instancetype)labelWithPosition:(CGPoint)position;
+ (instancetype)label;
@end
