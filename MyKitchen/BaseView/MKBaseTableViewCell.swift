//
//  MKBaseTableViewCell.swift
//  MyKitchen
//
//  Created by wochu on 16/1/12.
//  Copyright © 2016年 @Wochu. All rights reserved.
//

import UIKit

class MKBaseTableViewCell: UITableViewCell {
    var element : AnyObject?
    
    class func renderCell(cell : MKBaseTableViewCell,tableView : UITableView,indexPath : NSIndexPath,element : AnyObject) -> UITableViewCell{
        return cell
    }
    
    class func cellHeight(cell : MKBaseTableViewCell,tableView : UITableView,indexPath : NSIndexPath,element : AnyObject) -> CGFloat{
        return 44.0
    }
}
