//
//  MKMyOrderGoodsView.swift
//  MyKitchen
//
//  Created by wochu on 16/1/12.
//  Copyright © 2016年 @Wochu. All rights reserved.
//

import UIKit

class MKMyOrderGoodsView: UIView {

    var goodsViewArray : [AnyObject] = []
    var goods : [AnyObject] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    required override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubViewConstraints(){
        if self.goodsViewArray.count > 0 {
            return
        }
        self.removeConstraints(self.constraints)
        
        var viewsDictionaryV = Dictionary<String,AnyObject>()
        let vflv = NSMutableString()
        for var i = 0 ; i < self.goodsViewArray.count; i++ {
            if i == 0 {
                vflv.setString("V:|")
            }
            let goodsView = self.goodsViewArray[i] as! MKHorizontalGoodsView
            goodsView.translatesAutoresizingMaskIntoConstraints = false
            let key = "view" + String(i)
            viewsDictionaryV[key] = goodsView
            let viewDictionaryH : [String : AnyObject] = [key : goodsView]
            let tmpStr = "-2.0-[\(key)(90.00)]"
            vflv.appendString(tmpStr)
            let vflH = "H:|-0-[\(key)-0-|]"
            
            let constraintsH = NSLayoutConstraint.constraintsWithVisualFormat(vflH, options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: viewDictionaryH)
            self.addConstraints(constraintsH)
        }
        let constraintsV = NSLayoutConstraint.constraintsWithVisualFormat(vflv as String, options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: viewsDictionaryV)
        self.addConstraints(constraintsV)
    }
    
}

class MKHorizontalGoodsView : UIView {
    class func goodsView() -> MKHorizontalGoodsView {
        let goodsView : MKHorizontalGoodsView = NSBundle.mainBundle().loadNibNamed("MKHorizontalGoodsView", owner: nil, options: nil).first as! MKHorizontalGoodsView
        return goodsView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}


























