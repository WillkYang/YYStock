//
//  YYStockViewMaskView.h
//  YYStock  ( https://github.com/WillkYang )
//
//  Created by WillkYang on 16/10/16.
//  Copyright © 2016年 WillkYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYStockDataProtocol.h"
#import "YYStockTimeLineProtocol.h"
#import "YYStockConstant.h"

@interface YYStockViewMaskView : UIView

/**
 当前长按选中的model
 */
@property (nonatomic, strong) id<YYLineDataModelProtocol> selectedModel;

/**
 K线类型
 */
@property (nonatomic, assign) YYStockType stockType;

@end
