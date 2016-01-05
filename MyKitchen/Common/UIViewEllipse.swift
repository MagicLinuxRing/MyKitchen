//
//  UIViewEllipse.swift
//  MyKitchen
//
//  Created by wochu on 16/1/4.
//  Copyright © 2016年 @Wochu. All rights reserved.
//

import Foundation

let UITextFiled_Master_maxLength = "UITextFiled_Master_maxLength"
let UITextFiled_Master_digitsChars = "UITextFiled_Master_digitsChars"

extension UIView{
    
    public func becomeEllopseViewWithBorderColor(color : UIColor,_ borderWidth : CGFloat,_ cornerRadius : CGFloat){
        self.layer.masksToBounds = true
        self.layer.borderColor = color.CGColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
    }
}

extension UITextField{
    func setMaxLength(maxLength : NSInteger){
        objc_setAssociatedObject(self, UITextFiled_Master_maxLength, NSNumber(integer: maxLength), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        self.removeTarget(self, action: "MasterTextFieldChange:", forControlEvents: UIControlEvents.EditingChanged)
        self.addTarget(self, action: "MasterTextFieldChange:", forControlEvents: UIControlEvents.EditingChanged)
    }
    
    func maxLength() -> NSInteger{
        let maxLength = objc_getAssociatedObject(self, UITextFiled_Master_maxLength)
        return maxLength.integerValue
    }
    
    func setDigitsCharts(digitsCharts : Array<String>){
        objc_setAssociatedObject(self, UITextFiled_Master_digitsChars, digitsCharts, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        self.removeTarget(self, action: "MasterTextFieldChange:", forControlEvents: UIControlEvents.EditingChanged)
        self.addTarget(self, action: "MasterTextFieldChange:", forControlEvents: UIControlEvents.EditingChanged)
    }
    
    func digitsCharts() -> AnyObject?{
        let charts = objc_getAssociatedObject(self, UITextFiled_Master_digitsChars)
        return charts
    }
    
    func MasterTextFieldChange(textField : UITextField){
        if textField.markedTextRange == nil && self.digitsCharts() != nil && self.digitsCharts()!.count > 0{
            var newString : NSMutableString?
            for var i = 0 ;i < textField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding);i++
            {
                let str = (textField.text! as NSString).substringWithRange(NSMakeRange(i, 1))
                if self.digitsCharts()!.containsObject(str){
                    newString?.appendString(str)
                }
                textField.text? = newString! as String
            }
        }
        
        if self.maxLength() > 0{
            if textField.markedTextRange == nil &&
                textField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > self.maxLength(){
                    textField.text? = (textField.text! as NSString).substringToIndex(self.maxLength())
            }
        }
    }
}
















