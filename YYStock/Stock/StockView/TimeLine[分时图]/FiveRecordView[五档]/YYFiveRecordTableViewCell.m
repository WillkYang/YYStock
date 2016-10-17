//
//  YYFiveRecordTableViewCell.m
//  YYStock  ( https://github.com/yate1996 )
//
//  Created by yate1996 on 16/10/11.
//  Copyright © 2016年 yate1996. All rights reserved.
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
