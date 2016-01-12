//
//  MKAddress.swift
//  MyKitchen
//
//  Created by wochu on 16/1/11.
//  Copyright © 2016年 @Wochu. All rights reserved.
//

import UIKit

class MKAddress: MKBaseModel {
    var addressId : Int64 = 0
    var mobile = ""//手机号
    var region = ""//地理位置，区
    var address = ""
    var addressName = ""//位置名称
    var consignee = ""//收件人
    var memberId = ""
    var logitude : CGFloat = 0.0
    var latitude : CGFloat = 0.0
    var tel = ""//座机
    var siteSN : NSInteger = 0// 配送站点编号
    var isDefault = false//是否默认地址
}
