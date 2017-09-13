//
//  YYVolumePositionModel.m
//  YYStock  ( https://github.com/WillkYang )
//
//  Created by WillkYang on 16/10/5.
//  Copyright © 2016年 WillkYang. All rights reserved.
//

#import "YYVolumePositionModel.h"

@implementation YYVolumePositionModel
+ (instancetype) modelWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint dayDesc:(NSString *)dayDesc;
{
    YYVolumePositionModel *volumePositionModel = [YYVolumePositionModel new];
    volumePositionModel.StartPoint = startPoint;
    volumePositionModel.EndPoint = endPoint;
    volumePositionModel.DayDesc = dayDesc;
    return volumePositionModel;
}
@end
