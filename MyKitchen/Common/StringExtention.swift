//
//  StringExtention.swift
//  MyKitchen
//
//  Created by wochu on 16/1/6.
//  Copyright © 2016年 @Wochu. All rights reserved.
//

import Foundation

extension String{

    var length : NSInteger{
        get{
            return self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
        }
    }
}