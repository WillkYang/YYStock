//
//  YYStockScrollView.m
//  YYStock  ( https://github.com/WillkYang )
//
//  Created by WillkYang on 16/10/7.
//  Copyright © 2016年 WillkYang. All rights reserved.
//

#import "YYStockScrollView.h"
#import "UIColor+YYStockTheme.h"
#import "YYStockVariable.h"
#import <Masonry/Masonry.h>
@implementation YYStockScrollView


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (self.isShowBgLine) {
        [self drawBgLines];
    }
}

- (void)drawBgLines {
    if (self.stockType == YYStockTypeLine) {
        //单纯的画了一下背景线
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(ctx, [UIColor YYStock_bgLineColor].CGColor);
        CGContextSetLineWidth(ctx, 0.5);
        CGFloat unitHeight = (self.frame.size.height*[YYStockVariable lineMainViewRadio])/4;
        
        const CGPoint line1[] = {CGPointMake(0, 1),CGPointMake(self.contentSize.width, 1)};
        const CGPoint line2[] = {CGPointMake(0, unitHeight),CGPointMake(self.contentSize.width, unitHeight)};
        const CGPoint line3[] = {CGPointMake(0, unitHeight*2),CGPointMake(self.contentSize.width, unitHeight*2)};
        const CGPoint line4[] = {CGPointMake(0, unitHeight*3),CGPointMake(self.contentSize.width, unitHeight*3)};
        const CGPoint line5[] = {CGPointMake(0, unitHeight*4),CGPointMake(self.contentSize.width, unitHeight*4)};
        const CGPoint line6[] = {CGPointMake(0, self.frame.size.height * (1 - [YYStockVariable volumeViewRadio]) ),CGPointMake(self.contentSize.width, self.frame.size.height * (1 - [YYStockVariable volumeViewRadio]))};
        
        CGContextStrokeLineSegments(ctx, line1, 2);
        CGContextStrokeLineSegments(ctx, line2, 2);
        CGContextStrokeLineSegments(ctx, line3, 2);
        CGContextStrokeLineSegments(ctx, line4, 2);
        CGContextStrokeLineSegments(ctx, line5, 2);
        CGContextStrokeLineSegments(ctx, line6, 2);
    }
    
    if (self.stockType == YYStockTypeTimeLine) {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(ctx, [UIColor YYStock_averageTimeLineColor].CGColor);
        CGFloat lengths[] = {3,3};
        CGContextSetLineDash(ctx, 0, lengths, 2);
        CGContextSetLineWidth(ctx, 1.5);
        CGFloat unitHeight = (self.frame.size.height*[YYStockVariable lineMainViewRadio])/2;
        const CGPoint line1[] = {CGPointMake(0, unitHeight),CGPointMake(self.frame.size.width, unitHeight)};
        CGContextStrokeLineSegments(ctx, line1, 2);
        
        CGContextSetLineDash(ctx, 0, NULL, 0);
        CGContextSetStrokeColorWithColor(ctx, [UIColor YYStock_bgLineColor].CGColor);
        CGContextSetLineWidth(ctx, .5f);
        const CGPoint line2[] = {CGPointMake(0, self.frame.size.height * [YYStockVariable lineMainViewRadio] ),CGPointMake(self.frame.size.width, self.frame.size.height * [YYStockVariable lineMainViewRadio])};
        CGContextStrokeLineSegments(ctx, line2, 2);
        
        
//        CGContextMoveToPoint(ctx, 0, self.frame.size.height * ([YYStockVariable lineMainViewRadio] + [YYStockVariable volumeViewRadio]) - 1);
//        CGContextAddLineToPoint(ctx, self.frame.size.width, self.frame.size.height * ([YYStockVariable lineMainViewRadio] + [YYStockVariable volumeViewRadio]) - 1);
//        CGContextStrokePath(ctx);
//        const CGPoint line3[] = {CGPointMake(0, lineMaxY ),CGPointMake(self.frame.size.width, lineMaxY )};
//        CGContextStrokeLineSegments(ctx, line3, 2);
        CGFloat lineMaxY = self.frame.size.height - YYStockLineDayHeight - YYStockLineVolumeViewMinY;
        CGContextMoveToPoint(ctx, 0, lineMaxY );
        CGContextAddLineToPoint(ctx, self.frame.size.width, lineMaxY );
        CGContextStrokePath(ctx);
    }
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
        [self addSubview:_contentView];
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return _contentView;
}

- (void)setContentSize:(CGSize)contentSize {
    [super setContentSize:contentSize];
    [_contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self);
        make.width.equalTo(@(contentSize.width));
        make.height.equalTo(self);
    }];
}

@end
