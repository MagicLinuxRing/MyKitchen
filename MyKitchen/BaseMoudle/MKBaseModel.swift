//
//  MKBaseModel.swift
//  MyKitchen
//
//  Created by wochu on 15/12/23.
//  Copyright © 2015年 @Wochu. All rights reserved.
//

import UIKit

class MKBaseModel: MKObject {
    internal var ID : Int64?
    internal var count : Int64?
    internal var enabled : Bool
    
    required init(ID : Int64) {
        super.init()
        self.ID = ID
        self.count = 0
        self.enabled = true
    }

    required init() {
        fatalError("init() has not been implemented")
    }
    
    class func replaceKeyFromPropertyName() ->[String : String] {
        return ["ID":"id"]
    }
    
}
