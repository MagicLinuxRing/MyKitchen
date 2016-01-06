//
//  MKBaseDataManager.swift
//  MyKitchen
//
//  Created by wochu on 16/1/6.
//  Copyright © 2016年 @Wochu. All rights reserved.
//

import UIKit

typealias MKDoneAction = (error : NSError?) ->()

class MKBaseDataManager: MKObject {
    
    var items = Array<AnyObject>?()
    var sinceID : Int64?
    var maxID : Int64?
    private var internalPageCount : NSInteger = 0
    internal var pageCount : NSInteger{
        get{
            if internalPageCount == 0 {
                return 20
            }
            return internalPageCount
        }
        set{ internalPageCount = newValue}
    }
    var page : NSInteger = 0
    
    
    private(set) var lastPackageCount : NSInteger?
    
    func refresh(action : MKDoneAction){
        self.lastPackageCount = 0
        self.sinceID = 0
        self.maxID = 0
        self.page = 1
        self.loadMore(1, action: action)
    }
    
    func numberOfSections() -> NSInteger{
        return 1
    }
    
    func numberOfItemOrRowsInSection(section : NSInteger) ->NSInteger{
        return items!.count
    }
    
    func elementForIndexPath(indexPath : NSIndexPath) ->AnyObject?{
        var item : AnyObject?
        if indexPath.row >= self.items?.count{
            print("out of index")
        }
        else{
            item = self.items![indexPath.row]
        }
        return item
    }
    
    func loadMore(page : NSInteger,count : NSInteger,action : MKDoneAction){
        self.page = page
    }
    
    func loadMore(page : NSInteger,action : MKDoneAction){
        self.loadMore(page, count: self.pageCount, action: action)
    }
    
    func updateIDs(){
        if self.items?.count > 0{
            self.sinceID = (self.items?.first as! MKBaseModel).ID
            self.maxID = (self.items?.last as! MKBaseModel).ID
        }
    }
    
    func setLastPackageCount(count : NSInteger){
        self.lastPackageCount = count
    }
    
    func isEmpty() -> Bool{
        return self.items?.count == 0
    }
}




































