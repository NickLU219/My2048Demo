//
//  NKMainViewController.m
//  My2048Demo
//
//  Created by 陆金龙 on 15/12/25.
//  Copyright © 2015年 Nick. All rights reserved.
//

#import "NKMainViewController.h"
#import "NKNumbelLabel.h"
#import "NKGroundView.h"
#import "NKGameMatrix.h"
#import "NKGameEngine.h"

@interface NKMainViewController () <NKGameEngineDelegate>
@property (nonatomic, strong) NKGameEngine *gameEngine;
@property (nonatomic, strong) NSMutableArray *matrix;
@property (nonatomic, strong) NKGroundView *groundView;

@end

@implementation NKMainViewController
- (NKGameEngine *)gameEngine {
    if (!_gameEngine) {
        _gameEngine = [[NKGameEngine alloc] init];
        _gameEngine.delegate = self;
    }
    return _gameEngine;
}
/**
 *  注册通知
 *
 */
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gameOver:) name:@"GameOver" object:nil];
}
/**
 *  删除通知
 *
 */
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GameOver" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color(247, 255, 230);
    [self configStartButton];
    [self start];

}
- (void)gameOver:(NSNotificationCenter *)center {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"GG!" message:@"You are so stupid!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *retry = [UIAlertAction actionWithTitle:@"try again" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self start];
    }];
    [alert addAction:retry];
    [self presentViewController:alert animated:YES completion:nil];
}
/**
 *  配置启动按钮
 */
- (void)configStartButton {
    UIButton *start = [UIButton buttonWithType:UIButtonTypeSystem];
    [start setTitle:@"start" forState:UIControlStateNormal];
    start.backgroundColor = [UIColor orangeColor];
    CGRect frame = CGRectMake(150, 100, 100, 50);
    start.frame = frame;
    [start addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:start];
}
/**
 *  重启游戏(启动游戏)
 */
- (void)start {
    if ([self.view.subviews.lastObject isKindOfClass:[NKGroundView class]]) {
        [self.view.subviews.lastObject removeFromSuperview];
    }
    NKGroundView *groundView = [[NKGroundView alloc] initWithFrame:CGRectMake(10, 200, GroundWH, GroundWH)];
    [self.view addSubview:groundView];
    _groundView = groundView;
    NSMutableArray *matrix = [[NKGameMatrix gameMatrixWithSize:4]mutableCopy];
    _matrix = matrix;
    [self.gameEngine startGame:self.view andGroundView:groundView andMatrix:matrix];

}
#pragma mark - NKGameEngineDelegate
/**
 *  复杂逻辑，待重构
 */
- (void)NKGameEngine:(NKGameEngine *)gameEngine upGesture:(UISwipeGestureRecognizer *)gesture andMatrix:(NSMutableArray *)array {
    NSLog(@"up");

    for (int col = 0 ; col < 4; col++) {
        __block int targetrow = 0;
        for (int row = 1; row < 4; row++) {
            NKNumbelLabel *label = array[col + row*4];
            NKNumbelLabel *targetLabel = array[col + targetrow*4];
            if (!label.hidden) {

                if ([targetLabel.text isEqualToString:@""]) {
                    NSLog(@"moveup");
                    [array exchangeObjectAtIndex:(col+targetrow*4) withObjectAtIndex:(col+row*4)];
                    [UIView animateWithDuration:0.2 animations:^{
                        label.frame = CGRectMake(10 + (10 + LABELWH)*col, 10 + (10 + LABELWH)*targetrow, LABELWH, LABELWH);
                    } completion:nil];
                } else {
                    if ([targetLabel.text isEqualToString:label.text]) {
                        //merge
                        NSLog(@"merge");
                        [UIView animateWithDuration:0.2 animations:^{
                            label.frame = targetLabel.frame;
                            [array removeObject:label];
                            NKNumbelLabel *newLabel = [NKNumbelLabel label];
                            [array insertObject:newLabel atIndex:(col+row*4)];
                            NSMutableDictionary *attr = [NSMutableDictionary dictionary];
                            attr[NSFontAttributeName] = [UIFont fontWithName:@"Helvetica Neue" size:40];
                            attr[NSForegroundColorAttributeName] = Color(236, 226, 215);
                            NSString *value = [NSString stringWithFormat:@"%ld",targetLabel.text.integerValue*2];
                            targetLabel.attributedText = [[NSAttributedString alloc] initWithString:value attributes:attr];
                        } completion:^(BOOL finished) {
                            [label removeFromSuperview];
                        }];
                    } else {
                        NSLog(@"justmove");
                        targetrow++;
                        [array exchangeObjectAtIndex:(col+targetrow*4) withObjectAtIndex:(col+row*4)];
                        [UIView animateWithDuration:0.2 animations:^{
                            label.frame = CGRectMake(10 + (10 + LABELWH)*col, 10 + (10 + LABELWH)*targetrow, LABELWH, LABELWH);
                        } completion:nil];
                    }
                }

            }
        }
    }
    [gameEngine addLabel:array andGroundView:_groundView];
//    NSLog(@"%@",array);

}

- (void)NKGameEngine:(NKGameEngine *)gameEngine downGesture:(UISwipeGestureRecognizer *)gesture andMatrix:(NSMutableArray *)array {
    NSLog(@"down");
    for (int col = 0 ; col < 4; col++) {
        __block int targetrow = 3;
        for (int row = 2; row >= 0; row--) {
            NKNumbelLabel *label = array[col + row*4];
            NKNumbelLabel *targetLabel = array[col + targetrow*4];
            if (!label.hidden) {

                if ([targetLabel.text isEqualToString:@""]) {
                    NSLog(@"moveup");
                    [array exchangeObjectAtIndex:(col+targetrow*4) withObjectAtIndex:(col+row*4)];
                    [UIView animateWithDuration:0.2 animations:^{
                        label.frame = CGRectMake(10 + (10 + LABELWH)*col, 10 + (10 + LABELWH)*targetrow, LABELWH, LABELWH);
                    } completion:nil];
                } else {
                    if ([targetLabel.text isEqualToString:label.text]) {
                        //merge
                        NSLog(@"merge");
                        [UIView animateWithDuration:0.2 animations:^{
                            label.frame = targetLabel.frame;
                            [array removeObject:label];
                            NKNumbelLabel *newLabel = [NKNumbelLabel label];
                            [array insertObject:newLabel atIndex:(col+row*4)];
                            NSMutableDictionary *attr = [NSMutableDictionary dictionary];
                            attr[NSFontAttributeName] = [UIFont fontWithName:@"Helvetica Neue" size:40];
                            attr[NSForegroundColorAttributeName] = Color(236, 226, 215);
                            NSString *value = [NSString stringWithFormat:@"%ld",targetLabel.text.integerValue*2];
                            targetLabel.attributedText = [[NSAttributedString alloc] initWithString:value attributes:attr];
                        } completion:^(BOOL finished) {
                            [label removeFromSuperview];
                        }];
                    } else {
                        NSLog(@"justmove");
                        targetrow--;
                        [array exchangeObjectAtIndex:(col+targetrow*4) withObjectAtIndex:(col+row*4)];
                        [UIView animateWithDuration:0.2 animations:^{
                            label.frame = CGRectMake(10 + (10 + LABELWH)*col, 10 + (10 + LABELWH)*targetrow, LABELWH, LABELWH);
                        } completion:nil];
                    }
                }

            }
        }
    }
    [gameEngine addLabel:array andGroundView:_groundView];
}

- (void)NKGameEngine:(NKGameEngine *)gameEngine leftGesture:(UISwipeGestureRecognizer *)gesture andMatrix:(NSMutableArray *)array {
    NSLog(@"left");
    for (int row = 0 ; row < 4; row++) {
        __block int targetcol = 0;
        for (int col = 1; col < 4; col++) {
            NKNumbelLabel *label = array[col + row*4];
            NKNumbelLabel *targetLabel = array[targetcol + row*4];
            if (!label.hidden) {

                if ([targetLabel.text isEqualToString:@""]) {
                    NSLog(@"moveup");
                    [array exchangeObjectAtIndex:(row*4+targetcol) withObjectAtIndex:(row*4+col)];
                    [UIView animateWithDuration:0.2 animations:^{
                        label.frame = CGRectMake(10 + (10 + LABELWH)*targetcol, 10 + (10 + LABELWH)*row, LABELWH, LABELWH);
                    } completion:nil];
                } else {
                    if ([targetLabel.text isEqualToString:label.text]) {
                        //merge
                        NSLog(@"merge");
                        [UIView animateWithDuration:0.2 animations:^{
                            label.frame = targetLabel.frame;
                            [array removeObject:label];
                            NKNumbelLabel *newLabel = [NKNumbelLabel label];
                            [array insertObject:newLabel atIndex:(col+row*4)];
                            NSMutableDictionary *attr = [NSMutableDictionary dictionary];
                            attr[NSFontAttributeName] = [UIFont fontWithName:@"Helvetica Neue" size:40];
                            attr[NSForegroundColorAttributeName] = Color(236, 226, 215);
                            NSString *value = [NSString stringWithFormat:@"%ld",targetLabel.text.integerValue*2];
                            targetLabel.attributedText = [[NSAttributedString alloc] initWithString:value attributes:attr];
                        } completion:^(BOOL finished) {
                            [label removeFromSuperview];
                        }];
                    } else {
                        NSLog(@"justmove");
                        targetcol++;
                        [array exchangeObjectAtIndex:(row*4+targetcol) withObjectAtIndex:(row*4+col)];
                        [UIView animateWithDuration:0.2 animations:^{
                            label.frame = CGRectMake(10 + (10 + LABELWH)*targetcol, 10 + (10 + LABELWH)*row, LABELWH, LABELWH);
                        } completion:nil];
                    }
                }

            }
        }
    }
    [gameEngine addLabel:array andGroundView:_groundView];
}

- (void)NKGameEngine:(NKGameEngine *)gameEngine rightGesture:(UISwipeGestureRecognizer *)gesture andMatrix:(NSMutableArray *)array {
    NSLog(@"right");
    for (int row = 0 ; row < 4; row++) {
        __block int targetcol = 3;
        for (int col = 2; col >= 0; col--) {
            NKNumbelLabel *label = array[col + row*4];
            NKNumbelLabel *targetLabel = array[targetcol + row*4];
            if (!label.hidden) {

                if ([targetLabel.text isEqualToString:@""]) {
                    NSLog(@"moveup");
                    [array exchangeObjectAtIndex:(row*4+targetcol) withObjectAtIndex:(row*4+col)];
                    [UIView animateWithDuration:0.2 animations:^{
                        label.frame = CGRectMake(10 + (10 + LABELWH)*targetcol, 10 + (10 + LABELWH)*row, LABELWH, LABELWH);
                    } completion:nil];
                } else {
                    if ([targetLabel.text isEqualToString:label.text]) {
                        //merge
                        NSLog(@"merge");
                        [UIView animateWithDuration:0.2 animations:^{
                            label.frame = targetLabel.frame;
                            [array removeObject:label];
                            NKNumbelLabel *newLabel = [NKNumbelLabel label];
                            [array insertObject:newLabel atIndex:(col+row*4)];
                            NSMutableDictionary *attr = [NSMutableDictionary dictionary];
                            attr[NSFontAttributeName] = [UIFont fontWithName:@"Helvetica Neue" size:40];
                            attr[NSForegroundColorAttributeName] = Color(236, 226, 215);
                            NSString *value = [NSString stringWithFormat:@"%ld",targetLabel.text.integerValue*2];
                            targetLabel.attributedText = [[NSAttributedString alloc] initWithString:value attributes:attr];
                        } completion:^(BOOL finished) {
                            [label removeFromSuperview];
                        }];
                    } else {
                        NSLog(@"justmove");
                        targetcol--;
                        [array exchangeObjectAtIndex:(row*4+targetcol) withObjectAtIndex:(row*4+col)];
                        [UIView animateWithDuration:0.2 animations:^{
                            label.frame = CGRectMake(10 + (10 + LABELWH)*targetcol, 10 + (10 + LABELWH)*row, LABELWH, LABELWH);
                        } completion:nil];
                    }
                }

            }
        }
    }
    [gameEngine addLabel:array andGroundView:_groundView];
}

@end
