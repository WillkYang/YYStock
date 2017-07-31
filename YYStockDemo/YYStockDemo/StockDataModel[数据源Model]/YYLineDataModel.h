//
//  YYLineDataModel.h
//  投融宝
//
//  Created by yate1996 on 16/10/5.
//  Copyright © 2016年 yeeyuntech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "YYStockDataProtocol.h"

/**
 外部实现
 */
@interface YYLineDataModel : NSObject <YYLineDataModelProtocol>

- (void)updateMA:(NSArray *)parentDictArray index:(NSInteger)index;


//@property (nonatomic, assign) BOOL isShowDay;
@property (nonatomic, strong) id<YYLineDataModelProtocol> preDataModel;
@property (nonatomic, strong) NSString *showDay;
@end
