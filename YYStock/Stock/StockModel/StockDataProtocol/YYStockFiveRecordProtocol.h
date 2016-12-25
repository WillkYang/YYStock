
//
//  YYStockFiveRecordProtocol.h
//  YYStock  ( https://github.com/yate1996 )
//
//  Created by yate1996 on 16/10/10.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#ifndef YYStockFiveRecordProtocol_h
#define YYStockFiveRecordProtocol_h


#endif /* YYStockFiveRecordProtocol_h */
#import <CoreGraphics/CoreGraphics.h>
//提供分时图数据源
@protocol YYStockFiveRecordProtocol <NSObject>

@required

/**
 *  买价格数组
 */
@property (nonatomic, readonly) NSArray *BuyPriceArray;

/**
 *  卖价格数组
 */
@property (nonatomic, readonly) NSArray *SellPriceArray;

/**
 *  买成交量数组
 */
@property (nonatomic, readonly) NSArray *BuyVolumeArray;

/**
 *  卖成交量数组
 */
@property (nonatomic, readonly) NSArray *SellVolumeArray;

/**
 *  买5文字描述
 */
@property (nonatomic, readonly) NSArray *BuyDescArray;

/**
 *  卖5文字描述
 */
@property (nonatomic, readonly) NSArray *SellDescArray;

@optional

- (instancetype)initWithDict: (NSDictionary *)dict;

@end
