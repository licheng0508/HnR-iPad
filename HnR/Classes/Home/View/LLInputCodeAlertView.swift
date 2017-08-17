//
//  LLInputCodeAlertView.swift
//  HnR
//
//  Created by licheng on 2017/8/15.
//  Copyright © 2017年 licheng. All rights reserved.
//

import UIKit

/// 代理
protocol LLInputCodeAlertViewDelegate: NSObjectProtocol{
    
    func inputCodeAlertViewSucess(_ view: LLInputCodeAlertView)
}

class LLInputCodeAlertView: LLKeyboardView {

    // MARK: - 参数
    
    /// LLInputCodeAlertViewDelegate
    weak var myDelegate: LLInputCodeAlertViewDelegate?
    
    /// 输入框
    @IBOutlet weak var inputCodeView: LLInputCodeView!
    
    /// 数据源
    var model: LLSigninModel?
    
    // MARK: - 懒加载
    
    /// maskView
    private lazy var maskViewTap: LLMaskView = {
        return LLMaskView()
    }()
    
    // MARK: - 重写方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    // 通过xib创建
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 初始化view
        setupView()
        
    }
    
    // MARK: - 按钮点击
    
    /// 取消按钮点击
    @IBAction func cacelBtnClick() {
        
        maskViewTap.removeFromSuperview()
        self.removeFromSuperview()
    }
    
    // MARK: - 私有方法
    
    /// 初始化view
    private func setupView(){
        
        bounds = CGRect(x: 0, y: 0, width: 590, height: 280)
        center = maskViewTap.center
        maskViewTap.addSubview(self)
        
        //添加代理
        maskViewTap.myDelegate = self
        inputCodeView.myDelegate = self
        
        // 添加动画
        transform = CGAffineTransform(scaleX: CGFloat.leastNormalMagnitude, y: CGFloat.leastNormalMagnitude)
        
        UIView.animate(withDuration: 0.25, animations: {
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }) { (result) in
            //自动调取键盘
            self.inputCodeView.textField.becomeFirstResponder()
        }
    }
    
    // MARK: - 公共方法

    /// 签到
    func getSigninData(password: String) {
        
        guard let appUserId = model?.userId else {
            return
        }
        var userCourseIds: [String] = []
        if let courseList = model?.courseList {
            for courseModel: LLCourseListModel in courseList{
                if let userCourseId = courseModel.userCourseId {
                    userCourseIds.append(userCourseId)
                }
            }
        }
        let paramsDic = ["userId": UserAccount.getUserAccountUserId(),
                         "appUserId": appUserId,
                         "type": "1",
                         "code": password,
                         "userCourseIds": userCourseIds
            ] as [String : Any]
        
        HnRNetWorkTool.getUserSignInWayData(parameters: paramsDic) { (result) in
            
            guard  result != nil else {
                //添加一个延迟操作
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + HUD_Show_Text_Second) {
                    //自动调取键盘
                    self.inputCodeView.textField.becomeFirstResponder()
                }
                return
            }
            
            if (result?.status)!{
                
                self.cacelBtnClick()
                self.myDelegate?.inputCodeAlertViewSucess(self)
            }
        }
    }
    
    // MARK: - 外部调用方法
    
    /// load view from xib
    class func loadViewFfromNib(delegate: LLInputCodeAlertViewDelegate? = nil) -> LLInputCodeAlertView {
        
        let nib = UINib(nibName: "LLInputCodeAlertView", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil).first as! LLInputCodeAlertView
        view.myDelegate = delegate
        return view
    }
}

// MARK: - maskView代理
extension LLInputCodeAlertView: LLMaskViewDelegate
{
    // 遮罩点击
    func maskViewClick(_ view: LLMaskView) {
        
        self.endEditing(true)
    }
}

// MARK: - maskView代理
extension LLInputCodeAlertView: LLInputCodeViewDelegate
{
    func inputCodeSuccessView(_ view: LLInputCodeView, password: String) {
        
        // 签到
        getSigninData(password: password)
        
    }
}
