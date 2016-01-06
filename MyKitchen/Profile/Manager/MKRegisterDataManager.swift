//
//  MKRegisterDataManager.swift
//  MyKitchen
//
//  Created by wochu on 16/1/6.
//  Copyright © 2016年 @Wochu. All rights reserved.
//

import UIKit

class MKRegisterDataManager: MKBaseDataManager {
    override func loadMore(page: NSInteger, count: NSInteger, action: MKDoneAction) {
        super.loadMore(page, count: count, action: action)
    }
    
    //获取验证码
    func getRegisterVerifyCode(phoneNumber : String,action : MKRegisterAction){
        MKLoginManager.getRegisterVerifyCode(phoneNumber, action: action)
    }
    
    //注册
    func getRegisterModel(phoneNum : String,_ password : String,_ code : String,_ channel : String,_ invitationCode : String,_ uuid : String,_ uuCode : String,_ action : MKRegisterAction){
        MKLoginManager.getRegisterInfoWithPhoneNumber(phoneNum, password, code, channel, invitationCode, uuid, uuCode, action: action)
    }
    
    //登录
    func getLogin(account : String,_ password : String,_ clientId : String,_ grantType : String,_ action : MKLoginAction){
        MKLoginManager.getLoginWithAccount(account, password, clientId, grantType, action)
    }
}
