//
//  MKEnum.swift
//  MyKitchen
//
//  Created by wochu on 15/12/18.
//  Copyright © 2015年 @Wochu. All rights reserved.
//

import Foundation
import UIKit

//订单状态
//4：订单待确认
//5：订单已取消
//6：订单已无效
//7：退货订单
//8：退款订单
//9：订单已评价
public enum MKOrderStatus : NSInteger{
    case MKOrderStatusUnknown = -1
    case MKOrderStatusAllOrder = 0 //全部订单
    case MKOrderStatusUnPaid = 1//待付款
    case MKOrderStatusUnreceipt = 2//待收货
    case MKOrderStatusUnAppraise = 3 //待评价
    case MKOrderStatusUnConfirm = 4 //货到付款  订单待确认
    case MKOrderStatusDidCancel = 5 //订单已取消
    case MKOrderStatusInvalid = 6 //订单已无效
    case MKOrderStatusRestore = 7 //退货 （进行中）
    case MKOrderStatusQuitMoney = 8 //退款 （已完成）
    case MKOrderStatusDidAppraise = 9 //已评价
    case MKOrderStatusRestoreTimeOut = 10 //待评价(退货超时)
    case MKOrderStatusUndeliver = 11 //待发货
    case MKOrderStatusPayOnDeliverUnReceipt = 12 // 待收货 货到付款
}

public enum MKOrderActionType : NSInteger{
    case MKOrderActionTypeCancel = 101
    case MKOrderActionTypePaid //付款
    case MKOrderActionTypeReceipt//确认收货
    case MKOrderActionTypeLogistics//查看物流
    case MKOrderActionTypeAppraise//评价
    case MKOrderActionTypeRestore//售后
    case MKOrderActionTypeRestoreProgress//售后进度
    case MKOrderActionTypeUnknow
}

public enum MKErrorCode : Int{
    case RemindErrorCode = -10000 // 提醒错误
    case ServiceErrorCode = -10001 // 服务器错误
    case LocalErrorCode = -10002 // 本地错误
    case NetworkErrorCode = -10003 // 网络错误
    case CrashErrorCode = -10004 // 崩溃错误
}

public func MAX(A : float_t , B : float_t) -> Bool{
    return A>B
}

func RGB(R : CGFloat ,G : CGFloat ,B : CGFloat ,alpha : CGFloat  ) ->UIColor{
    return UIColor(red: R/255.0, green: G/255.0, blue: B/255.0, alpha: alpha)
}


