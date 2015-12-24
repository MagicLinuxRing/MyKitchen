//
//  MKLoginManager.swift
//  MyKitchen
//
//  Created by wochu on 15/12/23.
//  Copyright © 2015年 @Wochu. All rights reserved.
//
// login interface manager/ add by jack

import UIKit
typealias MKRegisterAction = (loginModel : MKLoginModel? ,error : NSError) ->()
typealias MKLoginModelAction = ()

class MKLoginManager: MKBaseAccess {
    
    required init() {
        super.init()
    }
    
    class func getRegisterVerifyCode(phoneNaumber : String,action : MKRegisterAction?){
        var dict : NSMutableDictionary?
        dict?.setObject(phoneNaumber, forKey: "mobile")
//        var dict_t : NSDictionary = dict!
        var paraneters = self.assembleParametersWithKey("parameters", parameters: dict as! Dictionary<String, AnyObject>)
        self .GET(self.assembleURLString("member/sendSMS"), parameters: paraneters) { (task :NSURLSessionDataTask,responseObject : AnyObject?,error : NSError?) -> () in
            if error != nil{
                return action!(loginModel: nil,error: error!)
            }
            else
            {
                
            }
        }
    }
    
}
