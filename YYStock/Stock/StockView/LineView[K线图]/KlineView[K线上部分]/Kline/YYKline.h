//
//  YYKline.h
//  YYStock  ( https://github.com/yate1996 )
//
//  Created by yate1996 on 16/10/7.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYLinePositionModel.h"
@interface YYKline : UIView

/**
 *  K线的位置model
 */
@property (nonatomic, strong) YYLinePositionModel *kLinePositionModel;

- (instancetype)initWithContext:(CGContextRef)context;

- (void)draw;

@end
