//
//  MKGlobalHeader.swift
//  MyKitchen
//
//  Created by wochu on 15/12/22.
//  Copyright © 2015年 @Wochu. All rights reserved.
//

import UIKit

let DEBUG = true

let MKBaseConnectorAddress  = "http://dev1.ikitchen.cc:9093/"
let MKBaseConnectorReleaseAddress = "http://api4.wochu.cn/"

func URLBASE() -> String{
    if DEBUG{
        return MKBaseConnectorAddress
    }
    return MKBaseConnectorReleaseAddress
}

class MKGlobalHeader : MKObject{
    
    var placeholderImage = UIImage(named: "image_placeholder")
    var placeholderWidthImage = UIImage(named: "image_placeWidthOlder")
    var defalutImage = UIImage(named: "image_defaultImage")
    var userImage = UIImage(named: "center_image_user")
    var backgroundColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0)
    var grayColor = UIColor(white: 100.0/255.0, alpha: 0.2)
    var originColor = RGB(236.0, G: 105.0, B: 41.0, alpha: 1.0)
    var greenColor = RGB(85, G: 186, B: 66, alpha: 1.0)
    var grayFontColor = RGB(102, G: 102, B: 102, alpha: 1.0)
    
    var appConfig : AnyObject?
    var loginInfo : AnyObject?
    var WxPayNotifyURL : String?
    var AliPayNotifyURL : String?
    
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
    
    required override init() {
        super.init()
    }
    
    class func getUUID() ->String {
        let puuid = CFUUIDCreate(nil)
        let uuidString = CFUUIDCreateString(nil, puuid)
        let result : String = CFStringCreateCopy(nil, uuidString) as String
        return result
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
    
    func isLogin() -> Bool{
        if self.loginInfo == nil{
            self.loginInfo = NSUserDefaults.standardUserDefaults().objectForKey("token")
        }
        return self.loginInfo != nil ? true : false
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






