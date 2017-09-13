//
//  YYKline.h
//  YYStock  ( https://github.com/WillkYang )
//
//  Created by WillkYang on 16/10/7.
//  Copyright © 2016年 WillkYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYStockDataProtocol.h"
@class YYLinePositionModel;
@interface YYKline : UIView

- (instancetype)initWithContext:(CGContextRef)context drawModels:(NSArray <id<YYLineDataModelProtocol>>*)drawLineModels linePositionModels:(NSArray <YYLinePositionModel *>*)linePositionModels;

- (void)draw;

@end
