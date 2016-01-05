//
//  MKLoginManager.swift
//  MyKitchen
//
//  Created by wochu on 15/12/23.
//  Copyright © 2015年 @Wochu. All rights reserved.
//
// login interface manager/ add by jack

import UIKit

typealias MKRegisterAction = (loginModel : MKRegisterModel? ,error : NSError?) ->()
typealias MKCodeAction = (codeModel : MKCodeModel?,error : NSError?) ->()
typealias MKLoginAction = (loginModel : MKLoginModel?,error : NSError? ) ->()

class MKLoginManager: MKBaseAccess {
    
    required init() {
        super.init()
    }
    
    //注册获取验证码
    class func getRegisterVerifyCode(phoneNaumber : String,action : MKRegisterAction?){
        var dict : Dictionary<String,AnyObject>?
        dict!["mobile"] = phoneNaumber
        let paraneters = self.assembleParametersWithKey("parameters", parameters: dict!)
        self .GET(self.assembleURLString("member/sendSMS"), parameters: paraneters) { (task :NSURLSessionDataTask,responseObject : AnyObject?,error : NSError?) -> () in
            if error != nil{
                return action!(loginModel: nil,error: error!)
            }
            else
            {
                let registerModel : MKRegisterModel = MKRegisterModel.mj_objectWithKeyValues(responseObject!)
                action!(loginModel: registerModel, error: nil)
            }
        }
    }
    
    //匹配验证码
    class func checkIdentifyCodeWithPhoneNum(phoneNumber : String,code : String ,action:MKCodeAction) {
        var dic : Dictionary<String,AnyObject>?
        dic!["account"] = phoneNumber
        dic!["code"] = code
        
        let parameters  = ["member" : dic!]
        
        self.POST(self.assembleURLString("member/password/checkcode"), parameters: parameters) { (task : NSURLSessionDataTask, response : AnyObject?, error : NSError?) -> () in
            if error != nil{
                return action(codeModel: nil, error: error)
            }
            else{
                let codeModel = MKCodeModel.mj_objectWithKeyValues(response!["data"]!)
                return action(codeModel: codeModel!, error: nil)
            }
        }
    }
    
    //注册
    class func getRegisterInfoWithPhoneNumber(phoneNum : String,_ passwd : String,_ code : String, _ registrationChannel : String,_ invitationCode : String,_ uuid : String,_ uncode : String, action : MKRegisterAction) {
        var dictInfo : Dictionary<String,AnyObject>?
        dictInfo!["account"] = phoneNum
        dictInfo!["password"] = passwd
        dictInfo!["code"] = code
        dictInfo!["registrationChannel"] = registrationChannel
        dictInfo!["invitationCode"] = invitationCode
        dictInfo!["uuId"] = uuid
        dictInfo!["unCode"] = uncode
        
        let parameter = ["member" : dictInfo!]
        
        self.POST(self.assembleURLString("member/register"), parameters: parameter)
            { (task : NSURLSessionDataTask, response : AnyObject?, error : NSError?) -> () in
                if error != nil{
                    action(loginModel: nil, error: error)
                }
                else{
                    let registerModel : MKRegisterModel = MKRegisterModel.mj_objectWithKeyValues(response!["data"])
                    return action(loginModel: registerModel, error: nil)
                }
        }
    }
    
    //登录
    class func getLoginWithAccount(account : String ,_ passwd : String,_ clientId : String?,_ grantType : String?,_ action : MKLoginAction) {
        var parmaters : Dictionary<String,AnyObject>?
        parmaters!["grant_type"] = "password"
        parmaters!["UserName"] = account
        parmaters!["password"] = passwd
        self.requestForHttpSerializer()
        
        self.POST("token", parameters: parmaters!) { (task :NSURLSessionDataTask, response : AnyObject?, error : NSError?) -> () in
            if  error != nil{
                action(loginModel: nil, error: error)
            }
            else{
                let loginModel :  MKLoginModel = MKLoginModel.mj_objectWithKeyValues(response!["data"])
                action(loginModel: loginModel, error: nil)
            }
        }
        
    }
}























