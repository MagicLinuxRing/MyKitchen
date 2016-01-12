//
//  MKRestoreGoods.swift
//  MyKitchen
//
//  Created by wochu on 16/1/11.
//  Copyright © 2016年 @Wochu. All rights reserved.
//

import UIKit

public enum MKResotreGoodsStatusType : NSInteger{
    case Default = -1//不显示
    case RestoreBad = 0//审核未通过
    case Restoring = 1//审核中
    case RestoreSuccess = 2//退款成功
    case AskRestore = 3//申请退款
    case Other
}

class MKRestoreGoods: MKBaseGoods {
    override var ID : Int64?{
        get{
            return self.recId
        }
        set{
            super.ID = newValue
            self.recId = newValue!
        }
    }
    var orderId : Int64 = 0//订单ID
    var orderSn : String = ""//订单号
    var memberId : Int64 = 0//用户ID
    var restoreId : Int64 = 0//restoreID
    var restoreSn : String = ""//退货Sn
    var isGift : Bool = false//是否为赠品
    var restoreContent : String = ""//审核未通过内容
    var restoreStatus : MKResotreGoodsStatusType?//
    var restoreNumber : NSInteger = 0
    var imgPath = Array<String>()//图片信息
    var desc : String = ""//客户描述
    var recId : Int64 = 0//订单赏评id，就是goods的ID
    var createTime : NSTimeInterval = 0//创建时间
    var auditTime : NSTimeInterval = 0//处理订单时间
    var restoreIntegral : CGFloat = 0//返还积分
    
    var type : NSInteger = 0
    
    class func objectClassInArray() ->Dictionary<String,AnyObject>?{
        return ["imgPath" : NSString.self]
    }
    
    class func replacedKeyFromPropertyName() ->Dictionary<String,AnyObject>{
        return ["ID" : "id","Virtual" : "virtual","desc" : "description"]
    }
    
    required init(id: Int64) {
        super.init(id: id)
        self.imgPath = Array<String>()
        self.restoreNumber = 1
    }
    
    convenience init(ID : Int64,orderId : Int64,goodsGuid : String,goodsName : String,cnt : NSInteger,price : CGFloat,picUrl : String,restoreStatus : MKResotreGoodsStatusType,restoreContent : String)
    {
        self.init(id : ID)
        self.orderId = orderId
        self.goodsName = goodsName
        self.cnt = cnt
        self.price = price
        self.picUrl = picUrl
        self.restoreStatus = restoreStatus
        self.restoreContent = restoreContent
    }
}


















