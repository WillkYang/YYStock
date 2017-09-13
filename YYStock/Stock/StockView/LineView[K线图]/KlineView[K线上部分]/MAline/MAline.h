//
//  MAline.h
//  YYStock  ( https://github.com/WillkYang )
//
//  Created by WillkYang on 16/10/8.
//  Copyright © 2016年 WillkYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MAline : UIView


- (instancetype)initWithContext:(CGContextRef)context;

- (void)drawWithColor:(UIColor *)lineColor maPositions:(NSArray *)maPositions;

@end
