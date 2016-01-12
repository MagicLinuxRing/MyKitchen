//
//  MKShippingTime.swift
//  MyKitchen
//
//  Created by wochu on 16/1/11.
//  Copyright © 2016年 @Wochu. All rights reserved.
//

import UIKit

class MKShippingTime: MKBaseModel {
    var shippingTimeId : NSInteger = 0//
    var startTime : NSInteger = 0//
    var endTime : NSInteger = 0//
    var ischeck = false
    private(set) var shippingDate : NSTimeInterval = 0.0
    var memberId = ""
    var addressId : Int64 = 0
    var address = ""
}
