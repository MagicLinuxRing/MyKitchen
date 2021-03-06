//
//  NSError+WC.m
//  MyKitchen
//
//  Created by Mac on 15/11/16.
//  Copyright © 2015年 WoChu. All rights reserved.
//

#import "NSError+WC.h"

typedef NS_ENUM(NSInteger, WCErrorCode) {
    WCRemindErrorCode = -10000, // 提醒错误
    WCServiceErrorCode = -10001, // 服务器错误
    WCLocalErrorCode = -10002, // 本地错误
    WCNetworkErrorCode = -10003, // 网络错误
    WCCrashErrorCode = -10004 // 崩溃错误
};

@implementation NSError (WC)

- (NSString *)errorDescription {
    NSString *__description = nil;
    switch (self.code) {
        case WCRemindErrorCode:
            __description = self.localizedDescription;
            break;
        case WCServiceErrorCode:
//            __description = @"服务器错误";
//            break;
        case WCLocalErrorCode:
            __description = @"亲，数据出错啦！";
            break;
        case WCNetworkErrorCode:
            __description = @"亲，网络不给力！";
            break;
        case WCCrashErrorCode:
            __description = @"亲，挂掉了哦！";
            break;
        default:
            __description = @"亲，网络不给力！";
            break;
    }
    return __description;
}

@end
