//
//  MKGlobalHeader.swift
//  MyKitchen
//
//  Created by wochu on 15/12/22.
//  Copyright © 2015年 @Wochu. All rights reserved.
//

import UIKit

let DEBUG = true

let MKBaseConnectorAddress  = "http://58.247.11.229:9093/"
let MKBaseConnectorReleaseAddress = "http://api4.wochu.cn/"

func URLBASE() -> String{
    if DEBUG{
        return MKBaseConnectorAddress
    }
    return MKBaseConnectorReleaseAddress
}

class MKGlobalHeader : MKObject{
    
    class func defaultInstance() ->MKGlobalHeader {
        struct globalHeader{
            static var onceToken : dispatch_once_t = 0
            static var instance : MKGlobalHeader? = nil
        }
        
        dispatch_once(&globalHeader.onceToken) { () -> Void in
            globalHeader.instance = MKGlobalHeader()
        }
        return globalHeader.instance!
    }
    
    func accessToken() -> String?{
        return NSUserDefaults.standardUserDefaults().objectForKey("token") as? String
    }
    
    func saveLoginUser(loginUser : Dictionary<String,AnyObject>?){
        if loginUser != nil{
            NSUserDefaults.standardUserDefaults().setObject(loginUser!, forKey: "autoLoginData")
        }
        else{
            NSUserDefaults.standardUserDefaults().removeObjectForKey("autoLoginData")
        }
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func getLoginUser() ->Dictionary<String,AnyObject>{
        return NSUserDefaults.standardUserDefaults().objectForKey("autoLoginData") as! Dictionary
    }
    
    func setLoginInfoData(info : AnyObject?){
        if info != nil{
            let token = "bearer".stringByAppendingString(info as! String)
            NSUserDefaults.standardUserDefaults().setObject(token, forKey: "token")
        }
        else{
            NSUserDefaults.standardUserDefaults().removeObjectForKey("token")
        }
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func checkNetworkState() -> Bool{
        let wifi = Reachability.reachabilityForLocalWiFi()
        let conn = Reachability.reachabilityForInternetConnection()
        
        if wifi.currentReachabilityStatus() != NotReachable {
            return true
        }
        else if conn.currentReachabilityStatus() != NotReachable {
            return true
        }
        return false
    }
}






