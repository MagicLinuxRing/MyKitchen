//
//  MKLoginViewController.swift
//  MyKitchen
//
//  Created by wochu on 15/12/21.
//  Copyright © 2015年 @Wochu. All rights reserved.
//

import UIKit

class MKLoginViewController: MKBaseViewController {
    
    typealias NULLBlock = ()->()

    @IBOutlet weak var accountTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    internal var gobackAction : NULLBlock?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setButtonType()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.enabled = false
    }
    
    func setButtonType(){
        self.registerBtn.becomeEllopseViewWithBorderColor(RGB(236.0, G: 105.0, B: 41.0,alpha: 1.0), 1.2, 0)
        self.accountTextField.setMaxLength(11)
        self.passwordTextField.setMaxLength(22)
        self.accountTextField.setDigitsCharts(["0","1","2","3","4","5","6","7","8","9"])
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.enabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(sender: AnyObject) {
        if self.gobackAction != nil {
            self.gobackAction!()
        }
        else{
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    @IBAction func doRegisterAction(sender: AnyObject) {
        self.setTextFieldResignFirstResponder()
        self.performSegueWithIdentifier("MKRegisterVC", sender: self)
    }
    
    @IBAction func doFindPasswordAction(sender: AnyObject) {
        self.setTextFieldResignFirstResponder()
        self.performSegueWithIdentifier("MKFindPasswordVC", sender: self)
    }

    @IBAction func doLoginAction(sender: AnyObject) {
        self.setTextFieldResignFirstResponder()
        
        let isCheckwork = MKGlobalHeader.defaultInstance().checkNetworkState()
        if  !isCheckwork {
            RSProgressHUD.showErrorWithStatus("请连接网络")
            return
        }
        
        if !self.doVerifyInputFormat() {
            return;
        }
        
        RSProgressHUD.showWithStatus("登录中")
        weak var weakself : MKLoginViewController? = self
        MKLoginManager.getLoginWithAccount(self.accountTextField.text!, self.passwordTextField.text!, nil, nil) { (loginModel : MKLoginModel?, error : NSError?) -> () in
            if error != nil {
                RSProgressHUD.showWithStatus(error?.errorDescription())
            }
            else{
                if loginModel?.access_token?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) != 0 {
                    weakself?.appGlobal?.saveLoginUser(["phone":(weakself?.accountTextField.text!)!,"password":(weakself?.passwordTextField.text!)!])
                    weakself?.appGlobal?.setLoginInfoData(loginModel?.access_token)
                    RSProgressHUD.showWithStatus("登录成功")
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(0.5*(Double)(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
                        weakself?.navigationController?.popToRootViewControllerAnimated(true)
                    })
                }
                else{
                    RSProgressHUD.showWithStatus("用户名或者密码不正确")
                }
            }
        }
    }
    
    func setTextFieldResignFirstResponder(){
        self.accountTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.setTextFieldResignFirstResponder()
    }
    
    func doVerifyInputFormat() -> Bool {
        var isRight = true
        if self.accountTextField.text!.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0 {
            self.view.makeToast("请输入账号", duration: 0.5, position: "bottom")
            isRight = false
        }
        else{
            if self.accountTextField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) != 11 {
                self.view.makeToast("请输入正确的账号", duration: 0.5, position: "bottom")
                isRight = false
            }
            else{
                if self.passwordTextField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0  {
                    self.view.makeToast("请输入密码", duration: 0.5, position: "bottom")
                    isRight = false
                }
                else{
                    if self.passwordTextField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) < 6 {
                        self.view.makeToast("请输入至少6位密码", duration: 0.5, position: "bottom")
                        isRight = false
                    }
                }
            }
        }
        return isRight
    }
    
    func setGoBackAction(action : NULLBlock?){
        if action != nil {
            self.gobackAction = action
        }
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
