//
//  NKGameEngine.m
//  My2048Demo
//
//  Created by 陆金龙 on 15/12/27.
//  Copyright © 2015年 Nick. All rights reserved.
//

#import "NKGameEngine.h"



@implementation NKGameEngine

- (void)startGame:(UIView *)view andGroundView:(NKGroundView *)groundView andMatrix:(NSMutableArray *)matrix {
    for (int i = 0; i < 2; i++) {
        [self addLabel:matrix andGroundView:groundView];
    }
    for (UILabel *label in matrix) {
        [groundView addSubview:label];
    }
    [self setupGesture:view];
}

- (void)setupGesture:(UIView *)view {
    UISwipeGestureRecognizer *up = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction:)];
    up.direction = UISwipeGestureRecognizerDirectionUp;
    [view addGestureRecognizer:up];
    UISwipeGestureRecognizer *down = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction:)];
    down.direction = UISwipeGestureRecognizerDirectionDown;
    [view addGestureRecognizer:down];
    UISwipeGestureRecognizer *left = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction:)];
    left.direction = UISwipeGestureRecognizerDirectionLeft;
    [view addGestureRecognizer:left];
    UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction:)];
    right.direction = UISwipeGestureRecognizerDirectionRight;
    [view addGestureRecognizer:right];

}

- (void)gestureAction:(UISwipeGestureRecognizer *)gesture {
    switch (gesture.direction) {
        case UISwipeGestureRecognizerDirectionUp:
            [self.delegate NKGameEngine:self upGesture:gesture andMatrix:_array];
            break;
        case UISwipeGestureRecognizerDirectionDown:
            [self.delegate NKGameEngine:self downGesture:gesture andMatrix:_array];
            break;
        case UISwipeGestureRecognizerDirectionLeft:
            [self.delegate NKGameEngine:self leftGesture:gesture andMatrix:_array];
            break;
        case UISwipeGestureRecognizerDirectionRight:
            [self.delegate NKGameEngine:self rightGesture:gesture andMatrix:_array];
            break;
    }
}
- (void)addLabel:(NSMutableArray *)matrix andGroundView:(UIView *)groundView {
    int index = arc4random() & 15;
    NKNumbelLabel *oldLabel = matrix[index];

    if ([self gameOver:matrix]) {
        if (oldLabel.hidden) {
            //行
            int row = index  / 4;
            float rowPosition = (row) * (LABELWH+10) + 10.0;
            //列
            int col = (index - row * 4) % 4;
            float colPosition = (col) * (LABELWH+10) + 10.0;

            CGPoint position = CGPointMake(colPosition, rowPosition);
            NKNumbelLabel *newLabel = [NKNumbelLabel labelWithPosition:position];

            [matrix replaceObjectAtIndex:index withObject:newLabel];
            [groundView addSubview:newLabel];
            newLabel.alpha = 0;
            [UIView animateWithDuration:0.1 delay:0.3 options:UIViewAnimationOptionLayoutSubviews animations:^{
                newLabel.alpha = 1;
            } completion:nil];
        } else {
            [self addLabel:matrix andGroundView:groundView];
        }
    }
    _array = matrix;
}
//游戏结束待优化
#warning

- (BOOL)gameOver:(NSMutableArray *)matrix {
    int count = 0;
    for (NKNumbelLabel *label in matrix) {
        if (label.hidden) {
            count++;
        }
    }
    if (count == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GameOver" object:nil];
        return NO;
    }
    return YES;
}

@end
