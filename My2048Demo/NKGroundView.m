//
//  NKGroundView.m
//  My2048Demo
//
//  Created by 陆金龙 on 15/12/26.
//  Copyright © 2015年 Nick. All rights reserved.
//

#import "NKGroundView.h"

@implementation NKGroundView
+ (void)initialize {
    UIView *view = [NKGroundView appearance];
    view.backgroundColor = Color(173, 157, 143);
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    for (int i = 0 ; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(10 + j * (LABELWH + 10), 10 + i * (LABELWH + 10), LABELWH, LABELWH) cornerRadius:8];
            [Color(250, 245, 237) setFill];
            [path fill];
            [path closePath];
        }
    }
}


@end
