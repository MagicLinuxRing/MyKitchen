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
    
    var placeholderImage : UIImage?
    var placeholderWidthImage : UIImage?
    var defalutImage : UIImage?
    var userImage : UIImage?
    var backgroundColor : UIColor?
    var grayColor : UIColor?
    var originColor : UIColor?
    var greenColor : UIColor?
    var grayFontColor : UIColor?
    
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
    
    required init() {
        self.placeholderImage = UIImage(named: "image_placeholder")
        self.placeholderWidthImage = UIImage(named: "image_placeWidthOlder")
        self.defalutImage = UIImage(named: "image_defaultImage")
        self.userImage = UIImage(named: "center_image_user")
        self.backgroundColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0)
        self.grayColor = UIColor(white: 100.0/255.0, alpha: 0.2)
        self.originColor = RGB(236.0, G: 105.0, B: 41.0, alpha: 1.0)
        self.greenColor = RGB(85, G: 186, B: 66, alpha: 1.0)
        self.grayFontColor = RGB(102, G: 102, B: 102, alpha: 1.0)
        super.init()
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






