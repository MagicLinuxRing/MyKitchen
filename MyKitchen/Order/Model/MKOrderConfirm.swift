//
//  MKOrderConfirm.swift
//  MyKitchen
//
//  Created by wochu on 16/1/11.
//  Copyright © 2016年 @Wochu. All rights reserved.
//

import UIKit

class MKOrderConfirm: MKBaseModel {
    var address = MKAddress()
    var shippingTime = MKShippingTime()
    var payment = MKPaymentData()
    var score : NSInteger = 0
    var UsedScore : NSInteger = 0
    var GoodDetails : [AnyObject] = []
    var ExclusionPromotionResult : [AnyObject] = []
    var SharePromotionResult : [AnyObject] = []
    var MasterialVoucherGift : [AnyObject] = []
    var VoucherAmount : CGFloat = 0.0
    var ShippingFee : CGFloat = 0.0
    var DiscountAmount : CGFloat = 0.0
    var Amount : CGFloat = 0.0
    var PresentAmount : CGFloat = 0.0
    var PaymentAmount : CGFloat = 0.0
    var FreeShippingVoucherAmount : CGFloat = 0.0
    var HashCode = ""
    var Key = ""
    var PresentGift : MKOrderGoods?
    var Vouchers : [AnyObject] = []
    var Gift : [AnyObject] = []
    var scoreUsed : CGFloat = 0.0
    var CouponCode = ""
}
