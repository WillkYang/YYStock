//
//  YYTimeLineView.h
//  YYStock  ( https://github.com/WillkYang )
//
//  Created by WillkYang on 16/10/5.
//  Copyright © 2016年 WillkYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYStockTimeLineProtocol.h"
@interface YYTimeLineView : UIView
- (NSArray *)drawViewWithXPosition:(CGFloat)xPosition drawModels:(NSArray <id<YYStockTimeLineProtocol>>*)drawLineModels  maxValue:(CGFloat)maxValue minValue:(CGFloat)minValue;

@end
