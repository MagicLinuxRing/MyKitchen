//
//  MKLoginModel.swift
//  MyKitchen
//
//  Created by wochu on 15/12/31.
//  Copyright © 2015年 @Wochu. All rights reserved.
//

import UIKit

class MKLoginModel: MKBaseModel {
    internal var expires : String? //token 过期时间
    internal var issued : String?//token生成时间
    internal var access_token : String?//token
//    internal var account : String?
//    internal var alias : String?
    internal var expires_in : String?//token过期时间（多少秒）
    internal var token_type : String?//token类型
    internal var displayName : String?//会员信息
    internal var guid : String? //会员guid
}
