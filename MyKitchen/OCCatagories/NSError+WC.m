//
//  NSError+WC.m
//  MyKitchen
//
//  Created by Mac on 15/11/16.
//  Copyright © 2015年 WoChu. All rights reserved.
//

#import "NSError+WC.h"

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
