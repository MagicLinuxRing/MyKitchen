//
//  MKBaseViewController.swift
//  MyKitchen
//
//  Created by wochu on 15/12/16.
//  Copyright © 2015年 @Wochu. All rights reserved.
//

import UIKit

class MKBaseViewController: UIViewController {
    
    var page : NSInteger = 0
    var appGlobal : MKGlobalHeader?
    
    var emptyView : UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.page = 1;
        self.appGlobal = MKGlobalHeader.defaultInstance()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        RSProgressHUD.dismiss()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
