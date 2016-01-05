//
//  MKCodeModel.swift
//  MyKitchen
//
//  Created by wochu on 15/12/31.
//  Copyright © 2015年 @Wochu. All rights reserved.
//

import UIKit

class MKCodeModel: MKBaseModel {
    
    // 1.pass -1:overtime or not exist -2:code error
    internal var code : NSInteger = 0//验证码
    
    internal var message : String!
}
