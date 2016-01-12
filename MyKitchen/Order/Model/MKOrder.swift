//
//  MKOrder.swift
//  MyKitchen
//
//  Created by wochu on 16/1/11.
//  Copyright © 2016年 @Wochu. All rights reserved.
//

import UIKit

class MKOrder: MKBaseOrder {
    var memberId : Int64 = 0
    var member : String = ""
    var exceptionStatus = ""
    var consignee = ""
    var mobile = ""
    var phone = ""
    var region = ""
    var address = ""
    var siteSN : Int64 = 0
    var deliveryTimeBegin : NSTimeInterval?
    var deliveryTimeEnd : NSTimeInterval?
    var postScript = ""
    var messageToBuyer = ""
    var howOos = ""
    var howSurplus = ""
    var packName = ""
    var invPayee = ""
    var invType : NSInteger = 0
    var invContent = ""
    var tax : CGFloat = 0.0
    var discount : CGFloat = 0.0
    var insureFee : CGFloat = 0.0
    var payFee : CGFloat = 0.0
    var packFee : CGFloat = 0.0
    var surplus : CGFloat = 0.0
    var integral : CGFloat = 0.0
    var integralMoney : CGFloat = 0.0
    var voucher : CGFloat = 0.0
    var goodsAmount : CGFloat = 0.0
    var createTime : NSTimeInterval?
    var confirmTime : NSTimeInterval?
    var payTime : NSTimeInterval?
    var shippingTime : NSTimeInterval?
    var receiveTime : NSTimeInterval?
    var closeTime : NSTimeInterval?
    var packId : NSInteger = 0
    var voucherIds = ""
    var invoiceNo = ""
    var extensionCode = ""
    var voucherCodeMoney : CGFloat = 0.0
    var voucherMoney : CGFloat = 0.0
    var orderPromotion : [AnyObject] = []
    var isChangeShippingTime : NSInteger = 0
    var changeShippingTimeStatus : MKChangeShippingTimeStatus?
    var changeShippingTime = MKOrderChangeDeliver()
    
    required init(id: Int64) {
        super.init(id: id)
    }
    
    convenience init(ID : Int64,orderType :  MKOrderType,consignee : String, deliveryTimeBegin : NSTimeInterval,deliveryTimeEnd : NSTimeInterval,payType : MKPayType,goodsAmount : CGFloat,moneyPaid : CGFloat,orderAmount : CGFloat,needToPay : CGFloat,oderGoodes : Array<AnyObject>?){
        self.init(id : ID)
        
        self.orderType = orderType
        self.consignee = consignee
        self.deliveryTimeBegin = deliveryTimeBegin
        self.deliveryTimeEnd = deliveryTimeEnd
        self.payId = payType
        
        
    }
    
    override class func objectClassInArray() -> Dictionary<String,AnyObject> {
        return ["orderDtail" : MKOrderGoods.self,"orderPromotion" : MKOrderPromotion.self]
    }
    
    class func replacedKeyFromPropertyName() ->[String : AnyObject] {
        return ["ID" : "id","changeShipingTime" : "newShippingTime"]
    }
}
















