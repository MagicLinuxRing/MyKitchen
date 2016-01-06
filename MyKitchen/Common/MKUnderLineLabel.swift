//
//  MKUnderLineLabel.swift
//  MyKitchen
//
//  Created by wochu on 16/1/6.
//  Copyright © 2016年 @Wochu. All rights reserved.
//

import UIKit

class MKUnderLineLabel: UILabel {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib()
        self.text = "注册即您已同意服务协议"
        self.userInteractionEnabled = true
    }
    
    override var text : String?{
        willSet{
        }
        didSet{
            let attributedString : NSMutableAttributedString = NSMutableAttributedString()
            attributedString.appendAttributedString(NSMutableAttributedString(string: "注册即您已同意", attributes: [NSUnderlineStyleAttributeName : NSNumber(long: NSUnderlineStyle.StyleNone.rawValue)]))
            attributedString.appendAttributedString(NSMutableAttributedString(string: "服务协议", attributes: [NSUnderlineStyleAttributeName : NSNumber(long: NSUnderlineStyle.StyleSingle.rawValue)]))
            self.attributedText = attributedString
        }
    }

}
