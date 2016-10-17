//
//  YYLineDataModel.m
//  投融宝
//
//  Created by yate1996 on 16/10/5.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "YYLineDataModel.h"
@interface YYLineDataModel()

/**
 持有字典数组，用来计算ma值
 */
@property (nonatomic, strong) NSArray *parentDictArray;
@end
@implementation YYLineDataModel
{
    NSDictionary * _dict;
    NSString *Close;
    NSString *Open;
    NSString *Low;
    NSString *High;
    NSString *Volume;
    NSNumber *MA5;
    NSNumber *MA10;
    NSNumber *MA20;
    
}

- (NSString *)Day {
    NSString *day = [_dict[@"day"] stringValue];
    return [NSString stringWithFormat:@"%@-%@",[day substringToIndex:4],[day substringWithRange:NSMakeRange(4, 2)]];
}

- (NSString *)DayDatail {
    NSString *day = [_dict[@"day"] stringValue];
    return [NSString stringWithFormat:@"%@-%@-%@",[day substringToIndex:4],[day substringWithRange:NSMakeRange(4, 2)],[day substringWithRange:NSMakeRange(6, 2)]];
}

- (NSNumber *)Open {
//    NSLog(@"%i",[[_dict[@"day"] stringValue] hasSuffix:@"01"]);
    return _dict[@"open"];
}

- (NSNumber *)Close {
    return _dict[@"close"];
}

- (NSNumber *)High {
    return _dict[@"high"];
}

- (NSNumber *)Low {
    return _dict[@"low"];
}

- (CGFloat)Volume {
    return [_dict[@"volume"] floatValue];
}

- (BOOL)isShowDay {
    return [[_dict[@"day"] stringValue] hasSuffix:@"01"];
}

- (NSNumber *)MA5 {
    return MA5;
}

- (NSNumber *)MA10 {
    return MA10;
}

- (NSNumber *)MA20 {
    return MA20;
}
- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {        
        _dict = dict;
        Close = _dict[@"close"];
        Open = _dict[@"open"];
        High = _dict[@"high"];
        Low = _dict[@"low"];
        Volume = _dict[@"volume"];
    }
    return self;
}

- (void)updateMA:(NSArray *)parentDictArray {
    _parentDictArray = parentDictArray;
    NSInteger index = [_parentDictArray indexOfObject:_dict];
    if (index >= 4) {
        NSArray *array = [_parentDictArray subarrayWithRange:NSMakeRange(index-4, 5)];
        CGFloat average = [[[array valueForKeyPath:@"close"] valueForKeyPath:@"@avg.floatValue"] floatValue];
        MA5 = @(average);
    }
    
    if (index >= 9) {
        NSArray *array = [_parentDictArray subarrayWithRange:NSMakeRange(index-9, 10)];
        CGFloat average = [[[array valueForKeyPath:@"close"] valueForKeyPath:@"@avg.floatValue"] floatValue];
        MA10 = @(average);
    }
    
    if (index >= 19) {
        NSArray *array = [_parentDictArray subarrayWithRange:NSMakeRange(index-19, 20)];
        CGFloat average = [[[array valueForKeyPath:@"close"] valueForKeyPath:@"@avg.floatValue"] floatValue];
        MA20 = @(average);
    }
    
}

@end
