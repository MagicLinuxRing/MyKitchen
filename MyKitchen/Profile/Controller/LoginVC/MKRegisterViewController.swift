//
//  MKRegisterViewController.swift
//  MyKitchen
//
//  Created by wochu on 15/12/21.
//  Copyright © 2015年 @Wochu. All rights reserved.
//

import UIKit

class MKRegisterViewController: MKBaseViewController,UITextFieldDelegate {

    @IBOutlet weak var mSwitch: UISwitch!
    @IBOutlet weak var uuCodeButton: UIButton!
    @IBOutlet weak var uuCodeTextField: UITextField!
    @IBOutlet weak var mScrollView: UIScrollView!
    @IBOutlet weak var getVerifyCodeButton: UIButton!
    @IBOutlet weak var phoneNumTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var verifyCodeTextField: UITextField!
    @IBOutlet weak var inputVisitorTextField: UITextField!
    @IBOutlet var mRegisterManager: MKRegisterDataManager!
    
    var uuid : String?
    var timeIndex : NSInteger = 0
    var timer : NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.getUUCodeImage()
    }
    
    func setUpUI(){
        self.phoneNumTextField.maxLength = 11
        self.phoneNumTextField.digitsCharts = ["0","1","2","3","4","5","6","7","8","9"]
        self.passwordTextField.maxLength = 20
        self.uuCodeTextField.maxLength = 20
        self.uuCodeTextField.delegate = self
        self.getVerifyCodeButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.getVerifyCodeButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        self.getVerifyCodeButton.layer.borderWidth = 1.2
        self.getVerifyCodeButton.layer.cornerRadius = 3.0
        self.getVerifyCodeButton.enabled = false
        self.mSwitch.on = false
        self.passwordTextField.secureTextEntry = true
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    func getUUCodeImage(){
        self.uuid = MKGlobalHeader.getUUID()
        let codeImageUrl = MKBaseWebService.baseURL() + "Common/Captcha.aspx?Id=" + self.uuid!
        let mainQueue = dispatch_get_main_queue()
        let globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        dispatch_async(globalQueue) { () -> Void in
            let data : NSData = NSData(contentsOfURL: NSURL(string: codeImageUrl)!)!
            dispatch_async(mainQueue, { () -> Void in
                self.uuCodeButton.setBackgroundImage(UIImage(data: data), forState: UIControlState.Normal)
            })
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField.isKindOfClass(self.uuCodeTextField.classForCoder){
            if self.uuCodeTextField.text?.length > 0 {
                self.getVerifyCodeButton.layer.borderColor = MKGlobalHeader.defaultInstance().originColor!.CGColor
                self.getVerifyCodeButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
                self.getVerifyCodeButton.enabled = true
            }
            else{
                self.getVerifyCodeButton.layer.borderColor = UIColor.lightGrayColor().CGColor
                self.getVerifyCodeButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
                self.getVerifyCodeButton.enabled = false
            }
        }
        return true
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapClick(sender: AnyObject) {
        let resourcePath = NSBundle.mainBundle().resourcePath
        let filePath = resourcePath?.stringByAppendingString("/wochu_use_agreement.htm")
        let url = NSURL.fileURLWithPath(filePath!)
        
    }
    
    @IBAction func doRegisterAndLoginAction(sender: AnyObject) {
        self.passwordTextField.resignFirstResponder()
        if !self.doVerifyInputFormat() {return}
        RSProgressHUD.show()
        self.mRegisterManager.getRegisterModel(self.phoneNumTextField.text!, self.passwordTextField.text!, self.verifyCodeTextField.text!, "11", self.getCurrentString(inputVisitorTextField.text!) , self.uuid!, self.uuCodeTextField.text!) { (registerModel, error) -> () in
            run({ () -> Void in
                RSProgressHUD.dismiss()
                if error != nil {
                    self.view.makeToast(error?.localizedDescription, duration: 0.5, position: "bottom")
                }
                else{
                    self.view.makeToast(registerModel?.message, duration: 0.5, position: "bottom")
                    if registerModel?.guid.length > 0 {
                        self.login()
                    }
                }
            })
        }
    }
    
    func login(){
        self.phoneNumTextField.resignFirstResponder()
        RSProgressHUD.showWithStatus("登录中")
        weak var weakself : MKRegisterViewController! = self
        self.mRegisterManager.getLogin(self.phoneNumTextField.text!, self.passwordTextField.text!, "", "") { (loginModel, error) -> () in
            run({ () -> Void in
                RSProgressHUD.dismiss()
                
                if error != nil{
                    RSProgressHUD.showErrorWithStatus(error?.errorDescription())
                }
                else{
                    if loginModel?.access_token != nil && loginModel?.access_token?.length > 0
                    {
                        weakself.appGlobal?.saveLoginUser(["phone":weakself.phoneNumTextField.text!,"password":weakself.passwordTextField.text!])
                        weakself.appGlobal?.setLoginInfoData(loginModel?.access_token)
                        RSProgressHUD.showErrorWithStatus("登录成功")
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(0.5*(Double)(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
                            weakself.navigationController?.popToRootViewControllerAnimated(true)
                        })
                    }
                    else{
                        weakself.view.makeToast(error?.errorDescription(), duration: 0.5, position: "bottom")
                    }
                }
            })
        }
    }
    
    func getCurrentString(stringSource : String) ->String{
        if stringSource.length > 0{
            return stringSource
        }
        return ""
    }
    
    @IBAction func getVerifyCodeAction(sender: AnyObject) {
        self.uuCodeTextField.resignFirstResponder()
        
        if  self.uuCodeTextField.text?.length == 0 {
            self.view.makeToast("请输入图片验证码", duration: 0.5, position: "bottom")
            return
        }
        if self.phoneNumTextField.text?.length == 0 {
            self.view.makeToast("请输入手机号", duration: 0.5, position: "bottom")
            return
        }
        if self.phoneNumTextField.text?.length != 11 {
            self.view.makeToast("请输入正确的手机号", duration: 0.5, position: "bottom")
            return
        }
        MKLoginManager.getMemberCapchCodeWithUUId(self.uuid!, self.uuCodeTextField!.text!) { (isSuccess, error) -> () in
            if error != nil{
                self.view.makeToast(error?.localizedDescription, duration: 0.6, position: "bottom")
            }
            else{
                if isSuccess {
                    self.requestRegisterVerifyCode()
                }
            }
        }
    }
    
    func requestRegisterVerifyCode(){
        self.mRegisterManager.getRegisterVerifyCode(self.phoneNumTextField.text!) { (registerModel, error) -> () in
            run({ () -> Void in
                if error != nil {
                    print("\(error?.localizedDescription)")
                }
                else{
                    self.view.makeToast(registerModel?.message, duration: 0.6, position: "bottom")
                }
            })
        }
    }
    
    func startTimer(){
        if self.timer != nil{
            self.timer?.invalidate()
            self.timer = nil
        }
        self.timeIndex = 60
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "timerFireMethod:", userInfo: nil, repeats: true)
        self.getVerifyCodeButton.enabled = false
    }
    
    func stopTimer(){
        if self.timer != nil{
            self.timer?.invalidate()
            self.timer = nil
        }
    }
    
    func timerFireMethod(sender : AnyObject?){
        self.timeIndex--
        if self.timeIndex == 0 {
            self.getVerifyCodeButton.setTitle("重新获取", forState: UIControlState.Normal)
            self.getVerifyCodeButton.enabled = true
            self.stopTimer()
        }
        else{
            self.getVerifyCodeButton.titleLabel?.text = ""
            self.getVerifyCodeButton.setTitle("重新获取\(self.timeIndex)", forState: UIControlState.Normal)
            if  (UIDevice.currentDevice().systemVersion as NSString).floatValue < 8.0{
                self.getVerifyCodeButton.setTitle("重新获取\(self.timeIndex)", forState: UIControlState.Normal)
            }
        }
    }

    @IBAction func uuCodeButtonAction(sender: AnyObject) {
        self.getUUCodeImage()
        self.uuCodeTextField.text = ""
    }
    
    @IBAction func doSwitch(sender: AnyObject) {
        let tempSwitch = sender as! UISwitch
        self.passwordTextField.secureTextEntry = !tempSwitch.on
    }
    
    func doVerifyInputFormat() ->Bool{
        var isRight = true
        
        if self.uuCodeTextField.text?.length == 0 {
            self.view.makeToast("请输入图片验证码", duration: 0.5, position: "bottom")
            isRight = false
        }
        if self.phoneNumTextField.text?.length == 0 {
            self.view.makeToast("请输入手机号", duration: 0.5, position: "bottom")
            isRight = false
        }
        if self.phoneNumTextField.text?.length != 11 {
            self.view.makeToast("请输入正确的手机号", duration: 0.5, position: "bottom")
            isRight = false
        }
        if self.verifyCodeTextField.text?.length == 0 {
            self.view.makeToast("请输入验证码", duration: 0.5, position: "bottom")
            isRight = false
        }
        if self.passwordTextField.text?.length == 0 {
            self.view.makeToast("请输入密码", duration: 0.5, position: "bottom")
            isRight = false
        }
        if self.passwordTextField.text?.length < 6 {
            self.view.makeToast("请输入至少6位密码", duration: 0.5, position: "bottom")
            isRight = false
        }
        return isRight
    }

}
