//
//  MKOrderViewController.swift
//  MyKitchen
//
//  Created by wochu on 15/12/17.
//  Copyright © 2015年 @Wochu. All rights reserved.
//

import UIKit

class MKOrderViewController: MKBaseTableViewController {
    
    internal var orderStatus : MKOrderStatus?
    internal var order : MKBaseOrder?
    internal var delegate : MKMyOrderViewControllerDelegate?

    @IBOutlet var orderDataManager: MKMyOrderManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor();
        // Do any additional setup after loading the view.
        self.setup()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  (Int64)(0.5*(Double)(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
            RSProgressHUD.showWithStatus("加载中")
        }
        self.refresh()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setup(){
        weak var weakself = self
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { () -> Void in
            weakself!.refresh()
        })
        self.tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: { () -> Void in
            weakself!.loadMore()
        })
        
        self.tableView.backgroundColor = MKGlobalHeader.defaultInstance().backgroundColor
        self.tableView.separatorStyle = .None
    }
    
    func loadMore(){
        weak var weakself = self
        let page = self.page + 1
        self.orderDataManager.loadMore(page) { (error) -> () in
            run({ () -> Void in
                weakself!.tableView.mj_footer.endRefreshing()
                if let error = error {
                    RSProgressHUD.showErrorWithStatus(error.errorDescription())
                }
                else{
                    weakself!.tableView.reloadData()
                    if weakself!.orderDataManager.lastPackageCount > 0 {
                        weakself!.page++
                    }
                }
            })
        }
    }
    
    func refresh(){
        weak var weakself = self
        self.orderDataManager.refresh { (error) -> () in
            run({ () -> Void in
                if let error = error {
                    RSProgressHUD.showErrorWithStatus(error.errorDescription())
                }
                else{
                    weakself!.page = 1
                    weakself!.tableView.reloadData()
                    if weakself!.orderDataManager.isEmpty() {
                        weakself!.tableView.addSubview(weakself!.emptyView!)
                        //TODO::
                    }
                    else{
                        weakself!.emptyView!.removeFromSuperview()
                    }
                }
                RSProgressHUD.dismiss()
                weakself!.tableView.mj_header.endRefreshing()
            })
        }
    }
    
    func setTargetOrderStatusType(orderType : MKOrderStatus){
        self.orderStatus = orderType
        self.orderDataManager.setTargetOrderStatusType(orderType)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orderDataManager.numberOfItemOrRowsInSection(section)
    }
    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        weak var weakself = self
//        
////        return 
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
