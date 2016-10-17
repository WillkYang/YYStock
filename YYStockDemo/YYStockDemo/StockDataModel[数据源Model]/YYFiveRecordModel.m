//
//  YYFiveRecordModel.m
//  投融宝
//
//  Created by yate1996 on 16/10/10.
//  Copyright © 2016年 yate1996. All rights reserved.
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
        
        NSMutableArray *arr1 = [NSMutableArray array];
        
        [arr1 addObject:[NSString stringWithFormat:@"%.0f",[dict[@"sjw1"] floatValue]]];
        [arr1 addObject:[NSString stringWithFormat:@"%.0f",[dict[@"sjw2"] floatValue]]];
        [arr1 addObject:[NSString stringWithFormat:@"%.0f",[dict[@"sjw3"] floatValue]]];
        [arr1 addObject:[NSString stringWithFormat:@"%.0f",[dict[@"sjw4"] floatValue]]];
        [arr1 addObject:[NSString stringWithFormat:@"%.0f",[dict[@"sjw5"] floatValue]]];
        sellPriceArray = arr1.copy;
        
        NSMutableArray *arr2 = [NSMutableArray array];
        [arr2 addObject:[dict[@"bjw1"] stringValue]];
        [arr2 addObject:[dict[@"bjw2"] stringValue]];
        [arr2 addObject:[dict[@"bjw3"] stringValue]];
        [arr2 addObject:[dict[@"bjw4"] stringValue]];
        [arr2 addObject:[dict[@"bjw5"] stringValue]];
        buyPriceArray = arr2.copy;
        
        NSMutableArray *arr3 = [NSMutableArray array];
        [arr3 addObject:[dict[@"ssl1"] stringValue]];
        [arr3 addObject:[dict[@"ssl2"] stringValue]];
        [arr3 addObject:[dict[@"ssl3"] stringValue]];
        [arr3 addObject:[dict[@"ssl4"] stringValue]];
        [arr3 addObject:[dict[@"ssl5"] stringValue]];
        sellVolumeArray = arr3.copy;

        
        NSMutableArray *arr4 = [NSMutableArray array];
        [arr4 addObject:[dict[@"bsl1"] stringValue]];
        [arr4 addObject:[dict[@"bsl2"] stringValue]];
        [arr4 addObject:[dict[@"bsl3"] stringValue]];
        [arr4 addObject:[dict[@"bsl4"] stringValue]];
        [arr4 addObject:[dict[@"bsl5"] stringValue]];
        buyVolumeArray = arr4.copy;


    }
    return self;
}
@end
