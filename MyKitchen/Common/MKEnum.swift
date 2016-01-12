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
    case Unknown = -1
    case AllOrder = 0 //全部订单
    case UnPaid = 1//待付款
    case Unreceipt = 2//待收货
    case UnAppraise = 3 //待评价
    case UnConfirm = 4 //货到付款  订单待确认
    case DidCancel = 5 //订单已取消
    case Invalid = 6 //订单已无效
    case Restore = 7 //退货 （进行中）
    case QuitMoney = 8 //退款 （已完成）
    case DidAppraise = 9 //已评价
    case RestoreTimeOut = 10 //待评价(退货超时)
    case Undeliver = 11 //待发货
    case PayOnDeliverUnReceipt = 12 // 待收货 货到付款
}

public enum MKOrderActionType : NSInteger{
    case Cancel = 101
    case Paid //付款
    case Receipt//确认收货
    case Logistics//查看物流
    case Appraise//评价
    case Restore//售后
    case RestoreProgress//售后进度
    case Unknow
}

public enum MKOrderCheckOutType : NSInteger{
    case Normal = 0//默认
    case Integral //积分
    case Coupon //优惠券
    case CouponCode //优惠码
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


