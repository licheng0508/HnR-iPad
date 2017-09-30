//
//  LLUserLoginViewController.swift
//  HnR
//
//  Created by licheng on 2017/7/27.
//  Copyright © 2017年 licheng. All rights reserved.
//

import UIKit

class LLUserLoginViewController: UIViewController {

    // MARK: - 变量
    /// 获取验证码按钮
    @IBOutlet weak var smsCodeBtn: UIButton!
    /// 手机号输入框
    @IBOutlet weak var phoneText: UITextField!
    /// 验证码输入框
    @IBOutlet weak var codeText: UITextField!
    /// 验证码view
    @IBOutlet weak var codeView: UIView!
    
    var timer: Timer?
    var codeTime = 60
    
    // MARK: - 类方法
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //监听键盘事件
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(note:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHidden(note:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    // 界面消失
    deinit {
        // 移除通知
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // 移除定时器
        timer?.invalidate()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //点击屏幕收起键盘
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - 点击事件
    
    /// 登录
    @IBAction func userLoginClick(_ sender: UIButton) {
        
        userLoginData()
    }
    
    /// 获取验证码
    @IBAction func getSmSCodeClick(_ sender: UIButton) {
        
        //点击收起键盘
        self.view.endEditing(true)
        getUserLoginCodeData()
        
    }
    
    // MARK: - 私有方法
    
    /// 用户登录
     private func userLoginData() {
        
        // 守护
        guard let phoneNum = phoneText.text else {
            return
        }
        
        if phoneNum.characters.count == 0 {
            MBProgressHUDShowText("请输入手机号")
            return
        }
        if !phoneNum.isPhoneNum() {
            MBProgressHUDShowText("请输入正确的手机号")
            return
        }
        
        guard let codeNum = codeText.text else {
            return
        }
        if codeNum.characters.count == 0 {
            MBProgressHUDShowText("请输入验证码")
            return
        }
        
        let paramsDic = ["username" : phoneNum,
                         "smsCode" : codeNum
        ]
        HnRNetWorkTool.getUserLoginData(parameters: paramsDic) { (result) in
            
            if let userId = result.userInfo?.userId{//登录成功
                
                UserAccount.saveUserAccount(status: true)
                UserAccount.saveUserAccountUserId(userId)
                
                if let shopName = result.institution?.chineseName{
                    UserAccount.saveUserAccountShopName(shopName)
                }
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: Switch_Root_VC), object: nil)
            }
        }
    }
    
    /// 获取登录验证码
    private func getUserLoginCodeData() {
        
        // 守护
        guard let phoneNum = phoneText.text else {
            return
        }
        if phoneNum.characters.count == 0 {
            MBProgressHUDShowText("请输入手机号")
            return
        }
        if !phoneNum.isPhoneNum() {
            MBProgressHUDShowText("请输入正确的手机号")
            return
        }
        
        let paramsDic = ["phone": phoneNum,
                         "type" : "12"
        ]
        HnRNetWorkTool.getUserLoginSmSCodeData(parameters: paramsDic) { (result) in
            
            if result.status{//获取验证码成功
                
                MBProgressHUDShowText("验证码已发出，请注意查收")
                
                //添加定时器
                self.addCodeTimer()
            }
        }
    }
    
    /// 添加定时器
    private func addCodeTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(codeTimer), userInfo: nil, repeats: true)
        
    }
    
    // MARK: - 公共方法
    
    /// 计时器
    @objc func codeTimer() {
        
        codeTime = codeTime - 1
        
        if codeTime == 0 {//计时结束
            smsCodeBtn.setTitle("获取验证码", for: UIControlState.normal)
            smsCodeBtn.isEnabled = true
            codeTime = 60
            timer?.invalidate()
            
        }else{
            smsCodeBtn.setTitle("剩余 \(codeTime) 秒", for: UIControlState.normal)
            smsCodeBtn.isEnabled = false
        }
    }
    
    // 键盘出现
    @objc func keyboardWillShow(note: NSNotification) {
        let userInfo = note.userInfo!
        let  keyBoardBounds = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        let deltaY = getMainScreenHeight() - keyBoardBounds.size.height
        let transY = (deltaY - codeView.frame.maxY) > 0 ? 0 : (deltaY - codeView.frame.maxY - 5)
        
        
        let animations:(() -> Void) = {
            //键盘的偏移量
            self.view.transform = CGAffineTransform(translationX: 0 , y: transY)
        }
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))
            
            UIView.animate(withDuration: duration, delay: 0, options:options, animations: animations, completion: nil)
            
        }else{
            animations()
        }
    }
    
    // 键盘隐藏
    @objc func keyboardWillHidden(note: NSNotification) {
        
        let userInfo  = note.userInfo!
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        let animations:(() -> Void) = {
            //键盘的偏移量
            self.view.transform = CGAffineTransform.identity
        }
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))
            
            UIView.animate(withDuration: duration, delay: 0, options:options, animations: animations, completion: nil)
        }else{
            animations()
        }
    }
}

// MARK: - UITextFieldDelegate代理
extension LLUserLoginViewController: UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // 只能输入数字
        if !string.isNumber() {
            return false
        }
        return true
    }
}

