//
//  YYStockVariable.m
//  YYStock  ( https://github.com/WillkYang )
//
//  Created by WillkYang on 16/10/5.
//  Copyright © 2016年 WillkYang. All rights reserved.
//

#import "YYStockVariable.h"
#import "YYStockConstant.h"

/**
 K线图中蜡烛的宽度
 */
static CGFloat YYStockLineWidth = 6;

/**
 分时图成交量线宽度
 */
static CGFloat YYStockTimeLineVolumeWidth = 6;

/**
 K线图的间隔，初始值为1
 */
static CGFloat YYStockLineGap = 1;

/**
 KLineView的高度占比
 */
static CGFloat YYStockLineViewRadio = 0.6;

/**
 成交量图的高度占比
 */
static CGFloat YYStockVolumeViewRadio = 0.3;

/**
 设置K线宽度数组
 */
static NSMutableArray *YYStockLineWidthArray;

/**
 设置当前从哪个K线宽度数组进行存取
 */
static NSInteger YYStockLineWidthIndex;


@implementation YYStockVariable

/**
 K线图中蜡烛的宽度
 */
+(CGFloat)lineWidth
{
    if (YYStockLineWidthIndex >= 0 && YYStockLineWidthArray && [YYStockLineWidthArray count] > YYStockLineWidthIndex) {
        return [YYStockLineWidthArray[YYStockLineWidthIndex] floatValue];
    } else {
        return YYStockLineWidth;
    }
}

/**
 设置K线图中蜡烛的宽度
 
 @param lineWidth 宽度
 */
+(void)setLineWith:(CGFloat)lineWidth
{
    if (lineWidth > YYStockLineMaxWidth) {
        lineWidth = YYStockLineMaxWidth;
    }else if (lineWidth < YYStockLineMinWidth){
        lineWidth = YYStockLineMinWidth;
    }
    if (YYStockLineWidthIndex >= 0 && YYStockLineWidthArray && [YYStockLineWidthArray count] > YYStockLineWidthIndex) {
        YYStockLineWidthArray[YYStockLineWidthIndex] = [NSNumber numberWithFloat:lineWidth];
    } else {
        YYStockLineWidth = lineWidth;
    }
}

/**
 分时线的成交量线的宽度
 */
+(CGFloat)timeLineVolumeWidth {
    return YYStockTimeLineVolumeWidth;
}

/**
 设置分时线的成交量线的宽度
 
 @param timeLineVolumeWidth 宽度
 */
+(void)setTimeLineVolumeWidth:(CGFloat)timeLineVolumeWidth {
    YYStockTimeLineVolumeWidth = timeLineVolumeWidth;
}

/**
 K线图的间隔，初始值为1
 */
+(CGFloat)lineGap
{
    return YYStockLineGap;
}

/**
 设置K线图中蜡烛的间距
 
 @param lineGap 间距
 */
+(void)setLineGap:(CGFloat)lineGap
{
    YYStockLineGap = lineGap;
}

/**
 LineView的高度占比,初始值为0.6，剩下的为成交量图的高度占比
 */
+ (CGFloat)lineMainViewRadio
{
    return YYStockLineViewRadio;
}

/**
 设置LineView的高度占比
 
 @param radio 占比
 */
+ (void)setLineMainViewRadio:(CGFloat)radio
{
    YYStockLineViewRadio = radio;
}

/**
 成交量图的高度占比
 */
+ (CGFloat)volumeViewRadio {
    return YYStockVolumeViewRadio;
}

/**
 设置成交量图的高度占比
 
 @param radio 占比
 */
+ (void)setVolumeViewRadio:(CGFloat)radio {
    YYStockVolumeViewRadio = radio;
}


+ (void)setStockLineWidthArray:(NSArray <NSNumber *>*)lineWidthArray {
    YYStockLineWidthArray = lineWidthArray.mutableCopy;
}

+ (void)setStockLineWidthIndex:(NSInteger)lineWidthindex {
    YYStockLineWidthIndex = lineWidthindex;
}
@end
