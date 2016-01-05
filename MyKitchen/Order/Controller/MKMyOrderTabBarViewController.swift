//
//  MKMyOrderTabBarViewController.swift
//  MyKitchen
//
//  Created by wochu on 15/12/18.
//  Copyright © 2015年 @Wochu. All rights reserved.
//

import UIKit

class MKMyOrderTabBarViewController: MKListTabBarViewController,MKListTabBarControllerDelegate {

    var orderStatus : MKOrderStatus?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if !MKGlobalHeader.defaultInstance().isLogin(){
            let loginVC = MKLoaderViewManager.loginViewController()
            self.navigationController!.pushViewController(loginVC, animated: true)
        }
    }
    
    override func viewDidLoad() {
        let titles : Array<String> = ["全部","待付款","待收货","待评价"]
        var vcSlice : Array<UIViewController> = []
        for var index = 0; index < titles.count; index++ {
            let orderVC : MKOrderViewController = MKLoaderViewManager.myOrderViewController()
            orderVC.title = titles[index]
            //            orderVC.setTargetOrderStatusType(index)
            //            orderVC.delegate = self
            vcSlice.append(orderVC)
        }
        self.delegate = self
        self.viewListControllers = vcSlice
        self.selectedIndex = 1
        
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mk_tabBarController(tabBarController: MKListTabBarViewController, didSelecteViewController: UIViewController, index: NSInteger) {
        self.selectedIndex = index
    }
    
    func mk_tabBarController(tabBarController: MKListTabBarViewController, shouldSelectedViewController: UIViewController, index: NSInteger) -> Bool {
        return true
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
