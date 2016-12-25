//
//  YYStock.h
//  YYStock  ( https://github.com/yate1996 )
//
//  Created by yate1996 on 16/10/5.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YYStockDataProtocol.h"
#import "YYStockFiveRecordProtocol.h"
#import "YYStockConstant.h"
@class YYStock;

@protocol YYStockDataSource <NSObject>
@required

/**
 K线的数据源
 */
-(NSArray *) YYStock:(YYStock *)stock stockDatasOfIndex:(NSInteger)index;

/**
 K线的顶部栏文字
 */
-(NSArray <NSString *> *) titleItemsOfStock:(YYStock *)stock;

/**
 K线的类型
 */
-(YYStockType)stockTypeOfIndex:(NSInteger)index;

@optional

/**
 分时图是否显示五档数据
 */
-(BOOL)isShowfiveRecordModelOfIndex:(NSInteger)index;

/**
 五档图数据源
 */
-(id<YYStockFiveRecordProtocol>)fiveRecordModelOfIndex:(NSInteger)index;

@end

@interface YYStock : NSObject

/**
 YYStock的ContentView
 */
@property (nonatomic, strong) UIView *mainView;

/**
 构造器

 @param frame      frame
 @param dataSource 数据源

 @return YYStock对象
 */
- (instancetype)initWithFrame:(CGRect)frame dataSource:(id)dataSource;

/**
 开始绘制
 */
- (void)draw;

/**
 stockView的容器
 */
@property (nonatomic, strong) UIView *containerView;

/**
 当前选中的ViewIndex
 */
@property (nonatomic, assign) NSInteger currentIndex;

@end
