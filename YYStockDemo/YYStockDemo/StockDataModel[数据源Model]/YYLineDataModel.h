//
//  YYLineDataModel.h
//  投融宝
//
//  Created by yate1996 on 16/10/5.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "YYStockDataProtocol.h"

/**
 外部实现
 */
@interface YYLineDataModel : NSObject <YYLineDataModelProtocol>

- (void)updateMA:(NSArray *)parentDictArray;

@end
