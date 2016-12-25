//
//  YYFiveRecordModel.m
//  投融宝
//
//  Created by yate1996 on 16/10/10.
//  Copyright © 2016年 yeeyuntech. All rights reserved.
//

#import "YYFiveRecordModel.h"

@implementation YYFiveRecordModel
{
    NSDictionary * _dict;
    NSArray *buyPriceArray;
    NSArray *sellPriceArray;
    NSArray *buyVolumeArray;
    NSArray *sellVolumeArray;

}
- (NSArray *)BuyPriceArray {
    return buyPriceArray;
}

- (NSArray *)SellPriceArray {
    return sellPriceArray;
}

- (NSArray *)BuyVolumeArray {
    return buyVolumeArray;
}

- (NSArray *)SellVolumeArray {
    return sellVolumeArray;
}

- (NSArray *)BuyDescArray {
    return @[@"买1",@"买2",@"买3",@"买4",@"买5"];
}

- (NSArray *)SellDescArray {
    return @[@"卖5",@"卖4",@"卖3",@"卖2",@"卖1"];
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _dict = dict;
        
        sellPriceArray = @[
                                [self formatFiveRecordTo2Decimal:dict[@"sjw5"]],
                                [self formatFiveRecordTo2Decimal:dict[@"sjw4"]],
                                [self formatFiveRecordTo2Decimal:dict[@"sjw3"]],
                                [self formatFiveRecordTo2Decimal:dict[@"sjw2"]],
                                [self formatFiveRecordTo2Decimal:dict[@"sjw1"]],
                                ];
        
        buyPriceArray = @[
                           [self formatFiveRecordTo2Decimal:dict[@"bjw1"]],
                           [self formatFiveRecordTo2Decimal:dict[@"bjw2"]],
                           [self formatFiveRecordTo2Decimal:dict[@"bjw3"]],
                           [self formatFiveRecordTo2Decimal:dict[@"bjw4"]],
                           [self formatFiveRecordTo2Decimal:dict[@"bjw5"]],
                           ];
        
        sellVolumeArray = @[
                          [self formatFiveRecordTo0Decimal:dict[@"ssl5"]],
                          [self formatFiveRecordTo0Decimal:dict[@"ssl4"]],
                          [self formatFiveRecordTo0Decimal:dict[@"ssl3"]],
                          [self formatFiveRecordTo0Decimal:dict[@"ssl2"]],
                          [self formatFiveRecordTo0Decimal:dict[@"ssl1"]],
                          ];
        
        buyVolumeArray = @[
                            [self formatFiveRecordTo0Decimal:dict[@"bsl1"]],
                            [self formatFiveRecordTo0Decimal:dict[@"bsl2"]],
                            [self formatFiveRecordTo0Decimal:dict[@"bsl3"]],
                            [self formatFiveRecordTo0Decimal:dict[@"bsl4"]],
                            [self formatFiveRecordTo0Decimal:dict[@"bsl5"]],
                            ];
    }
    return self;
}


- (NSString *)formatFiveRecordTo2Decimal:(NSString *)data {
    return [data floatValue] > 0 ? [NSString stringWithFormat:@"%.2f", [data floatValue]] : @"--";
}

- (NSString *)formatFiveRecordTo0Decimal:(NSString *)data {
    return [data floatValue] > 0 ? [NSString stringWithFormat:@"%.0f", [data floatValue]/100.f] : @"--";
}
@end
