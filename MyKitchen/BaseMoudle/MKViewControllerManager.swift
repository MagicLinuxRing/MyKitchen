//
//  MKViewControllerManager.swift
//  MyKitchen
//
//  Created by wochu on 15/12/16.
//  Copyright © 2015年 @Wochu. All rights reserved.
//

import UIKit

class MKViewControllerManager: MKObject {

    class func viewControllers() -> NSArray
    {
        let homePage : UIViewController = MKLoaderViewManager.homePageViewController.instantiateInitialViewController()!
        let filterPage : UIViewController = MKLoaderViewManager.filterStoryBoard.instantiateInitialViewController()!
        let cartsPage : UIViewController = MKLoaderViewManager.cartsStoryBoard.instantiateInitialViewController()!
        let personalPage : UIViewController = MKLoaderViewManager.orderStoryBoard.instantiateInitialViewController()!
        return [UIViewController](arrayLiteral: homePage,filterPage,cartsPage,personalPage)
    }
    
    
}
