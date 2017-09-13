//
//  YYStockVariable.h
//  YYStock  ( https://github.com/WillkYang )
//
//  Created by WillkYang on 16/10/5.
//  Copyright © 2016年 WillkYang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
@interface YYStockVariable : NSObject

/**
 K线图中蜡烛的宽度
 */
+(CGFloat)lineWidth;

/**
 设置K线图中蜡烛的宽度

 @param lineWidth 宽度
 */
+(void)setLineWith:(CGFloat)lineWidth;

/**
  K线图的间隔，初始值为1
 */
+(CGFloat)lineGap;

/**
 设置K线图中蜡烛的间距
 
 @param lineGap 间距
 */
+(void)setLineGap:(CGFloat)lineGap;

/**
  LineView的高度占比,初始值为0.7，剩下的为成交量图的高度占比
 */
+ (CGFloat)lineMainViewRadio;

/**
 设置LineView的高度占比
 
 @param radio 占比
 */
+ (void)setLineMainViewRadio:(CGFloat)radio;

/**
 成交量图的高度占比
 */
+ (CGFloat)volumeViewRadio;

/**
 设置成交量图的高度占比
 
 @param radio 占比
 */
+ (void)setVolumeViewRadio:(CGFloat)radio;

/**
 分时线的成交量线的宽度
 */
+(CGFloat)timeLineVolumeWidth;

/**
 设置分时线的成交量线的宽度
 
 @param timeLineVolumeWidth 宽度
 */
+(void)setTimeLineVolumeWidth:(CGFloat)timeLineVolumeWidth;

+ (void)setStockLineWidthArray:(NSArray <NSNumber *>*)lineWidthArray;

+ (void)setStockLineWidthIndex:(NSInteger)lineWidthindex;

@end
