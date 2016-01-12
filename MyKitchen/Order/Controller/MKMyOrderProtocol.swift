//
//  MKMyOrderProtocol.swift
//  MyKitchen
//
//  Created by wochu on 16/1/8.
//  Copyright © 2016年 @Wochu. All rights reserved.
//

import Foundation

@objc protocol MKMyOrderViewControllerDelegate{
    
    optional func myOrderChangeWithNumber(orderNumber : NSNumber)
    optional func myOrderViewController(myOrderViewController : MKOrderViewController)
    optional func myOrderViewController(orderViewCtr : MKOrderViewController,orderActionType : NSInteger,order : MKBaseOrder)
    optional func myOrderViewController(myOrderViewCtr : MKOrderViewController, didPressedSingleRestore : MKRestoreGoods)
}