
//
//  MKRegisterModel.swift
//  MyKitchen
//
//  Created by wochu on 15/12/25.
//  Copyright © 2015年 @Wochu. All rights reserved.
//

import UIKit

class MKRegisterModel: MKBaseModel {
    /**
     *   code说胆： -1，手机号已注册；-2，发送初始密码失败，1，发送初始密码成功
     */
    var code : NSInteger = 0
    /**
     *  message 如手机号已经注册
     */
    var message : String = ""
    var guid : String = ""//会员guid
}

