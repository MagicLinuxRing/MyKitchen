//
//  MKOrderGoods.swift
//  MyKitchen
//
//  Created by wochu on 16/1/11.
//  Copyright © 2016年 @Wochu. All rights reserved.
//

import UIKit

class MKOrderGoods: MKRestoreGoods {
    var realIntegral : CGFloat = 0.0//真实积分
    var extensionCode : AnyObject?//扩展代码
    var tagIds : [AnyObject] = []//tags
    var goodsAttrIds : AnyObject?//商品属性id
    var parentGuid = ""//Package商品Guid
    var usedScore : NSInteger = 0//分摊到此商品的积分数
    var exception = MKGoodsExceptionData()
    var promotionCondition = MKPromotionCoditionData()
    var goodType = ""//商品类型
}
