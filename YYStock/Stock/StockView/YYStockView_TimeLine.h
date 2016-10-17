//
//  YYStockView_TimeLine.h
//  YYStock  ( https://github.com/yate1996 )
//
//  Created by yate1996 on 16/10/10.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYStockTimeLineProtocol.h"
#import "YYStockFiveRecordProtocol.h"

@protocol YYStockViewTimeLinePressProtocol;

@interface YYStockView_TimeLine : UIView

/**
 长按view的代理
 */
@property (nonatomic, weak) id<YYStockViewTimeLinePressProtocol> delegate;

/**
 构造器
 
 @param timeLineModels 数据源
 @param isShowFiveRecord 是否显示五档数据
 @param fiveRecordModel 五档数据源
 
 @return YYStockView_TimeLine对象
 */
- (instancetype)initWithTimeLineModels:(NSArray <id<YYStockTimeLineProtocol>>*) timeLineModels isShowFiveRecord:(BOOL)isShowFiveRecord fiveRecordModel:(id<YYStockFiveRecordProtocol>)fiveRecordModel;


/**
 重绘视图

 @param timeLineModels  分时线数据源
 @param isShowFiveRecord 是否显示五档图
 @param fiveRecordModel 五档数据源
 */
- (void)reDrawWithTimeLineModels:(NSArray <id<YYStockTimeLineProtocol>>*) timeLineModels isShowFiveRecord:(BOOL)isShowFiveRecord fiveRecordModel:(id<YYStockFiveRecordProtocol>)fiveRecordModel;
@end

@protocol YYStockViewTimeLinePressProtocol <NSObject>

/**
 长按代理
 
 @param stockView 长按的view
 @param model     长按时选中的数据
 */
- (void) YYStockView:(YYStockView_TimeLine *)stockView selectedModel:(id<YYStockTimeLineProtocol>)model;
@end
