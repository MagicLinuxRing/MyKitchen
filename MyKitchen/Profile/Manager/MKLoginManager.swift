//
//  MKLoginManager.swift
//  MyKitchen
//
//  Created by wochu on 15/12/23.
//  Copyright © 2015年 @Wochu. All rights reserved.
//
// login interface manager/ add by jack

import UIKit

typealias MKRegisterAction = (registerModel : MKRegisterModel? ,error : NSError?) ->()
typealias MKCodeAction = (codeModel : MKCodeModel?,error : NSError?) ->()
typealias MKLoginAction = (loginModel : MKLoginModel?,error : NSError? ) ->()
typealias MKFindPasswdAction = (dict : Dictionary<String,AnyObject>?,error : NSError?) ->()
typealias MKSuccessNoResultAction = (isSuccess : Bool,error : NSError?) -> ()

class MKLoginManager: MKBaseAccess {
    
    required init() {
        super.init()
    }
    
    //找回密码
    class func getFindPassword(account : String,_ code : String, passwd : String,_ action : MKFindPasswdAction) {
        var dict = Dictionary<String,AnyObject>()
        dict["account"] = account
        dict["code"] = code
        dict["password"] = passwd
        self.POST(self.assembleURLString("member/password/reset"), parameters: ["member" : dict]) { (resultTask, result, justError) -> () in
            if justError != nil{
                action(dict: nil, error: justError)
            }
            else{
                action(dict: (result!["data"] as! Dictionary<String,AnyObject>), error: nil)
            }
        }
    }
    
    //注册获取验证码
    class func getRegisterVerifyCode(phoneNaumber : String,action : MKRegisterAction?){
        var dict = Dictionary<String,Any>()
        dict["mobile"] = phoneNaumber
        let paraneters = self.assembleParametersWithKey("parameters", parameters: dict) 
        self .GET(self.assembleURLString("member/sendSMS"), parameters: paraneters) { (task :NSURLSessionDataTask,responseObject : AnyObject?,error : NSError?) -> () in
            if error != nil{
                return action!(registerModel: nil,error: error!)
            }
            else
            {
                let registerModel : MKRegisterModel = MKRegisterModel.mj_objectWithKeyValues(responseObject!)
                action!(registerModel: registerModel, error: nil)
            }
        }
    }
    
    //匹配验证码
    class func checkIdentifyCodeWithPhoneNum(phoneNumber : String,code : String ,action:MKCodeAction) {
        var dic = Dictionary<String,AnyObject>()
        dic["account"] = phoneNumber
        dic["code"] = code
        
        let parameters  = ["member" : dic]
        
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
        var dictInfo = Dictionary<String,AnyObject>()
        dictInfo["account"] = phoneNum
        dictInfo["password"] = passwd
        dictInfo["code"] = code
        dictInfo["registrationChannel"] = registrationChannel
        dictInfo["invitationCode"] = invitationCode
        dictInfo["uuId"] = uuid
        dictInfo["unCode"] = uncode
        
        let parameter = ["member" : dictInfo]
        
        self.POST(self.assembleURLString("member/register"), parameters: parameter)
            { (task : NSURLSessionDataTask, response : AnyObject?, error : NSError?) -> () in
                if error != nil{
                    action(registerModel: nil, error: error)
                }
                else{
                    let registerModel : MKRegisterModel = MKRegisterModel.mj_objectWithKeyValues(response!["data"])
                    return action(registerModel: registerModel, error: nil)
                }
        }
    }
    
    //登录
    class func getLoginWithAccount(account : String ,_ passwd : String,_ clientId : String?,_ grantType : String?,_ action : MKLoginAction) {
        var parmaters = Dictionary<String,AnyObject>()
        parmaters["grant_type"] = "password"
        parmaters["UserName"] = account
        parmaters["password"] = passwd
        self.requestForHttpSerializer()
        
        self.POST("token", parameters: parmaters) { (task :NSURLSessionDataTask, response : AnyObject?, error : NSError?) -> () in
            if  error != nil{
                action(loginModel: nil, error: error)
            }
            else{
                let loginModel :  MKLoginModel = MKLoginModel.mj_objectWithKeyValues(response as! NSDictionary)
                action(loginModel: loginModel, error: nil)
            }
        }
        
    }
    
    //检测图片验证码是否正确
    class func getMemberCapchCodeWithUUId(uuid : String ,_ uuCode : String,_ action : MKSuccessNoResultAction) {
        var paramters = Dictionary<String,AnyObject>()
        paramters["uuId"] = uuid
        paramters["uucode"] = uuCode
        self.POST(self.assembleURLString("member/getCaptchaCode"), parameters: ["member" : paramters]) { (task : NSURLSessionDataTask, response : AnyObject?, error : NSError?) -> () in
            if error != nil {
                action(isSuccess: false, error: error)
            }
            else{
                var isSuccess = false
                if response!["hasError"] as! Bool {
                    isSuccess = true
                }
                action(isSuccess: isSuccess, error: nil)
            }
        }
    }
    
    //检验账户是否存在
    class func getMemberNameIsExists(account : String,_ action : MKSuccessNoResultAction) {
        var dict = Dictionary<String,Any>()
        dict["account"] = account
        let parameter = self.assembleParametersWithKey("parameters", parameters: dict)
        
       self.GET(self.assembleURLString("member/name/exists"), parameters: parameter) { (dataTask, results, justError) -> () in
            if justError != nil{
                action(isSuccess: false, error: justError)
            }
            else{
                var isSussess = false
                if results!["data"] is NSDictionary {
                    isSussess = results!["data"]!!["count"]!!.integerValue > 0
                }
                action(isSuccess: isSussess, error: nil)
            }
        }
    }
}























