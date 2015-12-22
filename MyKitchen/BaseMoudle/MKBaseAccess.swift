//
//  MKBaseAccess.swift
//  MyKitchen
//
//  Created by wochu on 15/12/22.
//  Copyright © 2015年 @Wochu. All rights reserved.
//

import UIKit

class MKBaseAccess: MKBaseWebService {
    
    required init() {
        
        super.init()
    }
    
    class func assembleParametersWithKey(assemblyKey : String , parameters: NSDictionary) -> NSDictionary {
        
        var parts = [String]()
        
        for key : String in parameters{
            var encodedValue = parameters[key]
            if encodedValue is NSDictionary{
                
            }
        }
        
        return nil
    }
}
