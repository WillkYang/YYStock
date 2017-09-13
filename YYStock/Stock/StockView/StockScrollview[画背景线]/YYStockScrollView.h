//
//  YYStockScrollView.h
//  YYStock  ( https://github.com/WillkYang )
//
//  Created by WillkYang on 16/10/7.
//  Copyright © 2016年 WillkYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYStockConstant.h"
@interface YYStockScrollView : UIScrollView

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, assign) YYStockType stockType;

@property (nonatomic, assign) BOOL isShowBgLine;
@end
