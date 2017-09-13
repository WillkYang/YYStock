//
//  YYTimeLineVolumeView.m
//  YYStock  ( https://github.com/WillkYang )
//
//  Created by WillkYang on 16/10/10.
//  Copyright © 2016年 WillkYang. All rights reserved.
//

#import "YYTimeLineVolumeView.h"
#import "YYStockVariable.h"
#import "YYStockConstant.h"
#import "UIColor+YYStockTheme.h"
@interface YYTimeLineVolumeView()

@property (nonatomic, strong) NSMutableArray *drawPositionModels;

@end
@implementation YYTimeLineVolumeView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    if (!self.drawPositionModels) {
        return;
    }
    
    CGFloat lineMaxY = self.frame.size.height - YYStockLineDayHeight - YYStockLineVolumeViewMinY;
    
    //绘制背景色
    YYVolumePositionModel *lastModel = self.drawPositionModels.lastObject;
    CGContextSetFillColorWithColor(ctx, [UIColor YYStock_timeLineBgColor].CGColor);
    CGContextFillRect(ctx, CGRectMake(0, 0, lastModel.EndPoint.x, lineMaxY));
    

    
    [self.drawPositionModels enumerateObjectsUsingBlock:^(YYVolumePositionModel  *_Nonnull pModel, NSUInteger idx, BOOL * _Nonnull stop) {
        
        //绘制成交量线
        CGContextSetStrokeColorWithColor(ctx, [UIColor YYStock_TimeLineColor].CGColor);
        CGContextSetLineWidth(ctx, [YYStockVariable timeLineVolumeWidth]);
        const CGPoint solidPoints[] = {pModel.StartPoint, pModel.EndPoint};
        CGContextStrokeLineSegments(ctx, solidPoints, 2);
        
        //绘制日期
        if (pModel.DayDesc.length > 0) {
            NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor YYStock_topBarNormalTextColor]};
            CGRect rect = [pModel.DayDesc boundingRectWithSize:CGSizeMake(MAXFLOAT, 0)
                                                       options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |
                           NSStringDrawingUsesFontLeading
                                                    attributes:attribute
                                                       context:nil];
            
            CGFloat width = rect.size.width;
            if (pModel.StartPoint.x - width/2.f < 0) {
                //最左边判断
                [pModel.DayDesc drawAtPoint:CGPointMake(pModel.StartPoint.x, pModel.EndPoint.y) withAttributes:attribute];
            } else if(pModel.StartPoint.x + width/2.f > self.bounds.size.width) {
                //最右边判断
                [pModel.DayDesc drawAtPoint:CGPointMake(pModel.StartPoint.x - width, pModel.EndPoint.y) withAttributes:attribute];
            } else {
                [pModel.DayDesc drawAtPoint:CGPointMake(pModel.StartPoint.x - width/2.f, pModel.EndPoint.y) withAttributes:attribute];
            }
        }
    }];
    
}

- (void)drawViewWithXPosition:(CGFloat)xPosition drawModels:(NSArray <id<YYStockTimeLineProtocol>>*)drawLineModels {
    NSAssert(drawLineModels, @"数据源不能为空");
    //转换为实际坐标
    [self convertToPositionModelsWithXPosition:xPosition drawLineModels:drawLineModels];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setNeedsDisplay];
    });
}

- (void)convertToPositionModelsWithXPosition:(CGFloat)startX drawLineModels:(NSArray <id<YYStockTimeLineProtocol>>*)drawLineModels  {
    if (!drawLineModels) return;
    
    [self.drawPositionModels removeAllObjects];
    
    CGFloat minValue =  [[[drawLineModels valueForKeyPath:@"Volume"] valueForKeyPath:@"@min.floatValue"] floatValue];
    CGFloat maxValue =  [[[drawLineModels valueForKeyPath:@"Volume"] valueForKeyPath:@"@max.floatValue"] floatValue];
    
    CGFloat minY = YYStockLineVolumeViewMinY;
    CGFloat maxY = self.frame.size.height - YYStockLineVolumeViewMinY - YYStockLineDayHeight;
    
    CGFloat unitValue = (maxValue - minValue)/(maxY - minY);
    
    [drawLineModels enumerateObjectsUsingBlock:^(id<YYStockTimeLineProtocol>  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat xPosition = startX + idx * ([YYStockVariable timeLineVolumeWidth] + YYStockTimeLineViewVolumeGap);
        CGFloat yPosition = ABS(maxY - (model.Volume - minValue)/unitValue);
        
        CGPoint startPoint = CGPointMake(xPosition, ABS(yPosition - maxY) > 1 ? yPosition : maxY );
        CGPoint endPoint = CGPointMake(xPosition, maxY);
        
        NSString *dayDesc = model.isShowTimeDesc ? model.TimeDesc : @"";
        
        YYVolumePositionModel *positionModel = [YYVolumePositionModel modelWithStartPoint:startPoint endPoint:endPoint dayDesc:dayDesc];
        [self.drawPositionModels addObject:positionModel];
        
    }];
}
- (NSMutableArray *)drawPositionModels {
    if (!_drawPositionModels) {
        _drawPositionModels = [NSMutableArray array];
    }
    return _drawPositionModels;
}
@end
