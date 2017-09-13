//
//  YYStockConstant.h
//  YYStock  ( https://github.com/WillkYang )
//
//  Created by WillkYang on 16/10/5.
//  Copyright © 2016年 WillkYang. All rights reserved.
//

#ifndef YYStockConstant_h
#define YYStockConstant_h


#endif /* YYStockConstant_h */

/**
 *  K线最小的厚度
 */
#define YYStockLineMinThick 0.5


/**
 *  K线最大的宽度
 */
#define YYStockLineMaxWidth 20

/**
 *  K线图最小的宽度
 */
#define YYStockLineMinWidth 3

/**
 *  时分线的宽度
 */
#define YYStockTimeLineWidth 1

/**
 *  上下影线宽度
 */
#define YYStockShadowLineWidth 1.2

/**
 *  MA线宽度
 */
#define YYStockMALineLineWidth 1.2

/**
 * 圆点的半径
 */
#define YYStockPointRadius 3

/**
 *  K线图上可画区域最小的Y
 */
#define YYStockLineMainViewMinY 2

/**
 *  K线图的成交量上最小的Y
 */
#define YYStockLineVolumeViewMinY 2

/**
 *  K线图的成交量下面日期高度
 */
#define YYStockLineDayHeight 20


/**
 *  TopBar的高度
 */
#define YYStockTopBarViewHeight 40

/**
 *  TopBar的按钮宽度
 */
#define YYStockTopBarViewWidth 94

/**
 *  TopBar和StockView的间距
 */
#define YYStockViewGap 1


/**
 *  K线ScrollView距离顶部的距离
 */
#define YYStockScrollViewTopGap 25

/**
 *  K线ScrollView距离左边的距离
 */
#define YYStockScrollViewLeftGap 45

/**
 *  TimeLineView文字距离左边的距离
 */
#define YYStockTimeLineViewLeftGap 12

/**
 *  分时图成交量线的间距
 */
#define YYStockTimeLineViewVolumeGap 0.1

/**
 *  五档图宽度
 */
#define YYStockFiveRecordViewWidth 95

/**
 *  五档图高度
 */
#define YYStockFiveRecordViewHeight 175


/**
 *  K线图缩放界限
 */
#define  YYStockLineScaleBound 0.03

/**
 *  K线的缩放因子
 */
#define YYStockLineScaleFactor 0.06

//Kline种类
typedef NS_ENUM(NSInteger, YYStockType) {
    YYStockTypeLine = 1,    //K线
    YYStockTypeTimeLine,  //分时图
    YYStockTypeOther
};


//Accessory指标种类
typedef NS_ENUM(NSInteger, YYStockTargetLineStatus) {
    YYStockTargetLineStatusMACD = 100,    //MACD线
    YYStockTargetLineStatusKDJ,    //KDJ线
    YYStockTargetLineStatusAccessoryClose,    //关闭Accessory线
    YYStockTargetLineStatusMA , //MA线
    YYStockTargetLineStatusEMA,  //EMA线
    YYStockTargetLineStatusCloseMA  //MA关闭线
    
};
