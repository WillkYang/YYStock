//
//  YYKlineView.h
//  YYStock  ( https://github.com/WillkYang )
//
//  Created by WillkYang on 16/10/6.
//  Copyright © 2016年 WillkYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYStockDataProtocol.h"

@interface YYKlineView : UIView

- (NSArray *)drawViewWithXPosition:(CGFloat)xPosition drawModels:(NSMutableArray <id<YYLineDataModelProtocol>>*)drawLineModels  maxValue:(CGFloat)maxValue minValue:(CGFloat)minValue;

@end
