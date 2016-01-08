//
//  MKMyOrderProtocol.swift
//  MyKitchen
//
//  Created by wochu on 16/1/8.
//  Copyright © 2016年 @Wochu. All rights reserved.
//

import Foundation

protocol MKMyOrderViewControllerDelegate{
    func myOrderChangeWithNumber(orderNumber : NSNumber)
    func myOrderViewController(myOrderViewController : MKOrderViewController)
    func myOrderViewController(orderViewCtr : MKOrderViewController,orderActionType : MKOrderActionType)
}