//
//  MKSeparateView.swift
//  MyKitchen
//
//  Created by wochu on 16/1/6.
//  Copyright © 2016年 @Wochu. All rights reserved.
//

import UIKit

class MKSeparateView: UIView {

    var bgColor : UIColor?

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(ctx, 1)
        if bgColor != nil{
            bgColor?.set()
        }
        else{
            UIColor.blackColor().set()
        }
        CGContextMoveToPoint(ctx, 0, rect.size.height)
        CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height)
        CGContextStrokePath(ctx)
    }
    

}
