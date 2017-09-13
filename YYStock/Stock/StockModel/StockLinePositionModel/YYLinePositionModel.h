//
//  YYLinePositionModel.h
//  YYStock  ( https://github.com/WillkYang )
//
//  Created by WillkYang on 16/10/5.
//  Copyright © 2016年 WillkYang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface YYLinePositionModel : NSObject
/**
 *  开盘点
 */
@property (nonatomic, assign) CGPoint OpenPoint;

/**
 *  收盘点
 */
@property (nonatomic, assign) CGPoint ClosePoint;

/**
 *  最高点
 */
@property (nonatomic, assign) CGPoint HighPoint;

/**
 *  最低点
 */
@property (nonatomic, assign) CGPoint LowPoint;

/**
 *  工厂方法
 */
+ (instancetype) modelWithOpen:(CGPoint)openPoint close:(CGPoint)closePoint high:(CGPoint)highPoint low:(CGPoint)lowPoint;

@end
