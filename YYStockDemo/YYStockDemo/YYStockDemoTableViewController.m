//
//  YYStockDemoTableViewController.m
//  YYStockDemo
//
//  Created by WillkYang on 16/10/17.
//  Copyright © 2016年 WillkYang. All rights reserved.
//

#import "YYStockDemoTableViewController.h"
#import "UIColor+YYStockTheme.h"
#import <Masonry/Masonry.h>
#import "YYFiveRecordModel.h"
#import "YYLineDataModel.h"
#import "YYTimeLineModel.h"
#import "YYStockVariable.h"
#import "AppServer.h"
#import "YYStock.h"

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define SCREEN_MAX_LENGTH MAX(kScreenWidth,kScreenHeight)
#define IS_IPHONE_X (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)

@interface YYStockDemoTableViewController ()<YYStockDataSource>

/**
 K线数据源
 */
@property (strong, nonatomic) NSMutableDictionary *stockDatadict;
@property (copy, nonatomic) NSArray *stockDataKeyArray;
@property (copy, nonatomic) NSArray *stockTopBarTitleArray;
@property (strong, nonatomic) YYFiveRecordModel *fiveRecordModel;

@property (strong, nonatomic) YYStock *stock;
@property (nonatomic, assign) NSString *stockId;
@property (weak, nonatomic) UIView *fullScreenView;
@property (strong, nonatomic) IBOutlet UIView *stockContainerView;

/**
 是否显示五档图
 */
@property (assign, nonatomic) BOOL isShowFiveRecord;

//全屏K线控件
@property (strong, nonatomic) IBOutlet UILabel *stockNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *stockIdLabel;
@property (strong, nonatomic) IBOutlet UILabel *stockLatestPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *stockIncreasePercentLabel;
@property (strong, nonatomic) IBOutlet UILabel *stockLatestUpdateTimeLabel;

@end

@implementation YYStockDemoTableViewController

- (instancetype)initWithStockId:(NSString *)stockId title:(NSString *)title isShowFiveRecord:(BOOL)isShowFiveRecord {
    self = [super init];
    if(self) {
        _isShowFiveRecord = isShowFiveRecord;
        _stockId = @"88888888";
        self.navigationItem.title = @"YY股(88888888)";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //测试数据
    {
        _isShowFiveRecord = YES;
        _stockId = @"88888888";
        self.navigationItem.title = @"YY股(88888888)";
    }
    
    [self initStockView];
    [self fetchData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self stock_enterFullScreen:self.stock.containerView.gestureRecognizers.firstObject];
    });
}

- (void)initStockView {
    [YYStockVariable setStockLineWidthArray:@[@6,@6,@6,@6]];
    
    YYStock *stock = [[YYStock alloc]initWithFrame:self.stockContainerView.frame dataSource:self];
    _stock = stock;
    [self.stockContainerView addSubview:stock.mainView];
    [stock.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.stockContainerView);
    }];
    //添加单击监听
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(stock_enterFullScreen:)];
    tap.numberOfTapsRequired = 1;
    [self.stock.containerView addGestureRecognizer:tap];
    [self.stock.containerView.subviews setValue:@0 forKey:@"userInteractionEnabled"];
    
}

/*******************************************股票数据源获取更新*********************************************/
/**
 网络获取K线数据
 */
- (void)fetchData {
    
    [AppServer Get:@"five" params:nil success:^(NSDictionary *response) {
        if (self.isShowFiveRecord) {
            self.fiveRecordModel = [[YYFiveRecordModel alloc]initWithDict:response[@"sshq"]];
            [self.stock draw];
        }
    } fail:^(NSDictionary *info) {
        
    }];
    
    [AppServer Get:@"day" params:nil success:^(NSDictionary *response) {
        NSMutableArray *array = [NSMutableArray array];
        __block YYLineDataModel *preModel;
        [response[@"dayhqs"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            YYLineDataModel *model = [[YYLineDataModel alloc]initWithDict:obj];
            model.preDataModel = preModel;
            [model updateMA:response[@"dayhqs"] index:idx];
            NSString *day = [NSString stringWithFormat:@"%@",obj[@"day"]];
            if ([response[@"dayhqs"] count] % 18 == ([response[@"dayhqs"] indexOfObject:obj] + 1 )%18 ) {
                model.showDay = [NSString stringWithFormat:@"%@-%@-%@",[day substringToIndex:4],[day substringWithRange:NSMakeRange(4, 2)],[day substringWithRange:NSMakeRange(6, 2)]];
            }
            [array addObject: model];
            preModel = model;
        }];
        [self.stockDatadict setObject:array forKey:@"dayhqs"];
    } fail:^(NSDictionary *info) {
        
    }];
    
    [AppServer Get:@"minute" params:nil success:^(NSDictionary *response) {
        NSMutableArray *array = [NSMutableArray array];
        [response[@"minutes"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            YYTimeLineModel *model = [[YYTimeLineModel alloc]initWithDict:obj];
            [array addObject: model];
        }];
        [self.stockDatadict setObject:array forKey:@"minutes"];
        [self.stock draw];
        
    } fail:^(NSDictionary *info) {
    }];
}


/*******************************************股票数据源代理*********************************************/
-(NSArray <NSString *> *) titleItemsOfStock:(YYStock *)stock {
    return self.stockTopBarTitleArray;
}

-(NSArray *) YYStock:(YYStock *)stock stockDatasOfIndex:(NSInteger)index {
    return index < self.stockDataKeyArray.count ? self.stockDatadict[self.stockDataKeyArray[index]] : nil;
}

-(YYStockType)stockTypeOfIndex:(NSInteger)index {
    return index == 0 ? YYStockTypeTimeLine : YYStockTypeLine;
}

- (id<YYStockFiveRecordProtocol>)fiveRecordModelOfIndex:(NSInteger)index {
    return self.fiveRecordModel;
}

- (BOOL)isShowfiveRecordModelOfIndex:(NSInteger)index {
    return self.isShowFiveRecord;
}


/*******************************************股票全屏*********************************************/
/**
 退出全屏
 */
- (IBAction)stock_exitFullScreen:(id)sender {
    
    [self.stock.containerView.subviews setValue:@0 forKeyPath:@"userInteractionEnabled"];
    
    UIView *snapView = [self.fullScreenView snapshotViewAfterScreenUpdates:NO];
    [self.fullScreenView addSubview:snapView];
    [snapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.fullScreenView);
    }];
    [self.stockContainerView addSubview:self.stock.mainView];
    [self.stock.mainView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.stockContainerView);
    }];
    [self.stock.mainView layoutSubviews];
    [YYStockVariable setStockLineWidthArray:@[@6,@6,@6,@6]];
    [self.stock draw];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.fullScreenView.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self.fullScreenView removeFromSuperview];
    }];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self.stock.containerView.gestureRecognizers.firstObject setEnabled:YES];
}

/**
 点击进入全屏
 */
- (void)stock_enterFullScreen:(UITapGestureRecognizer *)tap {
    [self.stock.containerView.subviews setValue:@1 forKeyPath:@"userInteractionEnabled"];
    tap.enabled = NO;
    
    UIView *fullScreenView = [[NSBundle mainBundle] loadNibNamed:@"YYStockFullScreenView" owner:self options:nil].firstObject;
    self.fullScreenView = fullScreenView;
    [self  updateStockFullScreenData];
    fullScreenView.backgroundColor = [UIColor YYStock_bgLineColor];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:fullScreenView];
    
    [fullScreenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(window.mas_height);
        make.height.equalTo(window.mas_width);
        make.center.equalTo(window);
    }];

    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    [fullScreenView addSubview:self.stock.mainView];
    [self.stock.mainView mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (IS_IPHONE_X) {
            make.left.bottom.equalTo(fullScreenView).offset(30);
        } else {
            make.left.bottom.equalTo(fullScreenView);
        }
        make.right.bottom.equalTo(fullScreenView);
        make.top.equalTo(fullScreenView).offset(66);
    }];
    fullScreenView.transform = CGAffineTransformMakeRotation(M_PI_2);
    [self.stock draw];
    
}

/**
 更新全屏顶部数据
 */
- (void)updateStockFullScreenData {
    self.stockNameLabel.text = @"YY股票";
    self.stockIdLabel.text = @"88888888";
    self.stockLatestPriceLabel.text = @"1234.88";
    self.stockIncreasePercentLabel.text = @"+1.33   +1.54%";
    self.stockLatestUpdateTimeLabel.text = [NSString stringWithFormat:@"更新时间：2016-10-17 22:05:05"];
    
}

/*******************************************getter*********************************************/
- (NSMutableDictionary *)stockDatadict {
    if (!_stockDatadict) {
        _stockDatadict = [NSMutableDictionary dictionary];
    }
    return _stockDatadict;
}

- (NSArray *)stockDataKeyArray {
    if (!_stockDataKeyArray) {
        _stockDataKeyArray = @[@"minutes",@"dayhqs"];
    }
    return _stockDataKeyArray;
}

- (NSArray *)stockTopBarTitleArray {
    if (!_stockTopBarTitleArray) {
        _stockTopBarTitleArray = @[@"分时",@"日K"];
//        _stockTopBarTitleArray = @[@"分时",@"日K",@"周K",@"月K"];
    }
    return _stockTopBarTitleArray;
}

- (NSString *)getToday {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMMdd";
    return [dateFormatter stringFromDate:[NSDate date]];
}

- (void)dealloc {
    NSLog(@"DEALLOC");
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
