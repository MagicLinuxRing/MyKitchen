//
//  MKBaseOrder.swift
//  MyKitchen
//
//  Created by wochu on 16/1/8.
//  Copyright © 2016年 @Wochu. All rights reserved.
//

import UIKit

public enum MKRestoreOrderStatus : NSInteger{
    case UnApproved = 0 //审核不通过
    case InApproving
    case Approved
}

public enum MKShippingStatus : NSInteger{
    case UnderLiver = 0//未发货
    case DidDeliver// 已发货
    case Receipt//收货确认
    case ConfigGoods//配货中
    case DeliverPartsGoods//已发货（部分商品）
    case Delivering//发货中
}

public enum MKPayType : NSInteger{
    case CashOnDelivery = 3//货到付款
    case AliPay//支付宝
    case WeiXinPay//微信
    case JianHang//建行支付
    case Online//在线付款
    case Integral//积分
}

public enum MKPayStatus : NSInteger{
    case Unknown = -1
    case UnPay = 0//未付款
    case Paying//支付中
    case DidPay//已支付
    case Restoring//退款中
    case DidRestore //已退款
}

public enum MKCancelOrderStatus : NSInteger{
    case Approving = 0//审核中
    case Approved//审核通过
    case UnApproved//审核不过
}

public enum MKOrderType : NSInteger{
    case Normal = 0//普通订单
    case Presell//预售订单
    case Rally//团购订单
    case Recharge//网上充值订单
}

public enum MKChangeShippingTimeStatus : NSInteger{
    case Approving = 0//审核中
    case Approved//审核通过
    case UnApproved//审核不通过
}


class MKBaseOrder: MKBaseModel {

    var orderId : Int64? //订单ID
    var orderSn = ""//订单号
    var status : MKOrderStatus?//订单状态，用于订单列表
    var orderStatus : MKOrderStatus?//未用到
    var canRestoreOrder : NSInteger?//是否可以整单退款
    var restoreOrderStatus : MKRestoreOrderStatus?// 整单退货生贺状态
    var orderAmount : CGFloat = 0.0//订单总金额
    var needToPay : CGFloat = 0.0//需要支付的金额
    var moneyPaid : CGFloat = 0.0//实付金额
    var orderDetail : [MKOrderGoods] = []//订单商品信息
    var shippingFee : CGFloat = 0.0//运费
    var shippingStatus :MKShippingStatus?//发货状态
    var shippingId : NSInteger = 0//配送方式
    var shippingName : String?//配送方式名称
    private var _payId : MKPayType = .AliPay
    internal var payId : MKPayType{
        get {return _payId}
        set {
            _payId = newValue
            switch newValue{
                case .AliPay:
                    self.payName = "支付宝"
                    break
                case .WeiXinPay:
                    self.payName = "微信支付"
                break
                case .JianHang:
                    self.payName = "建行支付"
                break
                case .CashOnDelivery:
                    self.payName = "货到付款"
                break
                default:
                    break
            }
        }
    }//支付方式
    var payName : String = ""//支付方式名称
    var payStatus : MKPayStatus?//付款状态
    var payNote : String = ""//支付备注
    var isCancel : Bool = false
    var cancelId : String = ""
    var cancelOrderStatus : MKCancelOrderStatus?//取消订单状态
    var orderType : MKOrderType?//订单类型
    
    var availableStatus : [AnyObject] = []
    
    required init(id: Int64) {
        super.init(id: id)
    }
    
    convenience init(ID : Int64, orderNumber : String,orderStatus : MKOrderStatus,goodsed : Array<AnyObject>?,freightCost : CGFloat ,totalCost : CGFloat){
        self.init(id : ID)
    }
    
    func updateGoodsOrderSn(){
        if self.orderSn.length == 0{
            return
        }
        for goods in self.orderDetail {
            goods.orderSn = self.orderSn
        }
    }
    
    class func objectClassInArray() ->Dictionary<String,AnyObject> {
        return ["orderDetail" : MKOrderGoods.self,"availableStatus":MKOrderStatusModel.self]
    }
}




















