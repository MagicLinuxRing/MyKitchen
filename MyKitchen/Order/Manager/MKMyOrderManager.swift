//
//  MKMyOrderManager.swift
//  MyKitchen
//
//  Created by wochu on 16/1/11.
//  Copyright © 2016年 @Wochu. All rights reserved.
//

import UIKit

class MKMyOrderManager: MKBaseDataManager {
    
    var type : MKOrderStatus?

    func setTargetOrderStatusType(type : MKOrderStatus){
        self.type = type
    }
    
    override func loadMore(page: NSInteger, count: NSInteger, action: MKDoneAction) {
        
    }
}
