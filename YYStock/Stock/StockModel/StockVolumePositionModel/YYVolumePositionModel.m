//
//  YYVolumePositionModel.m
//  YYStock  ( https://github.com/yate1996 )
//
//  Created by yate1996 on 16/10/5.
//  Copyright © 2016年 yate1996. All rights reserved.
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
