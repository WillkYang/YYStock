//
//  YYFiveRecordView.h
//  YYStock  ( https://github.com/WillkYang )
//
//  Created by WillkYang on 16/10/10.
//  Copyright © 2016年 WillkYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYStockFiveRecordProtocol.h"
@interface YYFiveRecordView : UITableView <UITableViewDataSource>
@property (nonatomic, strong) id<YYStockFiveRecordProtocol> fiveRecordModel;
- (void)reDrawWithFiveRecordModel:(id<YYStockFiveRecordProtocol>)fiveRecordModel;
@end
