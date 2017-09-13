/*
 作者：  WillkYang
 文件：  UIColor+YYStockTheme.m
 版本：  1.0 <2016.10.05>
 地址：
 描述：  提供YYStock颜色输出
 */

#import <UIKit/UIKit.h>

@interface UIColor (YYStockTheme)

/************************************K线颜色配置***************************************/

/**
*  整体背景颜色
*/
+(UIColor *)YYStock_bgColor;

/**
 *  K线图背景辅助线颜色
 */
+(UIColor *)YYStock_bgLineColor;

/**
 *  主文字颜色
 */
+(UIColor *)YYStock_textColor;


/**
 *  MA5线颜色
 */
+(UIColor *)YYStock_MA5LineColor;

/**
 *  MA10线颜色
 */
+(UIColor *)YYStock_MA10LineColor;

/**
 *  MA20线颜色
 */
+(UIColor *)YYStock_MA20LineColor;

/**
 *  长按线颜色
 */
+(UIColor *)YYStock_selectedLineColor;

/**
 *  长按出现的圆点的颜色
 */
+(UIColor *)YYStock_selectedPointColor;

/**
 *  长按出现的方块背景颜色
 */
+(UIColor *)YYStock_selectedRectBgColor;

/**
 *  长按出现的方块文字颜色
 */
+(UIColor *)YYStock_selectedRectTextColor;


/**
 *  分时线颜色
 */
+(UIColor *)YYStock_TimeLineColor;

/**
 *  分时均线颜色
 */
+(UIColor *)YYStock_averageTimeLineColor;

/**
 *  分时线下方背景色
 */
+(UIColor *)YYStock_timeLineBgColor;




/**
 *  涨的颜色
 */
+(UIColor *)YYStock_increaseColor;

/**
 *  跌的颜色
 */
+(UIColor *)YYStock_decreaseColor;


/************************************TopBar颜色配置***************************************/

/**
 *  顶部TopBar文字默认颜色
 */
+(UIColor *)YYStock_topBarNormalTextColor;

/**
 *  顶部TopBar文字选中颜色
 */
+(UIColor *)YYStock_topBarSelectedTextColor;

/**
 *  顶部TopBar选中块辅助线颜色
 */
+(UIColor *)YYStock_topBarSelectedLineColor;

@end
