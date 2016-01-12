//
//  MKOrderAccess.swift
//  MyKitchen
//
//  Created by wochu on 16/1/11.
//  Copyright © 2016年 @Wochu. All rights reserved.
//

import UIKit

typealias MKOrderCommonAction = (count : NSInteger,error : NSError) ->()//普通返回
typealias MKOrderAction = (order : MKOrder?,error : NSError?) -> ()
typealias MKCreateOrderAction = (orderID : Int64,orderSn : String,error : NSError?) ->()
typealias MKOrderModifySureAction = (orderConfirm : MKOrderConfirm,error : NSError?) ->()
typealias MKCommentOrderAction = (array : [AnyObject]? ,error : NSError?) ->()//评论

class MKOrderAccess: MKBaseAccess {
    
    //get order list
    class func getOrders(page : NSInteger,count : NSInteger,orderStatus : MKOrderStatus,action : MKCommentOrderAction) {
        let dict : [String : Any] = ["pageSize" : count,"pageIndex" : page,"waitForStatus" : orderStatus]
        let parameters = self.assembleParametersWithKey("parameters", parameters: dict)
        self.GET(self.assembleURLString("order/list"), parameters: parameters) { (dataTask, results, justError) -> () in
            if let error = justError {
                return action(array: nil, error: error)
            }
            else{
                let orders = MKBaseOrder.mj_objectArrayWithKeyValuesArray(results!["data"]!!["items"]!)
                let swiftArray = Array(orders)
                for order in swiftArray {
                    (order as! MKBaseOrder).updateGoodsOrderSn()
                }
                return action(array: swiftArray, error: nil)
            }
        }
    }
    
    //get order detail
    class func getOrderDetail(orderID : Int64,count : NSInteger,orderStatus : MKOrderStatus,action : MKOrderAction) {
        let dict : [String : Any] = ["orderId" : orderID]
        let parameters = self.assembleParametersWithKey("parameters", parameters: dict)
        self.GET(self.assembleURLString("order/get"), parameters: parameters) { (dataTask, results, justError) -> () in
            if let error = justError {
                return action(order: nil, error: error)
            }
            else{
                let order = MKOrder.mj_objectWithKeyValues(results!["data"]!)
                order.updateGoodsOrderSn()
                return action(order: order, error: nil)
            }
        }
    }
    
    //get cancel order at anytime
    class func cancelOrderAnyTime(cancelSn : String,_ cancelReson : String,_ action : (isSuccess : Bool,count : NSInteger,error : NSError?) ->()) {
        let dict = ["orderSn" : cancelSn,"cancelReson" : "cancelReson"]
        let parameters = ["order" : dict]
        self.POST(self.assembleURLString("order/anytime/cancel"), parameters: parameters) { (resultTask, result, justError) -> () in
            if let error = justError {
                return action(isSuccess: false, count: 0, error: error)
            }
            else{
                var goodsNumber = 0
                if result!["data"] is Dictionary<String,Any> {
                    goodsNumber = result!["data"]!!["count"]! as! NSInteger
                }
                return action(isSuccess: true, count: goodsNumber, error: nil)
            }
        }
    }
    
    //获取订单审批记录
    class func getOrderStatusAnyTime(action : (errorMessage : String?,data : [String : Any]?) ->()) {
        self.GET(self.assembleURLString("order/anytime/cancel/get"), parameters: nil) { (dataTask, results, justError) -> () in
            if let error = justError {
                print("\(error.localizedDescription)")
                action(errorMessage: results!["errorMessage"] as? String, data: nil)
            }
            else{
                action(errorMessage: nil, data: results!["data"] as? [String : Any])
            }
        }
    }
    
    ////order change delivery time & address
    class func changeOrderDeliver(orderSn : String,_ deliveryTime : String,_ address : MKAddress,action : MKSuccessNoResultAction) {
        let dict = ["orderSn" : orderSn.stringByNotNull(),"deliveryTime" :deliveryTime.stringByNotNull(),"region" : address.region.stringByNotNull(),"mobile" : address.mobile.stringByNotNull(),"address" : address.address.stringByNotNull(),"consignee" : address.consignee.stringByNotNull()]
        let parameters = ["order" : dict]
        self.POST(self.assembleURLString("order/change/shippingTime"), parameters: parameters) { (resultTask, result, justError) -> () in
            if let error = justError {
                action(isSuccess: false, error: error)
            }
            else{
                var success = false
                if result!["data"] is [String : Any] {
                   success = (result!["data"]!!["count"] as! NSInteger) > 0
                }
                action(isSuccess: success, error: nil)
            }
        }
    }
    
    //获取当前订单配送时间及地址
    class func getCurrentOrderTimeAndAddress(action: (errorMessage : String?,responseData : [String :Any]?) ->()) {
        self.GET(self.assembleURLString("order/shippingtime/get"), parameters: nil) { (dataTask, results, justError) -> () in
            if let error = justError {
                print("\(error.localizedDescription)")
                action(errorMessage: results!["errorMessage"] as? String, responseData: nil)
            }
            else{
                 action(errorMessage: nil, responseData: results!["data"] as? [String : Any])
            }
        }
    }
    
    //创建订单
    class func createOrder(order : MKOrder,action : MKCreateOrderAction){
//        let parameters =
    }
    
    //取消订单
    class func cancelOrder(orderID : Int64,action : MKSuccessNoResultAction){
    
    }
    
    //创建订单（商品）
    class func createOrder(orderConfirm : MKOrderConfirm,_ action : MKCreateOrderAction) {
    
    }
    
    //确认收货
    class func confirmReceiveOrder(orderId : Int64,_ action : MKSuccessNoResultAction) {
        
    }
    
    //更新订单确认页面的相关信息
    class func updateOrder(orderConfirm : MKOrderConfirm,_ checkoutType : MKOrderCheckOutType,_ action : MKOrderModifySureAction) {
        
    }
    
    //评价
    class func submitOrderComment(parametes : [String : AnyObject],action : MKOrderCommonAction) {
    
    }
    
    //物流信息
    class func getOrderLogisticInfo(orderSn : String,action : MKCommentOrderAction) {
        
    }
    
    //订单支付方式
    class func getOrderPayList(action : MKCommentOrderAction) {
        
    }
}


















