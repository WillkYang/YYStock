//
//  YYTimeLineMaskView.h
//  YYStock  ( https://github.com/WillkYang )
//
//  Created by WillkYang on 16/10/10.
//  Copyright © 2016年 WillkYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYStockTimeLineProtocol.h"

@interface YYTimeLineMaskView : UIView

//当前长按选中的model
@property (nonatomic, strong) id<YYStockTimeLineProtocol> selectedModel;

//当前长按选中的位置model
@property (nonatomic, assign) CGPoint selectedPoint;

//当前的滑动scrollview
@property (nonatomic, strong) UIScrollView *stockScrollView;

@end
