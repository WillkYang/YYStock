//
//  YYTimeLineVolumeView.h
//  YYStock  ( https://github.com/WillkYang )
//
//  Created by WillkYang on 16/10/10.
//  Copyright © 2016年 WillkYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYStockTimeLineProtocol.h"
#import "YYVolumePositionModel.h"
@interface YYTimeLineVolumeView : UIView

- (void)drawViewWithXPosition:(CGFloat)xPosition drawModels:(NSArray <id<YYStockTimeLineProtocol>>*)drawLineModels;

@end
