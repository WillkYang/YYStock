//
//  YYKlineView.h
//  YYStock  ( https://github.com/yate1996 )
//
//  Created by yate1996 on 16/10/6.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYStockDataProtocol.h"

@interface YYKlineView : UIView

- (NSArray *)drawViewWithXPosition:(CGFloat)xPosition drawModels:(NSMutableArray <id<YYLineDataModelProtocol>>*)drawLineModels  maxValue:(CGFloat)maxValue minValue:(CGFloat)minValue;

@end
