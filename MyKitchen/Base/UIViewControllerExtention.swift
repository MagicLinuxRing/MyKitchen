//
//  UIViewControllerExtention.swift
//  MyKitchen
//
//  Created by wochu on 16/1/7.
//  Copyright © 2016年 @Wochu. All rights reserved.
//

import Foundation

extension UIViewController{
    private struct AssociatedKeys{
        static var DescriptiveName = "mk_DescriptiveName"
    }
    
    var descriptiveName : String?{
        get{
            return objc_getAssociatedObject(self, &AssociatedKeys.DescriptiveName) as? String
        }
        set{
            if let newValue = newValue{
                objc_setAssociatedObject(self, &AssociatedKeys.DescriptiveName, newValue as NSString?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    public override class func initialize(){
        struct Static{
            static var token : dispatch_once_t = 0
        }
        
        if self != UIViewController.self{
            return
        }
        
        dispatch_once(&Static.token) { () -> Void in
            let originalSelector = Selector("viewWillAppear:")
            let swizzledSelector = Selector("mk_viewWillAppear:")
            
            let originalMethod = class_getInstanceMethod(self, originalSelector)
            let swizzledMehod = class_getInstanceMethod(self, swizzledSelector)
            let didAddMehod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMehod), method_getTypeEncoding(swizzledMehod))
            
            if didAddMehod {
                class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
            }
            else{
                method_exchangeImplementations(originalMethod, swizzledMehod)
            }
        }
    }
    
    func mk_viewWillAppear(animated : Bool){
        self.mk_viewWillAppear(animated)
        
        if let name = self.descriptiveName{
            print("viewWillAppear:\(name)")
        }
        else{
            print("viewWillAppear:\(self)")
        }
    }
}













