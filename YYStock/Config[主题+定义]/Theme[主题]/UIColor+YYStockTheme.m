/*
 作者：  yate1996
 文件：  UIColor+YYStockTheme.m
 版本：  1.0 <2016.10.05>
 */

#import "UIColor+YYStockTheme.h"

@implementation UIColor (YYStockTheme)

+ (UIColor *)colorWithHex:(UInt32)hex {
    return [UIColor colorWithHex:hex alpha:1.f];
}

+ (UIColor *)colorWithHex:(UInt32)hex alpha:(CGFloat)alpha {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:alpha];
}

/************************************K线颜色配置***************************************/

/**
 *  整体背景颜色
 */
+(UIColor *)YYStock_bgColor {
    return [UIColor colorWithHex:0xffffff];
}

/**
 *  K线图背景辅助线颜色
 */
+(UIColor *)YYStock_bgLineColor {
    return [UIColor colorWithHex:0xEDEDED];
}

/**
 *  主文字颜色
 */
+(UIColor *)YYStock_textColor {
    return [UIColor colorWithHex:0xAFAFB3];
}


/**
 *  MA5线颜色
 */
+(UIColor *)YYStock_MA5LineColor {
    return [UIColor colorWithHex:0xFEB911];
}

/**
 *  MA10线颜色
 */
+(UIColor *)YYStock_MA10LineColor {
    return [UIColor colorWithHex:0x60CFFF];
}

/**
 *  MA20线颜色
 */
+(UIColor *)YYStock_MA20LineColor {
    return [UIColor colorWithHex:0xF184F5];
}

/**
 *  长按线颜色
 */
+(UIColor *)YYStock_selectedLineColor {
    return [UIColor colorWithHex:0xACAAA9];
}

/**
 *  长按出现的圆点的颜色
 */
+(UIColor *)YYStock_selectedPointColor {
    return [UIColor YYStock_increaseColor                                                                                  ];
}

/**
 *  长按出现的方块背景颜色
 */
+(UIColor *)YYStock_selectedRectBgColor {
    return [UIColor colorWithHex:0x659EE0];
}

/**
 *  长按出现的方块文字颜色
 */
+(UIColor *)YYStock_selectedRectTextColor {
    return [UIColor colorWithHex:0xffffff];
}

/**
 *  分时线颜色
 */
+(UIColor *)YYStock_TimeLineColor {
    return [UIColor colorWithHex:0x60CFFF];
}

/**
 *  分时均线颜色
 */
+(UIColor *)YYStock_averageTimeLineColor {
    return [UIColor colorWithHex:0x60CFFF];
}

/**
 *  分时线下方背景色
 */
+(UIColor *)YYStock_timeLineBgColor {
    return [UIColor colorWithHex:0x60CFFF alpha:0.1f];
}

/**
 *  涨的颜色
 */
+(UIColor *)YYStock_increaseColor {
    return [UIColor colorWithHex:0xE74C3C];
}

/**
 *  跌的颜色
 */
+(UIColor *)YYStock_decreaseColor {
    return [UIColor colorWithHex:0x41CB47];
}


/************************************TopBar颜色配置***************************************/

/**
 *  顶部TopBar文字默认颜色
 */
+(UIColor *)YYStock_topBarNormalTextColor {
    return [UIColor colorWithHex:0xAFAFB3];
}

/**
 *  顶部TopBar文字选中颜色
 */
+(UIColor *)YYStock_topBarSelectedTextColor {
    return [UIColor colorWithHex:0x4A90E2];
}

/**
 *  顶部TopBar选中块辅助线颜色
 */
+(UIColor *)YYStock_topBarSelectedLineColor {
    return [UIColor colorWithHex:0x4A90E2];
}

@end
