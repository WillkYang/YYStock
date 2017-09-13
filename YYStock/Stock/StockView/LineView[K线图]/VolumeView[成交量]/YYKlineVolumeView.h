//
//  YYKlineVolumeView.h
//  YYStock  ( https://github.com/WillkYang )
//
//  Created by WillkYang on 16/10/7.
//  Copyright © 2016年 WillkYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYStockDataProtocol.h"
#import "YYLinePositionModel.h"
@interface YYKlineVolumeView : UIView

@property (nonatomic, weak) UIScrollView *parentScrollView;

- (void)drawViewWithXPosition:(CGFloat)xPosition drawModels:(NSArray <id<YYLineDataModelProtocol>>*)drawLineModels linePositionModels:(NSArray <YYLinePositionModel *>*)linePositionModels;

@end
