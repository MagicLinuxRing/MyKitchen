//
//  MKWebViewController.swift
//  MyKitchen
//
//  Created by wochu on 16/1/6.
//  Copyright © 2016年 @Wochu. All rights reserved.
//

import UIKit

class MKWebViewController: MKBaseViewController,UIWebViewDelegate {
    
    var webView : UIWebView?
    
    var url : NSURL?
    
    var vcTitle : String?
    
    
    func setTargetUrl(url : NSURL?){
        if url != nil {
            self.url = url
        }
    }
    
    func setTargetVCTitle(VCTitle : String?){
        if  VCTitle != nil {
            self.vcTitle = VCTitle
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        
        if self.vcTitle == nil {
            self.vcTitle = "web界面"
        }
        
        if self.url == nil {
            self.url = NSURL(string: "http://www.wochu.cn")
        }
        
        self.webView = UIWebView(frame: CGRectMake(0,0,UIScreen.mainScreen().bounds.size.width,UIScreen.mainScreen().bounds.size.height))
        self.webView?.delegate = self
        self.view.addSubview(self.webView!)
        
        let request = NSMutableURLRequest(URL: self.url!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 30)
        self.webView?.loadRequest(request)
        RSProgressHUD.show()
    }
    
    deinit{
        self.webView?.delegate = nil
    }
    
    func setup(){
        self.view.backgroundColor = MKGlobalHeader.defaultInstance().backgroundColor
        self.title = "web界面"
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        RSProgressHUD.dismiss()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        RSProgressHUD.dismiss()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
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
