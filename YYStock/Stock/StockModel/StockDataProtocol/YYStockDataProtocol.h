//
//  YYStockDataProtocol.h
//  YYStock  ( https://github.com/yate1996 )
//
//  Created by yate1996 on 16/10/5.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#ifndef YYStockDataProtocol_h
#define YYStockDataProtocol_h


#endif /* YYStockDataProtocol_h */

//提供K线数据源
@protocol YYLineDataModelProtocol <NSObject>

@required

/**
 *  开盘价
 */
@property (nonatomic, readonly) NSNumber *Open;

/**
 *  收盘价
 */
@property (nonatomic, readonly) NSNumber *Close;

/**
 *  最高价
 */
@property (nonatomic, readonly) NSNumber *High;

/**
 *  最低价
 */
@property (nonatomic, readonly) NSNumber *Low;

/**
 *  成交量
 */
@property (nonatomic, readonly) CGFloat Volume;

/**
 *  日期
 */
@property (nonatomic, readonly) NSString *Day;
/**
 是否绘制在View上
 */
@property (nonatomic, readonly) BOOL isShowDay;

/**
 *  长按时显示的详细日期
 */
@property (nonatomic, readonly) NSString *DayDatail;

@optional

- (instancetype)initWithDict: (NSDictionary *)dict;

/**
 *  MA5
 */
@property (nonatomic, readonly) NSNumber *MA5;

/**
 *  MA10
 */
@property (nonatomic, readonly) NSNumber *MA10;

/**
 *  MA20
 */
@property (nonatomic, readonly) NSNumber *MA20;

@end
