//
//  YYStockView_Kline.h
//  YYStock  ( https://github.com/WillkYang )
//
//  Created by WillkYang on 16/10/5.
//  Copyright © 2016年 WillkYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYStockDataProtocol.h"

@protocol YYStockViewLongPressProtocol;

@interface YYStockView_Kline : UIView

/**
 长按view的代理
 */
@property (nonatomic, weak) id<YYStockViewLongPressProtocol> delegate;

/**
 构造器

 @param lineModels 数据源
 
 @return YYStockView_Kline对象
 */
- (instancetype)initWithLineModels:(NSArray <id<YYLineDataModelProtocol>>*) lineModels;


/**
 重绘视图
 
 @param lineModels  K线数据源
 */
- (void)reDrawWithLineModels:(NSArray <id<YYLineDataModelProtocol>>*) lineModels;
@end

@protocol YYStockViewLongPressProtocol <NSObject>

/**
 长按代理

 @param stockView 长按的view
 @param model     长按时选中的数据
 */
- (void) YYStockView:(YYStockView_Kline *)stockView selectedModel:(id<YYLineDataModelProtocol>)model;
@end
