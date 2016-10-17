//
//  YYKline.m
//  YYStock  ( https://github.com/yate1996 )
//
//  Created by yate1996 on 16/10/7.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "YYKline.h"
#import "UIColor+YYStockTheme.h"
#import "YYStockVariable.h"
#import "YYStockConstant.h"
@interface YYKline()
@property (nonatomic, assign) CGContextRef context;
@end

@implementation YYKline

- (instancetype)initWithContext:(CGContextRef)context {
    self = [super init];
    if (self) {
        _context = context;
    }
    return self;
}

- (void)draw {
    if (!self.kLinePositionModel || !self.context) return;
    
    CGContextRef ctx = self.context;
    
    UIColor *strokeColor = self.kLinePositionModel.OpenPoint.y > self.kLinePositionModel.ClosePoint.y ? [UIColor YYStock_decreaseColor] : [UIColor YYStock_increaseColor];
    CGContextSetStrokeColorWithColor(ctx, strokeColor.CGColor);
    
    CGContextSetLineWidth(ctx, [YYStockVariable lineWidth]);
    const CGPoint solidPoints[] = {self.kLinePositionModel.OpenPoint,self.kLinePositionModel.ClosePoint};
    CGContextStrokeLineSegments(ctx, solidPoints, 2);
    
    CGContextSetLineWidth(ctx, YYStockShadowLineWidth);
    const CGPoint shadowPoints[] = {self.kLinePositionModel.HighPoint, self.kLinePositionModel.LowPoint};
    CGContextStrokeLineSegments(ctx, shadowPoints, 2);
    
    //绘制红色空心线
    CGFloat gap = 2.f;
    if (self.kLinePositionModel.OpenPoint.y > self.kLinePositionModel.ClosePoint.y && ABS(self.kLinePositionModel.OpenPoint.y - self.kLinePositionModel.ClosePoint.y) > gap) {
        CGContextSetStrokeColorWithColor(ctx, [UIColor YYStock_bgColor].CGColor);
        CGContextSetLineWidth(ctx, [YYStockVariable lineWidth] - gap);
        const CGPoint solidPoints[] = {CGPointMake(self.kLinePositionModel.OpenPoint.x, self.kLinePositionModel.OpenPoint.y - gap/2.f),CGPointMake(self.kLinePositionModel.ClosePoint.x, self.kLinePositionModel.ClosePoint.y + gap/2.f)};
        CGContextStrokeLineSegments(ctx, solidPoints, 2);
    }

}

@end
