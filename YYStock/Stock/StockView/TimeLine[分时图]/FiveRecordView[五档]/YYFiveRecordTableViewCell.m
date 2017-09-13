//
//  YYFiveRecordTableViewCell.m
//  YYStock  ( https://github.com/WillkYang )
//
//  Created by WillkYang on 16/10/11.
//  Copyright © 2016年 WillkYang. All rights reserved.
//

#import "YYFiveRecordTableViewCell.h"

@implementation YYFiveRecordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.label1.adjustsFontSizeToFitWidth = YES;
    self.label2.adjustsFontSizeToFitWidth = YES;
    self.label3.adjustsFontSizeToFitWidth = YES;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
