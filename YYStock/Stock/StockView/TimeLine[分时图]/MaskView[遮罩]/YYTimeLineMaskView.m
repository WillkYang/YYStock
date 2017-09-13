//
//  YYTimeLineMaskView.m
//  YYStock  ( https://github.com/WillkYang )
//
//  Created by WillkYang on 16/10/10.
//  Copyright © 2016年 WillkYang. All rights reserved.
//

#import "YYTimeLineMaskView.h"
#import "YYStockConstant.h"
#import "YYStockVariable.h"
#import "UIColor+YYStockTheme.h"
@implementation YYTimeLineMaskView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self drawDashLine];
}

/**
 绘制长按的背景线
 */
- (void)drawDashLine {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat lengths[] = {3,3};
    CGContextSetLineDash(ctx, 0, lengths, 2);
    CGContextSetStrokeColorWithColor(ctx, [UIColor YYStock_selectedLineColor].CGColor);
    CGContextSetLineWidth(ctx, 1.5);
    
    CGFloat x = self.stockScrollView.frame.origin.x + self.selectedPoint.x - self.stockScrollView.contentOffset.x;
    
    //绘制横线
    CGContextMoveToPoint(ctx, self.stockScrollView.frame.origin.x, self.stockScrollView.frame.origin.y + self.selectedPoint.y);
    CGContextAddLineToPoint(ctx, self.stockScrollView.frame.origin.x + self.stockScrollView.frame.size.width, self.stockScrollView.frame.origin.y + self.selectedPoint.y);
    
    //绘制竖线
    CGContextMoveToPoint(ctx, x, self.stockScrollView.frame.origin.y);
    CGContextAddLineToPoint(ctx, x, self.stockScrollView.frame.origin.y + self.stockScrollView.bounds.size.height - YYStockLineDayHeight/2.f);
    CGContextStrokePath(ctx);
    
    //绘制交叉圆点
    CGContextSetStrokeColorWithColor(ctx, [UIColor YYStock_selectedPointColor].CGColor);
    CGContextSetFillColorWithColor(ctx, [UIColor YYStock_bgColor].CGColor);
    CGContextSetLineWidth(ctx, 1.5);
    CGContextSetLineDash(ctx, 0, NULL, 0);
    CGContextAddArc(ctx, x, self.stockScrollView.frame.origin.y + self.selectedPoint.y, YYStockPointRadius, 0, 2 * M_PI, 0);
    CGContextDrawPath(ctx, kCGPathFillStroke);
    
    //绘制选中日期
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:9],NSForegroundColorAttributeName:[UIColor YYStock_selectedRectTextColor]};
    NSString *dayText = [self.selectedModel DayDatail];
    CGRect textRect = [self rectOfNSString:dayText attribute:attribute];
    
    if (x + textRect.size.width/2.f + 2 > CGRectGetMaxX(self.stockScrollView.frame)) {
        CGContextSetFillColorWithColor(ctx, [UIColor YYStock_selectedRectBgColor].CGColor);
        CGContextFillRect(ctx, CGRectMake(CGRectGetMaxX(self.stockScrollView.frame) - 4 - textRect.size.width, self.stockScrollView.frame.origin.y + self.stockScrollView.bounds.size.height - YYStockLineDayHeight, textRect.size.width + 4, textRect.size.height + 4));
        [dayText drawInRect:CGRectMake(CGRectGetMaxX(self.stockScrollView.frame) - 4 - textRect.size.width + 2, self.stockScrollView.frame.origin.y + self.stockScrollView.bounds.size.height - YYStockLineDayHeight + 2, textRect.size.width, textRect.size.height) withAttributes:attribute];
    } else {
        CGContextSetFillColorWithColor(ctx, [UIColor YYStock_selectedRectBgColor].CGColor);
        CGContextFillRect(ctx, CGRectMake(x-textRect.size.width/2.f, self.stockScrollView.frame.origin.y + self.stockScrollView.bounds.size.height - YYStockLineDayHeight, textRect.size.width + 4, textRect.size.height + 4));
        [dayText drawInRect:CGRectMake(x-textRect.size.width/2.f + 2, self.stockScrollView.frame.origin.y + self.stockScrollView.bounds.size.height - YYStockLineDayHeight + 2, textRect.size.width, textRect.size.height) withAttributes:attribute];
    }
    
    //绘制选中价格
    NSString *priceText = [NSString stringWithFormat:@"%.2f",[[self.selectedModel Price] floatValue]];
    CGRect priceRect = [self rectOfNSString:priceText attribute:attribute];
    CGContextSetFillColorWithColor(ctx, [UIColor YYStock_selectedRectBgColor].CGColor);
    CGContextFillRect(ctx, CGRectMake(YYStockScrollViewLeftGap - priceRect.size.width - 4, self.stockScrollView.frame.origin.y + self.selectedPoint.y - priceRect.size.height/2.f - 2, priceRect.size.width + 4, priceRect.size.height + 4));
    [priceText drawInRect:CGRectMake(YYStockScrollViewLeftGap - priceRect.size.width - 4 + 2, self.stockScrollView.frame.origin.y + self.selectedPoint.y - priceRect.size.height/2.f, priceRect.size.width, priceRect.size.height) withAttributes:attribute];
    
    //绘制选中增幅
    NSString *text2 = [NSString stringWithFormat:@"%.2f%%",([[self.selectedModel Price] floatValue] - [self.selectedModel AvgPrice])*100/[self.selectedModel AvgPrice]];
    CGSize textSize2 = [self rectOfNSString:text2 attribute:attribute].size;
    CGContextSetFillColorWithColor(ctx, [UIColor YYStock_selectedRectBgColor].CGColor);
    CGContextFillRect(ctx, CGRectMake(CGRectGetMaxX(self.stockScrollView.frame) - textSize2.width - 4, self.stockScrollView.frame.origin.y + self.selectedPoint.y - priceRect.size.height/2.f - 2, textSize2.width + 4, textSize2.height + 4));
    
    CGPoint rightDrawPoint = CGPointMake(CGRectGetMaxX(self.stockScrollView.frame) - textSize2.width - 2 , self.stockScrollView.frame.origin.y + self.selectedPoint.y - priceRect.size.height/2.f);
    [text2 drawAtPoint:rightDrawPoint withAttributes:attribute];
}

- (CGRect)rectOfNSString:(NSString *)string attribute:(NSDictionary *)attribute {
    CGRect rect = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, 0)
                                       options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading
                                    attributes:attribute
                                       context:nil];
    return rect;
}

@end
