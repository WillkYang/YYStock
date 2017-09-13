//
//  YYStock.m
//  YYStock  ( https://github.com/WillkYang )
//
//  Created by WillkYang on 16/10/5.
//  Copyright © 2016年 WillkYang. All rights reserved.
//

#import "YYStock.h"
#import "YYTopBarView.h"
#import "YYStockConstant.h"
#import "YYStockView_Kline.h"
#import "YYStockView_TimeLine.h"
#import "UIColor+YYStockTheme.h"
#import "YYStockViewMaskView.h"
#import "YYStockVariable.h"
#import <Masonry/Masonry.h>
@interface YYStock()<YYTopBarViewDelegate, YYStockViewLongPressProtocol, YYStockViewTimeLinePressProtocol>
/**
 *  数据源
 */
@property (nonatomic, weak) id<YYStockDataSource> dataSource;

/**
 顶部TopBarView
 */
@property (nonatomic, strong) YYTopBarView *topBarView;

/**
 长按时出现的遮罩View
 */
@property (nonatomic, strong) YYStockViewMaskView *maskView;

@property (nonatomic, strong) NSMutableArray <__kindof UIView *>*stockViewArray;

@end

@implementation YYStock

- (instancetype)initWithFrame:(CGRect)frame dataSource:(id)dataSource {
    self = [super init];
    if (self) {
        self.dataSource = dataSource;
        self.mainView = [[UIView alloc] initWithFrame:frame];
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self initUI_TopBarView];
    [self initUI_StockContainerView];
}

- (void)initUI_TopBarView {
    _topBarView = [[YYTopBarView alloc]initWithItems:[self.dataSource titleItemsOfStock:self] distributionStyle:YYTopBarDistributionStyleInScreen];
    [self.mainView addSubview:_topBarView];
    [_topBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.mainView);
        make.height.equalTo(@YYStockTopBarViewHeight);
    }];
    _topBarView.delegate = self;
}

- (void)initUI_StockContainerView {
    self.stockViewArray = [NSMutableArray array];
    self.containerView = ({
        UIView *view = [UIView new];
        [self.mainView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self.mainView);
            make.top.equalTo(self.topBarView.mas_bottom).offset(YYStockViewGap);
        }];
        view;
    });
    for (int i = 0; i < [[self.dataSource titleItemsOfStock:self] count]; i++) {
        UIView *stockView;
        if ([self.dataSource stockTypeOfIndex:i] == YYStockTypeTimeLine) {
            //判断是否加载五档图
            if ([self.dataSource respondsToSelector:@selector(isShowfiveRecordModelOfIndex:)]) {
                stockView =  [[YYStockView_TimeLine alloc]initWithTimeLineModels:[self.dataSource YYStock:self stockDatasOfIndex:i] isShowFiveRecord:  [self.dataSource isShowfiveRecordModelOfIndex:self.currentIndex] fiveRecordModel:[self.dataSource fiveRecordModelOfIndex:i]];
            } else {
                stockView =  [[YYStockView_TimeLine alloc]initWithTimeLineModels:[self.dataSource YYStock:self stockDatasOfIndex:i] isShowFiveRecord: NO fiveRecordModel:[self.dataSource fiveRecordModelOfIndex:i]];
            }
            ((YYStockView_TimeLine *)stockView).delegate = self;
        } else {
            stockView =  [[YYStockView_Kline alloc]initWithLineModels:[self.dataSource YYStock:self stockDatasOfIndex:i]];
            ((YYStockView_Kline *)stockView).delegate = self;
            stockView.hidden = YES;
        }
        stockView.backgroundColor = [UIColor YYStock_bgColor];
        [self.containerView addSubview:stockView];
        [stockView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.containerView);
        }];
        [self.stockViewArray addObject:stockView];
    }
}

/**
 绘制
 */
- (void)draw {
    //更新数据
    NSInteger index = self.currentIndex;
    if ([self.stockViewArray[index] isKindOfClass:[YYStockView_Kline class]]) {
        YYStockView_Kline *stockView = (YYStockView_Kline *)(self.stockViewArray[index]);
        
        [stockView reDrawWithLineModels:[self.dataSource YYStock:self stockDatasOfIndex:index]];
    }
    if ([self.stockViewArray[index] isKindOfClass:[YYStockView_TimeLine class]]) {
        YYStockView_TimeLine *stockView = (YYStockView_TimeLine *)(self.stockViewArray[index]);
        if ([self.dataSource respondsToSelector:@selector(isShowfiveRecordModelOfIndex:)]) {
            [stockView reDrawWithTimeLineModels:[self.dataSource YYStock:self stockDatasOfIndex:index] isShowFiveRecord:[self.dataSource isShowfiveRecordModelOfIndex:0] fiveRecordModel:[self.dataSource fiveRecordModelOfIndex:index]];
        } else {
            [stockView reDrawWithTimeLineModels:[self.dataSource YYStock:self stockDatasOfIndex:index] isShowFiveRecord:NO fiveRecordModel:nil];
        }
    }
}

/**
 topBarView代理
 
 @param topBarView topBarView
 @param index      选中index
 */
- (void)YYTopBarView:(YYTopBarView *)topBarView didSelectedIndex:(NSInteger)index {
    self.stockViewArray[self.currentIndex].hidden = YES;
    self.stockViewArray[index].hidden = NO;
    self.currentIndex = index;
    [self draw];
}


/**
 StockView_Kline代理
 此处Kline和TimeLine都走这一个代理
 @param stockView YYStockView_Kline
 @param model     选中的数据源 若为nil表示取消绘制
 */
- (void)YYStockView:(YYStockView_Kline *)stockView selectedModel:(id<YYLineDataModelProtocol>)model {
    if (model == nil) {
        self.maskView.hidden = YES;
    } else {
        if (!self.maskView) {
            _maskView = [YYStockViewMaskView new];
            _maskView.backgroundColor = [UIColor clearColor];
            [self.mainView addSubview:_maskView];
            [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.topBarView);
            }];
        } else {
            self.maskView.hidden = NO;
        }
        if ([stockView isKindOfClass:[YYStockView_Kline class]]) {
            self.maskView.stockType = YYStockTypeLine;
        } else {
            self.maskView.stockType = YYStockTypeTimeLine;
        }
        self.maskView.selectedModel = model;
        [self.maskView setNeedsDisplay];
    }
}

@end
