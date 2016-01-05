//
//  MKBaseModel.swift
//  MyKitchen
//
//  Created by wochu on 15/12/23.
//  Copyright © 2015年 @Wochu. All rights reserved.
//

import UIKit

class MKBaseModel: MKObject {
    internal var ID : Int64? = 0
    internal var count : Int64? = 0
    internal var enabled : Bool = true
    
    class func replaceKeyFromPropertyName() ->[String : String] {
        return ["ID":"id"]
    }
    
}
