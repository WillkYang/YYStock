//
//  YYStockView_Kline.m
//  YYStock  ( https://github.com/WillkYang )
//
//  Created by WillkYang on 16/10/5.
//  Copyright © 2016年 WillkYang. All rights reserved.
//

#import "YYStockView_Kline.h"
#import "YYKlineView.h"
#import "YYKlineVolumeView.h"
#import <Masonry/Masonry.h>
#import "YYStockConstant.h"
#import "YYStockVariable.h"
#import "UIColor+YYStockTheme.h"
#import "YYStockScrollView.h"
#import "YYKlineMaskView.h"
@interface YYStockView_Kline() <UIScrollViewDelegate>

@property (nonatomic, strong) YYStockScrollView *stockScrollView;

/**
 数据源
 */
@property (nonatomic, strong) NSArray <id<YYLineDataModelProtocol>>*lineModels;

/**
 K线部分
 */
@property (nonatomic, copy) YYKlineView *kLineView;

/**
 成交量部分
 */
@property (nonatomic, copy) YYKlineVolumeView *volumeView;

/**
 当前绘制在屏幕上的数据源数组
 */
@property (nonatomic, strong) NSMutableArray <id<YYLineDataModelProtocol>>*drawLineModels;

/**
 当前绘制在屏幕上的数据源位置数组
 */
@property (nonatomic, copy) NSArray <YYLinePositionModel *>*drawLinePositionModels;

/**
 长按时出现的遮罩View
 */
@property (nonatomic, strong) YYKlineMaskView *maskView;

@end

@implementation YYStockView_Kline {

#pragma mark - 页面上显示的数据
    //图表最大的价格
    CGFloat maxValue;
    //图表最小的价格
    CGFloat minValue;
    //图表最大的成交量
    NSInteger volumeValue;
    //当前长按选中的model
    id<YYLineDataModelProtocol> selectedModel;
}

/**
 构造器
 
 @param lineModels 数据源
 
 @return YYStockView_Kline对象
 */
- (instancetype)initWithLineModels:(NSArray<id<YYLineDataModelProtocol>> *)lineModels {
    self = [super init];
    if (self) {
        _lineModels = lineModels;
        [self initUI];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (self.lineModels.count > 0) {
        if (!self.maskView || self.maskView.isHidden) {
            //更新绘制的数据源
            [self updateDrawModels];
            //更新背景线
            self.stockScrollView.isShowBgLine = YES;
            [self.stockScrollView setNeedsDisplay];
            //绘制K线上部分
            self.drawLinePositionModels = [self.kLineView drawViewWithXPosition:[self xPosition] drawModels:self.drawLineModels maxValue:maxValue minValue:minValue];
            //绘制成交量
            [self.volumeView drawViewWithXPosition:[self xPosition] drawModels:self.drawLineModels linePositionModels:self.drawLinePositionModels];
        } else {
            [self.maskView setNeedsDisplay];
        }
        //绘制左侧文字部分
        [self drawLeftDesc];
        //绘制顶部的MA数据
        [self drawTopDesc];
    }
}


/**
 重绘视图
 
 @param lineModels  K线数据源
 */
- (void)reDrawWithLineModels:(NSArray <id<YYLineDataModelProtocol>>*) lineModels {
    _lineModels = lineModels;
    
//    [YYStockVariable setLineWith:(self.stockScrollView.bounds.size.width / lineModels.count) - [YYStockVariable lineGap]];
    [self layoutIfNeeded];
    [self updateScrollViewContentWidth];
    [self setNeedsDisplay];
    if (self.lineModels.count > 0) {
        self.stockScrollView.contentOffset = CGPointMake(self.stockScrollView.contentSize.width - self.stockScrollView.bounds.size.width, self.stockScrollView.contentOffset.y);
    }
}

/**
 初始化子View
 */
- (void)initUI {
    //加载StockScrollView
    [self initUI_stockScrollView];
    
    //加载LineView
    _kLineView = [YYKlineView new];
    _kLineView.backgroundColor = [UIColor clearColor];
    [_stockScrollView.contentView addSubview:_kLineView];
    [_kLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(_stockScrollView.contentView);
        make.height.equalTo(_stockScrollView.contentView).multipliedBy([YYStockVariable lineMainViewRadio]);
    }];
    
    //加载VolumeView
    _volumeView = [YYKlineVolumeView new];
    _volumeView.backgroundColor = [UIColor clearColor];
    _volumeView.parentScrollView = _stockScrollView;
    [_stockScrollView.contentView addSubview:_volumeView];
    [_volumeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(_stockScrollView.contentView);
        make.height.equalTo(_stockScrollView.contentView).multipliedBy([YYStockVariable volumeViewRadio]);
    }];

}

- (void)initUI_stockScrollView {
    _stockScrollView = [YYStockScrollView new];
    _stockScrollView.stockType = YYStockTypeLine;
    _stockScrollView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    _stockScrollView.showsHorizontalScrollIndicator = NO;
    _stockScrollView.delegate = self;

    [self addSubview:_stockScrollView];
    [_stockScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self).offset(YYStockScrollViewLeftGap);
        make.top.equalTo(self).offset(YYStockScrollViewTopGap);
        make.right.equalTo(self).offset(-12);
    }];
    
    //缩放
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(event_pinchAction:)];
    [_stockScrollView addGestureRecognizer:pinch];
    //长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(event_longPressAction:)];
    [_stockScrollView addGestureRecognizer:longPress];
}

/**
 scrollView滑动重绘页面
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self setNeedsDisplay];
}

/**
 绘制左边的价格部分
 */
- (void)drawLeftDesc {
    
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:9],NSForegroundColorAttributeName:[UIColor YYStock_topBarNormalTextColor]};
    CGSize textSize = [self rectOfNSString:[NSString stringWithFormat:@"%.2f",(maxValue + minValue)/2.f] attribute:attribute].size;
    CGFloat unit = self.stockScrollView.frame.size.height * [YYStockVariable lineMainViewRadio] / 4.f;
    CGFloat unitValue = (maxValue - minValue)/4.f;
    //顶部间距
    for (int i = 0; i < 5; i++) {
        NSString *text = [NSString stringWithFormat:@"%.2f",maxValue - unitValue * i];
        CGPoint drawPoint = CGPointMake((YYStockScrollViewLeftGap - textSize.width)/2, unit * i + YYStockScrollViewTopGap - textSize.height/2.f);
        [text drawAtPoint:drawPoint withAttributes:attribute];
    }
    
    CGFloat volume =  [[[self.drawLineModels valueForKeyPath:@"Volume"] valueForKeyPath:@"@max.floatValue"] floatValue];
    volumeValue = volume;
    
    //尝试转为万手
    CGFloat wVolume = volume/10000.f;
    if (wVolume > 1) {
        //尝试转为亿手
        CGFloat yVolume = wVolume/10000.f;
        if (yVolume > 1) {
            NSString *text = [NSString stringWithFormat:@"%.2f",yVolume];
            CGSize textSize = [self rectOfNSString:text attribute:attribute].size;
            [text drawInRect:CGRectMake(YYStockScrollViewLeftGap - textSize.width - 5, YYStockScrollViewTopGap + self.stockScrollView.frame.size.height * (1 - [YYStockVariable volumeViewRadio]), 60, 20) withAttributes:attribute];
            
            NSString *descText = @"亿手";
            CGSize textSize1 = [self rectOfNSString:descText attribute:attribute].size;
            [descText drawInRect:CGRectMake(YYStockScrollViewLeftGap - textSize1.width - 5, YYStockScrollViewTopGap + 15 + self.stockScrollView.frame.size.height * (1 - [YYStockVariable volumeViewRadio]), 60, 20) withAttributes:attribute];
        } else {
            NSString *text = [NSString stringWithFormat:@"%.2f",wVolume];
            CGSize textSize = [self rectOfNSString:text attribute:attribute].size;
            [text drawInRect:CGRectMake(YYStockScrollViewLeftGap - textSize.width - 5, YYStockScrollViewTopGap + self.stockScrollView.frame.size.height * (1 - [YYStockVariable volumeViewRadio]), 60, 20) withAttributes:attribute];
            NSString *descText = @"万手";
            CGSize textSize1 = [self rectOfNSString:descText attribute:attribute].size;
            [descText drawInRect:CGRectMake(YYStockScrollViewLeftGap - textSize1.width - 5, YYStockScrollViewTopGap + 15 + self.stockScrollView.frame.size.height * (1 - [YYStockVariable volumeViewRadio]), 60, 20) withAttributes:attribute];
        }
    } else {
        NSString *text = [NSString stringWithFormat:@"%.0f",volume];
        CGSize textSize = [self rectOfNSString:text attribute:attribute].size;
        [text drawInRect:CGRectMake(YYStockScrollViewLeftGap - textSize.width - 5, YYStockScrollViewTopGap + self.stockScrollView.frame.size.height * (1 - [YYStockVariable volumeViewRadio]), 60, 20) withAttributes:attribute];
        NSString *descText = @"手";
        CGSize textSize1 = [self rectOfNSString:descText attribute:attribute].size;
        [descText drawInRect:CGRectMake(YYStockScrollViewLeftGap - textSize1.width - 5, YYStockScrollViewTopGap + 15 + self.stockScrollView.frame.size.height * (1 - [YYStockVariable volumeViewRadio]), 60, 20) withAttributes:attribute];
    }
}

/**
 绘制顶部的MA部分
 */
- (void)drawTopDesc {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:9],NSForegroundColorAttributeName:[UIColor YYStock_topBarNormalTextColor]};
    NSString *ma5Text = [NSString stringWithFormat:@"MA5 %.2f",[[selectedModel MA5] floatValue]];
    NSString *ma10Text = [NSString stringWithFormat:@"MA10 %.2f",[[selectedModel MA10] floatValue]];
    NSString *ma20Text = [NSString stringWithFormat:@"MA20 %.2f",[[selectedModel MA20] floatValue]];
    CGRect textRect = [self rectOfNSString:ma5Text attribute:attribute];
    CGContextSetStrokeColorWithColor(ctx, [UIColor YYStock_textColor].CGColor);
    CGFloat gap = 4;

    CGContextSetFillColorWithColor(ctx, [UIColor YYStock_MA5LineColor].CGColor);
    CGContextAddArc(ctx, YYStockScrollViewLeftGap, 10, YYStockPointRadius, 0, 2 * M_PI, 0);
    CGContextDrawPath(ctx, kCGPathFill);
    
    CGRect drawRect = CGRectMake(YYStockScrollViewLeftGap + gap + 2*YYStockPointRadius, 10 - textRect.size.height/2.f , textRect.size.width + 4, textRect.size.height + 4);
    [ma5Text drawInRect:drawRect withAttributes:attribute];
    
    textRect = [self rectOfNSString:ma10Text attribute:attribute];
    
    CGContextSetFillColorWithColor(ctx, [UIColor YYStock_MA10LineColor].CGColor);
    CGContextAddArc(ctx, CGRectGetMaxX(drawRect) + 3*gap, 10, YYStockPointRadius, 0, 2 * M_PI, 0);
    CGContextDrawPath(ctx, kCGPathFill);
    
    drawRect = CGRectMake(CGRectGetMaxX(drawRect) + 2*gap + 2*YYStockPointRadius + gap, 10 - textRect.size.height/2.f , textRect.size.width + 4, textRect.size.height + 4);
    [ma10Text drawInRect:drawRect withAttributes:attribute];

    textRect = [self rectOfNSString:ma20Text attribute:attribute];
    CGContextSetFillColorWithColor(ctx, [UIColor YYStock_MA20LineColor].CGColor);
    CGContextAddArc(ctx, CGRectGetMaxX(drawRect) + 3*gap, 10, YYStockPointRadius, 0, 2 * M_PI, 0);
    CGContextDrawPath(ctx, kCGPathFill);
    
    drawRect = CGRectMake(CGRectGetMaxX(drawRect) + 2*gap + 2*YYStockPointRadius + gap, 10 - textRect.size.height/2.f , textRect.size.width + 4, textRect.size.height + 4);
    [ma20Text drawInRect:drawRect withAttributes:attribute];

}

/**
 更新需要绘制的数据源
 */
- (void)updateDrawModels {

    NSInteger startIndex = [self startIndex];
    NSInteger drawLineCount = (self.stockScrollView.frame.size.width) / ([YYStockVariable lineGap] +  [YYStockVariable lineWidth]);
//    NSInteger drawLineCount = (self.stockScrollView.frame.size.width - [YYStockVariable lineGap]) / ([YYStockVariable lineGap] +  [YYStockVariable lineWidth]);

    
    [self.drawLineModels removeAllObjects];
    NSInteger length = startIndex+drawLineCount < self.lineModels.count ? drawLineCount+1 : self.lineModels.count - startIndex;
    [self.drawLineModels addObjectsFromArray:[self.lineModels subarrayWithRange:NSMakeRange(startIndex, length)]];
    
    //更新顶部ma数据
    selectedModel = self.drawLineModels.lastObject;
    
    //更新最大值最小值-价格
    CGFloat max =  [[[self.drawLineModels valueForKeyPath:@"High"] valueForKeyPath:@"@max.floatValue"] floatValue];
    CGFloat ma5max = [[[self.drawLineModels valueForKeyPath:@"MA5"] valueForKeyPath:@"@max.floatValue"] floatValue];
    CGFloat ma10max = [[[self.drawLineModels valueForKeyPath:@"MA10"] valueForKeyPath:@"@max.floatValue"] floatValue];
    CGFloat ma20max = [[[self.drawLineModels valueForKeyPath:@"MA20"] valueForKeyPath:@"@max.floatValue"] floatValue];
    
    __block CGFloat min =  [[[self.drawLineModels valueForKeyPath:@"Low"] valueForKeyPath:@"@min.floatValue"] floatValue];
    [self.drawLineModels enumerateObjectsUsingBlock:^(id<YYLineDataModelProtocol>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat ma5value = [[obj MA5] floatValue];
        CGFloat ma10value = [[obj MA10] floatValue];
        CGFloat ma20value = [[obj MA20] floatValue];
        if ( ma5value > 0 && ma5value < min ) min = ma5value;
        if ( ma10value > 0 && ma10value < min ) min = ma10value;
        if ( ma20value > 0 && ma20value < min ) min = ma20value;
    }];

    max = MAX(MAX(MAX(ma5max, ma10max), ma20max), max);

    CGFloat average = (min+max) / 2;
    maxValue = max;
    minValue = average * 2 - maxValue;
}

#pragma mark - setter,getter方法
- (NSInteger)xPosition {
    NSInteger leftArrCount = [self startIndex];
    CGFloat startXPosition = (leftArrCount + 1) * [YYStockVariable lineGap] + leftArrCount * [YYStockVariable lineWidth] + [YYStockVariable lineWidth]/2;
    return startXPosition;
}

- (NSMutableArray *)drawLineModels {
    if (!_drawLineModels) {
        _drawLineModels = [NSMutableArray array];
    }
    return _drawLineModels;
}

- (NSInteger)startIndex {
    CGFloat offsetX = self.stockScrollView.contentOffset.x < 0 ? 0 : self.stockScrollView.contentOffset.x;
//    NSUInteger leftCount = ABS(offsetX - [YYStockVariable lineGap]) / ([YYStockVariable lineGap] + [YYStockVariable lineWidth]);
//    NSUInteger leftCount = ceilf((offsetX - [YYStockVariable lineGap]) / ([YYStockVariable lineGap] + [YYStockVariable lineWidth]));
    NSUInteger leftCount = ABS(offsetX) / ([YYStockVariable lineGap] + [YYStockVariable lineWidth]);

    if (leftCount > self.lineModels.count) {
        leftCount = self.lineModels.count - 1;
    }
    return leftCount;
}

- (CGFloat)updateScrollViewContentWidth {
    //根据stockModels的个数和间隔和K线的宽度计算出self的宽度，并设置contentsize
    CGFloat kLineViewWidth = self.lineModels.count * [YYStockVariable lineWidth] + (self.lineModels.count + 1) * [YYStockVariable lineGap];
    
    if(kLineViewWidth < self.stockScrollView.bounds.size.width) {
        kLineViewWidth = self.stockScrollView.bounds.size.width;
    }
    
    //更新scrollview的contentsize
    self.stockScrollView.contentSize = CGSizeMake(kLineViewWidth, self.stockScrollView.contentSize.height);
    return kLineViewWidth;
}

- (void)event_longPressAction:(UILongPressGestureRecognizer *)longPress {
    NSLog(@"进入长按");
    
    
    NSLog(@"%f", [longPress locationInView:self.stockScrollView].x - self.stockScrollView.contentOffset.x);

    
    static CGFloat oldPositionX = 0;
    if(UIGestureRecognizerStateChanged == longPress.state || UIGestureRecognizerStateBegan == longPress.state) {
        
        CGPoint location = [longPress locationInView:self.stockScrollView];
        if (location.x < 0 || location.x > self.stockScrollView.contentSize.width) return;
        
        //暂停滑动
        oldPositionX = location.x;
        NSInteger startIndex = (NSInteger)((oldPositionX - [self xPosition] + ([YYStockVariable lineGap] + [YYStockVariable lineWidth])/2.f) / ([YYStockVariable lineGap] + [YYStockVariable lineWidth]));
        
        if (startIndex < 0) startIndex = 0;
        if (startIndex >= self.drawLineModels.count) startIndex = self.drawLineModels.count - 1;
        
        //长按位置没有数据则退出
        if (startIndex < 0) {
            return;
        }
        
        if (!self.maskView) {
            _maskView = [YYKlineMaskView new];
            _maskView.backgroundColor = [UIColor clearColor];
            [self addSubview:_maskView];
            [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
        } else {
            self.maskView.hidden = NO;
        }
        
        selectedModel = self.drawLineModels[startIndex];
        self.maskView.selectedModel = self.drawLineModels[startIndex];
        self.maskView.selectedPositionModel = self.drawLinePositionModels[startIndex];
        self.maskView.stockScrollView = self.stockScrollView;
        [self setNeedsDisplay];
        if (self.delegate && [self.delegate respondsToSelector:@selector(YYStockView: selectedModel:)]) {
            [self.delegate YYStockView:self selectedModel:selectedModel];
        }
    }
    
    if(longPress.state == UIGestureRecognizerStateEnded || longPress.state == UIGestureRecognizerStateCancelled || longPress.state == UIGestureRecognizerStateFailed)
    {
        //恢复scrollView的滑动
        selectedModel = self.drawLineModels.lastObject;
        oldPositionX = 0.f;
        [self setNeedsDisplay];
        self.maskView.hidden = YES;
        if (self.delegate && [self.delegate respondsToSelector:@selector(YYStockView: selectedModel:)]) {
            [self.delegate YYStockView:self selectedModel:nil];
        }
    }
}

- (void)event_pinchAction:(UIPinchGestureRecognizer *)pinch {
    
    //1.获取缩放倍数
    static CGFloat oldScale = 1.0f;
    CGFloat difValue = pinch.scale - oldScale;
    
    if(ABS(difValue) > YYStockLineScaleBound) {
        if( pinch.numberOfTouches == 2 ) {
            
            //2.获取捏合中心点 -> 捏合中心点距离scrollviewcontent左侧的距离
            CGPoint p1 = [pinch locationOfTouch:0 inView:self.stockScrollView];
            CGPoint p2 = [pinch locationOfTouch:1 inView:self.stockScrollView];
            CGFloat centerX = (p1.x+p2.x)/2;
            
            //3.拿到中心点数据源的index
            CGFloat oldLeftArrCount = ABS(centerX + [YYStockVariable lineGap]) / ([YYStockVariable lineGap] + [YYStockVariable lineWidth]);
            
            //4.缩放重绘
            CGFloat newLineWidth = [YYStockVariable lineWidth] * (difValue > 0 ? (1 + YYStockLineScaleFactor) : (1 - YYStockLineScaleFactor));
            [YYStockVariable setLineWith:newLineWidth];
            [self updateScrollViewContentWidth];
            
            //5.计算更新宽度后捏合中心点距离klineView左侧的距离
            CGFloat newLeftDistance = oldLeftArrCount * [YYStockVariable lineWidth] + (oldLeftArrCount - 1) * [YYStockVariable lineGap];
            
            //6.设置scrollview的contentoffset = (5) - (2);
            if ( self.lineModels.count * newLineWidth + (self.lineModels.count + 1) * [YYStockVariable lineGap] > self.stockScrollView.bounds.size.width ) {
                CGFloat newOffsetX = newLeftDistance - (centerX - self.stockScrollView.contentOffset.x);
                self.stockScrollView.contentOffset = CGPointMake(newOffsetX > 0 ? newOffsetX : 0 , self.stockScrollView.contentOffset.y);
            } else {
                self.stockScrollView.contentOffset = CGPointMake(0 , self.stockScrollView.contentOffset.y);
            }
            //更新contentsize
            [self updateScrollViewContentWidth];
            [self setNeedsDisplay];
        }
    }
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
