//
//  NKGameEngine.h
//  My2048Demo
//
//  Created by 陆金龙 on 15/12/27.
//  Copyright © 2015年 Nick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NKGroundView.h"
#import "NKNumbelLabel.h"


@class NKGameEngine;
@protocol NKGameEngineDelegate <NSObject>
- (void)NKGameEngine:(NKGameEngine *)gameEngine upGesture:(UISwipeGestureRecognizer *)gesture andMatrix:(NSMutableArray *)array;
- (void)NKGameEngine:(NKGameEngine *)gameEngine downGesture:(UISwipeGestureRecognizer *)gesture andMatrix:(NSMutableArray *)array;
- (void)NKGameEngine:(NKGameEngine *)gameEngine leftGesture:(UISwipeGestureRecognizer *)gesture andMatrix:(NSMutableArray *)array;
- (void)NKGameEngine:(NKGameEngine *)gameEngine rightGesture:(UISwipeGestureRecognizer *)gesture andMatrix:(NSMutableArray *)array;

@end

@interface NKGameEngine : NSObject

@property (nonatomic, strong) NSMutableArray *array;

@property (nonatomic, strong) id<NKGameEngineDelegate> delegate;

- (void)addLabel:(NSMutableArray *)matrix andGroundView:(UIView *)groundView;
- (void)startGame:(UIView *)view andGroundView:(NKGroundView *)groundView andMatrix:(NSMutableArray *)matrix;


@end
