//
//  WCLoaderViewManager.swift
//  MyKitchen
//
//  Created by wochu on 15/12/17.
//  Copyright © 2015年 @Wochu. All rights reserved.
//

import UIKit

class MKLoaderViewManager: MKObject {
    
    class func myOrderViewController() -> MKOrderViewController {
        return self.orderStoryBoard.instantiateViewControllerWithIdentifier("OrderDetail") as! MKOrderViewController
    }
    
    class var homePageViewController : UIStoryboard {
        struct HomePage {
            static var onceToken : dispatch_once_t = 0
            static var instance : UIStoryboard? = nil
        }
        dispatch_once(&HomePage.onceToken) { () -> Void in
            HomePage.instance = UIStoryboard(name: "HomePage", bundle: nil)
        }
        return HomePage.instance!
    }
    
    class var filterStoryBoard : UIStoryboard {
        struct FilterBoard {
            static var onceToken : dispatch_once_t = 0
            static var instance : UIStoryboard? = nil
        }
        dispatch_once(&FilterBoard.onceToken) { () -> Void in
            FilterBoard.instance = UIStoryboard(name: "Filter", bundle: nil)
        }
        return FilterBoard.instance!
    }
    
    class var cartsStoryBoard : UIStoryboard {
        struct CartsBoard {
            static var onceToken : dispatch_once_t = 0
            static var instance : UIStoryboard? = nil
        }
        dispatch_once(&CartsBoard.onceToken) { () -> Void in
            CartsBoard.instance = UIStoryboard(name: "Carts", bundle: nil)
        }
        return CartsBoard.instance!
    }
    
    class var orderStoryBoard : UIStoryboard {
        struct OrderBoard {
            static var onceToken : dispatch_once_t = 0
            static var instance : UIStoryboard? = nil
        }
        dispatch_once(&OrderBoard.onceToken) { () -> Void in
            OrderBoard.instance = UIStoryboard(name: "Order", bundle: nil)
        }
        return OrderBoard.instance!
    }
    
    class var proFileStoryBoard : UIStoryboard {
        struct ProfileBoard {
            static var onceToken : dispatch_once_t = 0
            static var instance : UIStoryboard? = nil
        }
        dispatch_once(&ProfileBoard.onceToken) { () -> Void in
            ProfileBoard.instance = UIStoryboard(name: "Profile", bundle: nil)
        }
        return ProfileBoard.instance!
    }
    
    class var settingsStoryBoard : UIStoryboard {
        struct SettingBoard {
            static var onceToken : dispatch_once_t = 0
            static var instance : UIStoryboard? = nil
        }
        dispatch_once(&SettingBoard.onceToken) { () -> Void in
            SettingBoard.instance = UIStoryboard(name: "Settings", bundle: nil)
        }
        return SettingBoard.instance!
    }
}





