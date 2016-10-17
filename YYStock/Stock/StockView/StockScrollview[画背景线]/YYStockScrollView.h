//
//  YYStockScrollView.h
//  YYStock  ( https://github.com/yate1996 )
//
//  Created by yate1996 on 16/10/7.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYStockConstant.h"
@interface YYStockScrollView : UIScrollView

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, assign) YYStockType stockType;

@property (nonatomic, assign) BOOL isShowBgLine;
@end
