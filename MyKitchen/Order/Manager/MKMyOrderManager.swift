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
        MKOrderAccess.getOrders(page, count: count, orderStatus: self.type!) { (array, error) -> () in
            run({ () -> Void in
                if let error = error {
                    return action(error: error)
                }
                else{
                    if page == 1 {
                        self.items!.removeAll()
                    }
                    self.setLastPackageCount(array!.count)
                    self.page = page
                    self.items!.appendContentsOf(array!)
                    return action(error: nil)
                }
            })
        }
    }
}
