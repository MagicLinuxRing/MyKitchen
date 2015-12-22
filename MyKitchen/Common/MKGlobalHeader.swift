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
}






