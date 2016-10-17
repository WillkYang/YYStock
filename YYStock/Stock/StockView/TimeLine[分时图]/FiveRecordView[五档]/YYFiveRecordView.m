//
//  YYFiveRecordView.m
//  YYStock  ( https://github.com/yate1996 )
//
//  Created by yate1996 on 16/10/10.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "YYFiveRecordView.h"
#import "YYFiveRecordTableViewCell.h"
#define YYFiveRecordTableViewCellIdentifier @"YYFiveRecordTableViewCell"
@interface YYFiveRecordView()

@end
@implementation YYFiveRecordView

- (void)reDrawWithFiveRecordModel:(id<YYStockFiveRecordProtocol>)fiveRecordModel {
    _fiveRecordModel = fiveRecordModel;
    [self reloadData];
}


-(instancetype)init {
    self = [super init];
    if (self) {
        self.rowHeight = 17;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.bounces = NO;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_fiveRecordModel) {
        return 2;
    } else {
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![self dequeueReusableCellWithIdentifier:YYFiveRecordTableViewCellIdentifier]) {
        [self registerNib:[UINib nibWithNibName:YYFiveRecordTableViewCellIdentifier bundle:nil] forCellReuseIdentifier:YYFiveRecordTableViewCellIdentifier];
    }
    YYFiveRecordTableViewCell *cell = [self dequeueReusableCellWithIdentifier:YYFiveRecordTableViewCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        cell.label1.text = [self.fiveRecordModel SellDescArray][indexPath.row];
        cell.label2.text = [self.fiveRecordModel SellPriceArray][indexPath.row];
        cell.label3.text = [self.fiveRecordModel SellVolumeArray][indexPath.row];
    } else {
        cell.label1.text = [self.fiveRecordModel BuyDescArray][indexPath.row];
        cell.label2.text = [self.fiveRecordModel BuyPriceArray][indexPath.row];
        cell.label3.text = [self.fiveRecordModel BuyVolumeArray][indexPath.row];
    }
    return cell;
}

@end
