//
//  AppServer.h
//  YYStockDemo
//
//  Created by WillkYang on 16/10/17.
//  Copyright © 2016年 WillkYang. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface AppServer : NSObject
/**
 Get请求调用
 @param url     url
 @param params  请求参数
 @param success 成功回调
 @param fail    失败回调
 */
+ (void)Get:(NSString*) url params:(id)params success:(void (^)(NSDictionary *response))success fail:(void(^)(NSDictionary *info))fail;

@end
