//
//  MkBaseTabBarViewController.swift
//  MyKitchen
//
//  Created by wochu on 15/12/16.
//  Copyright © 2015年 @Wochu. All rights reserved.
//

import UIKit

class MkBaseTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = MKViewControllerManager.viewControllers() as! [MKBaseNavViewController]
        
        let imageNames : NSArray = [String](arrayLiteral: "tabBar_button_home_nselected","tabBar_button_classification_nselected","tabBar_button_shopping_nselected","tabBar_button_center_nselected")
        let selectedImageNames : NSArray = [String](arrayLiteral: "tabBar_button_home_default","tabBar_button_classific_default","tabBar_button_shopping_default","tabBar_button_center_default")
        
        let tabBarTitles : NSArray = [String](arrayLiteral: "首页","分类","购物车","订单")
    
        for var index = 0 ; index < self.viewControllers?.count ; ++index{
            let navVC : MKBaseNavViewController = self.viewControllers![index] as! MKBaseNavViewController
            
            let VC : UIViewController = navVC.viewControllers[0]
            VC.title = tabBarTitles[index] as? String
            VC.tabBarItem = UITabBarItem.init(title: VC.title, image: UIImage(named: imageNames[index] as! String), selectedImage: UIImage(named: selectedImageNames[index] as! String))
        }
        self.tabBar.tintColor = RGB(86, G: 186, B: 66, alpha: 1.0)
        self.tabBar.selectedImageTintColor = RGB(86, G: 186, B: 66, alpha: 1.0)
        self.selectedIndex = 0;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func select(sender: AnyObject?) {
        super.select(sender);
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
