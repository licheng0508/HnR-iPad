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
    
    var timer: Timer?
    var codeTime = 60
    
    // MARK: - 类方法
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        
        //加载框
        MBProgressHUDShowNetWorkLoading("登录中...")
        
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
        //加载框
        MBProgressHUDShowNetWorkLoading()
        
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
    
    /// 计时器
    func codeTimer() {
        
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
}
