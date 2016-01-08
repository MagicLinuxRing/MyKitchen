//
//  MKBaseGoods.swift
//  MyKitchen
//
//  Created by wochu on 16/1/8.
//  Copyright © 2016年 @Wochu. All rights reserved.
//

import UIKit

class MKBaseGoods: MKBaseModel {
    var guid : String = ""
    var goodsGuid : String = ""
    var sn : String = ""
    var goodsSn = ""
    var name = ""
    var goodsName = ""
    var alias = ""
    var title = ""
    var goodsTitle = ""
    var icon = ""
    var picUrl = ""
    var isCheck = false
    var action : Dictionary<String,AnyObject>?
    var realPrice : CGFloat = 0.0
    var price : CGFloat = 0.0
    var marketPrice : CGFloat = 0.0
    var originalPrice : CGFloat = 0.0
    var amount : CGFloat = 0.0
    var promotedAmount : String = ""
    
    var goodsStock : NSInteger = 0
    var weight : NSInteger = 0
    var cnt : NSInteger = 0
    var soecformat : String = ""
    var status : NSInteger = 0
    var Virtual : Bool =  false
    var salableStock : Bool = false
    var googdsAttributeImg : Array<AnyObject>?
    
    
    required init(id: Int64) {
        super.init(id: id)
    }
    
    convenience init(id : Int64,_ _goodGuid : String,_ _goodsName : String,_ _price : CGFloat,_ _cnt : NSInteger ) {
        self.init(id : id)
        self.goodsGuid = _goodGuid
        self.goodsName = _goodsName
        self.price = _price
        self.cnt = _cnt
    }
}









