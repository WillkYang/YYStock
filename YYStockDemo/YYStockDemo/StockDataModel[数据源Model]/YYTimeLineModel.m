//
//  YYTimeLineModel.m
//  投融宝
//
//  Created by WillkYang on 16/10/10.
//  Copyright © 2016年 yeeyuntech. All rights reserved.
//

#import "YYTimeLineModel.h"
#import <CoreGraphics/CoreGraphics.h>
@implementation YYTimeLineModel
{
    NSDictionary * _dict;
    NSString *Price;
    NSString *Volume;
}

- (NSString *)TimeDesc {
    NSLog(@"%@",_dict[@"minute"]);
    if( [_dict[@"minute"] integerValue] == 780) {
        return @"11:30/13:00";
    } else if( [_dict[@"minute"] integerValue] == 1020) {
        return @"15:00";
    } else {
        return [NSString stringWithFormat:@"%02ld:%02ld",[_dict[@"minute"] integerValue]/60,[_dict[@"minute"] integerValue]%60];
    }
}

- (NSString *)DayDatail {
    return [NSString stringWithFormat:@"%02ld:%02ld",[_dict[@"minute"] integerValue]/60,[_dict[@"minute"] integerValue]%60];
}

//前一天的收盘价
- (CGFloat )AvgPrice {
    return [_dict[@"avgPrice"] floatValue];
}

- (NSNumber *)Price {
    return _dict[@"price"];
}

- (CGFloat)Volume {
    return [_dict[@"volume"] floatValue]/100.f;
}

- (BOOL)isShowTimeDesc {
    //9:30-11:30,13:00-15:00
    //11:30和13:00挨在一起，显示一个就够了
    //最后一个服务器返回的minute不是960,故只能特殊处理
    return [_dict[@"minute"] integerValue] == 570 ||  [_dict[@"minute"] integerValue] == 780 ||  [_dict[@"index"] integerValue] == 240;
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _dict = dict;
        Price = _dict[@"price"];
        Volume = _dict[@"volume"];
    }
    return self;
}

@end
