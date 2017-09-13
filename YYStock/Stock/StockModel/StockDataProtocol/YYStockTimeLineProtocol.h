//
//  YYStockTimeLineProtocol.h
//  YYStock  ( https://github.com/WillkYang )
//
//  Created by WillkYang on 16/10/10.
//  Copyright © 2016年 WillkYang. All rights reserved.
//

#ifndef YYStockTimeLineProtocol_h
#define YYStockTimeLineProtocol_h


#endif /* YYStockTimeLineProtocol_h */
#import <CoreGraphics/CoreGraphics.h>
//提供分时图数据源
@protocol YYStockTimeLineProtocol <NSObject>

@required

/**
 *  价格
 */
@property (nonatomic, readonly) NSNumber *Price;

/**
 *  前一天的收盘价
 */
@property (nonatomic, readonly) CGFloat AvgPrice;

/**
 *  成交量
 */
@property (nonatomic, readonly) CGFloat Volume;

/**
 *  日期
 */
@property (nonatomic, readonly) NSString *TimeDesc;

/**
 是否绘制在View上
 */
@property (nonatomic, readonly) BOOL isShowTimeDesc;

/**
 *  长按时显示的详细日期
 */
@property (nonatomic, readonly) NSString *DayDatail;

@optional

- (instancetype)initWithDict: (NSDictionary *)dict;

@end
