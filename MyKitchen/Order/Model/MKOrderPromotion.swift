//
//  MKOrderPromotion.swift
//  MyKitchen
//
//  Created by wochu on 16/1/11.
//  Copyright © 2016年 @Wochu. All rights reserved.
//

import UIKit

class MKOrderPromotion: MKBaseModel {
    var promotionType : NSInteger = 0//促销类型
    var promotionId : NSInteger = 0//促销ID
    var promotionDesc = ""//促销详细描述
    var goodsGuids : AnyObject?//关联商品IDs
}

class MKOrderStatusModel : MKBaseModel {
    var orderActionId : AnyObject?
    var orderActionName = ""
}

class MKPaymentData : MKBaseModel {
    var payType : MKPayType?
    var amount : CGFloat = 0.0
    var payName = ""
}