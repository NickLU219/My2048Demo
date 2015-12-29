//
//  NKNumbelLabel.m
//  My2048Demo
//
//  Created by 陆金龙 on 15/12/25.
//  Copyright © 2015年 Nick. All rights reserved.
//

#import "NKNumbelLabel.h"
#import "MJExtension.h"


@implementation NKNumbelLabel

+ (void)initialize {
    [super initialize];
    UILabel *label = [UILabel appearance];
    label.textAlignment = NSTextAlignmentCenter;
}

+ (instancetype)labelWithFrame:(CGRect)frame {
    return [[self alloc]initWithFrame:frame];
}
+ (instancetype)labelWithPosition:(CGPoint)position {
    CGRect frame = CGRectMake(position.x, position.y, LABELWH, LABELWH);
    return [self labelWithFrame:frame];
}

+ (instancetype)label {
    NKNumbelLabel *label = [[NKNumbelLabel alloc] init];
    label.text = @"";
    label.hidden = YES;
    return label;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.layer.cornerRadius = 6;
    self.layer.masksToBounds = YES;
    if (self) {
        NSInteger num = arc4random() % 5;
        if (num == 0) {
            NSMutableDictionary *attr = [NSMutableDictionary dictionary];
            attr[NSFontAttributeName] = [UIFont fontWithName:@"Helvetica Neue" size:40];
            attr[NSForegroundColorAttributeName] = Color(236, 226, 215);
            self.attributedText = [[NSAttributedString alloc] initWithString:@"4" attributes:attr];
            self.backgroundColor = [UIColor orangeColor];
        } else {
            NSMutableDictionary *attr = [NSMutableDictionary dictionary];
            attr[NSFontAttributeName] = [UIFont fontWithName:@"Helvetica Neue" size:40];
            attr[NSForegroundColorAttributeName] = Color(236, 226, 215);
            self.attributedText = [[NSAttributedString alloc] initWithString:@"2" attributes:attr];
            self.backgroundColor = [UIColor orangeColor];
        }
    }
    return self;
}



@end
