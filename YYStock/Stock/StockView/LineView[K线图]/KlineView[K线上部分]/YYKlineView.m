//
//  YYKlineView.m
//  YYStock  ( https://github.com/yate1996 )
//
//  Created by yate1996 on 16/10/6.
//  Copyright © 2016年 yate1996. All rights reserved.
//  绘制蜡烛和左边的数值

#import "YYKline.h"
#import "MAline.h"
#import "YYKlineView.h"
#import "YYStockVariable.h"
#import "YYStockConstant.h"
#import "UIColor+YYStockTheme.h"
#import "YYLinePositionModel.h"
@interface YYKlineView()

@property (nonatomic, strong) NSMutableArray *drawPositionModels;

@property (nonatomic, strong) NSArray <id<YYLineDataModelProtocol>>*drawLineModels;

@property (nonatomic, strong) NSMutableArray *MA5Positions;

@property (nonatomic, strong) NSMutableArray *MA10Positions;

@property (nonatomic, strong) NSMutableArray *MA20Positions;

@end

@implementation YYKlineView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    if (!self.drawPositionModels) {
        return;
    }
    
    if (self.drawPositionModels.count > 0) {
        YYKline *line = [[YYKline alloc] initWithContext:ctx drawModels:self.drawLineModels linePositionModels:self.drawPositionModels];
        [line draw];
    }
    
    if(self.MA5Positions.count > 0) {
        MAline *ma5Line = [[MAline alloc]initWithContext:ctx];
        [ma5Line drawWithColor:[UIColor YYStock_MA5LineColor] maPositions:self.MA5Positions];
    }
    
    if(self.MA10Positions.count > 0) {
        MAline *ma10Line = [[MAline alloc]initWithContext:ctx];
        [ma10Line drawWithColor:[UIColor YYStock_MA10LineColor] maPositions:self.MA10Positions];
    }
    
    if(self.MA20Positions.count > 0) {
        MAline *ma20Line = [[MAline alloc]initWithContext:ctx];
        [ma20Line drawWithColor:[UIColor YYStock_MA20LineColor] maPositions:self.MA20Positions];
    }
    
}

- (NSArray *)drawViewWithXPosition:(CGFloat)xPosition drawModels:(NSMutableArray <id<YYLineDataModelProtocol>>*)drawLineModels  maxValue:(CGFloat)maxValue minValue:(CGFloat)minValue {
    NSAssert(drawLineModels, @"数据源不能为空");
    //转换为实际坐标
    [self convertToPositionModelsWithXPosition:xPosition drawLineModels:drawLineModels maxValue:maxValue minValue:minValue];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setNeedsDisplay];
    });
    return [self.drawPositionModels copy];
}

- (NSArray *)convertToPositionModelsWithXPosition:(CGFloat)startX drawLineModels:(NSArray <id<YYLineDataModelProtocol>>*)drawLineModels  maxValue:(CGFloat)maxValue minValue:(CGFloat)minValue {
    if (!drawLineModels) return nil;

    _drawLineModels = drawLineModels;
    [self.drawPositionModels removeAllObjects];
    [self.MA5Positions removeAllObjects];
    [self.MA10Positions removeAllObjects];
    [self.MA20Positions removeAllObjects];

    CGFloat minY = YYStockLineMainViewMinY;
    CGFloat maxY = self.frame.size.height - YYStockLineMainViewMinY;
    CGFloat unitValue = (maxValue - minValue)/(maxY - minY);
    if (unitValue == 0) unitValue = 0.01f;
    
    [drawLineModels enumerateObjectsUsingBlock:^(id<YYLineDataModelProtocol>  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat xPosition = startX + idx * ([YYStockVariable lineWidth] + [YYStockVariable lineGap]);
        CGPoint highPoint = CGPointMake(xPosition, ABS(maxY - (model.High.floatValue - minValue)/unitValue));
        CGPoint lowPoint = CGPointMake(xPosition, ABS(maxY - (model.Low.floatValue - minValue)/unitValue));
        CGPoint openPoint = CGPointMake(xPosition, ABS(maxY - (model.Open.floatValue - minValue)/unitValue));
        CGFloat closePointY = ABS(maxY - (model.Close.floatValue - minValue)/unitValue);
        
        //格式化openPoint和closePointY
        if(ABS(closePointY - openPoint.y) < YYStockLineMinThick) {
            NSLog(@"%f",closePointY);
            NSLog(@"%f",openPoint.y);
//            if (openPoint.y == closePointY) {
//                
//            }
            if(openPoint.y > closePointY) {
                openPoint.y = closePointY + YYStockLineMinThick;
            } else if(openPoint.y < closePointY) {
                closePointY = openPoint.y + YYStockLineMinThick;
            } else {
                if(idx > 0) {
                    id<YYLineDataModelProtocol> preKLineModel = drawLineModels[idx-1];
                    if(model.Open.floatValue > preKLineModel.Close.floatValue) {
                        openPoint.y = closePointY + YYStockLineMinThick;
                    } else {
                        closePointY = openPoint.y + YYStockLineMinThick;
                    }
                } else if(idx+1 < drawLineModels.count) {
                    //idx==0即第一个时
                    id<YYLineDataModelProtocol> subKLineModel = drawLineModels[idx+1];
                    if(model.Close.floatValue < subKLineModel.Open.floatValue) {
                        openPoint.y = closePointY + YYStockLineMinThick;
                    } else {
                        closePointY = openPoint.y + YYStockLineMinThick;
                    }
                } else {
                    openPoint.y = closePointY - YYStockLineMinThick;
                }
            }
        }
        CGPoint closePoint = CGPointMake(xPosition, closePointY);
        YYLinePositionModel *positionModel = [YYLinePositionModel modelWithOpen:openPoint close:closePoint high:highPoint low:lowPoint];
        [self.drawPositionModels addObject:positionModel];
        
        if (model.MA5.floatValue > 0.f) {
            [self.MA5Positions addObject: [NSValue valueWithCGPoint:CGPointMake(xPosition, ABS(maxY - (model.MA5.floatValue - minValue)/unitValue))]];
        }
        if (model.MA10.floatValue > 0.f) {
            [self.MA10Positions addObject: [NSValue valueWithCGPoint:CGPointMake(xPosition, ABS(maxY - (model.MA10.floatValue - minValue)/unitValue))]];
        }
        if (model.MA20.floatValue > 0.f) {
            [self.MA20Positions addObject: [NSValue valueWithCGPoint:CGPointMake(xPosition, ABS(maxY - (model.MA20.floatValue - minValue)/unitValue))]];
        }
    }];
    
    return self.drawPositionModels ;
}
- (NSMutableArray *)drawPositionModels {
    if (!_drawPositionModels) {
        _drawPositionModels = [NSMutableArray array];
    }
    return _drawPositionModels;
}

- (NSMutableArray *)MA5Positions {
    if (!_MA5Positions) {
        _MA5Positions = [NSMutableArray array];
    }
    return _MA5Positions;
}

- (NSMutableArray *)MA10Positions {
    if (!_MA10Positions) {
        _MA10Positions = [NSMutableArray array];
    }
    return _MA10Positions;
}

- (NSMutableArray *)MA20Positions {
    if (!_MA20Positions) {
        _MA20Positions = [NSMutableArray array];
    }
    return _MA20Positions;
}
@end
