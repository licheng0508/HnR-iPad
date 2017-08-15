//
//  LLInputAlertView.swift
//  HnR
//
//  Created by licheng on 2017/8/3.
//  Copyright © 2017年 licheng. All rights reserved.
//

import UIKit

/// 代理
protocol LLInputAlertViewDelegate: NSObjectProtocol{
    
    func inputAlertViewSucess(_ view: LLInputAlertView, viewtype: viewType)
}

enum viewType: Int {
    
    /// 取消签到
    case viewTypeCancelSignin = 0
    /// 取消签出
    case viewTypeCancelSignout = 3
    /// 退出界面
    case viewTypeExitView = 99
}

class LLInputAlertView: UIView {

    // MARK: - 参数
    
    /// LLInputAlertViewDelegate
    weak var myDelegate: LLInputAlertViewDelegate?
    
    /// 标题
    @IBOutlet weak var titleLabel: UILabel!
    /// 密码输入框
    @IBOutlet weak var inputPassWordText: UITextField!
    
    /// 界面类型
    var viewType: viewType = .viewTypeCancelSignin{
    
        didSet{
            var title = ""
            switch viewType {
            case .viewTypeCancelSignin:
                title = "请输入密码取消签到"
            case .viewTypeCancelSignout:
                title = "请输入密码取消签出"
            case .viewTypeExitView:
                title = "请输入密码退出"
            }
            titleLabel.text = title
        }
    }
    /// 数据源
    var model: LLSigninModel?
    /// 取消签出课程id
    var courseModel: LLCourseChildModel?
    
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
        
        //监听键盘事件
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(note:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHidden(note:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    // 界面消失
    deinit {
        // 移除通知
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - 按钮点击
    
    /// 取消按钮点击
    @IBAction func cacelBtnClick() {
        
        self.removeFromSuperview()
        maskViewTap.removeFromSuperview()
    }
    
    /// 确定按钮点击
    @IBAction func sureBtnClick() {
        
        guard let passWord = inputPassWordText.text else {
            return
        }
        if passWord.characters.count == 0 {//没有输入密码
            return
        }
        // 收起键盘
        self.endEditing(true)
        
        // 校验密码接口
        getExitCurrentViewData(passWord: passWord)
    }
    
    // MARK: - 私有方法
    
    /// 校验密码接口
    private func getExitCurrentViewData(passWord: String) {
        
        
        let paramsDic = ["userId": UserAccount.getUserAccountUserId(),
                         "password": passWord
        ]
        HnRNetWorkTool.getUserPassWordValidateData(parameters: paramsDic) { (result) in
            
            if result.status{
                
                if self.viewType == .viewTypeExitView {// 退出界面
                    self.getDataSuccessBack()
                }else if self.viewType == .viewTypeCancelSignin{// 取消签到
                    self.getSignCancelData()
                }else if self.viewType == .viewTypeCancelSignout{// 取消签出
                    self.getSignOutCancelData()
                }
            }
        }
    }
    
    // 取消签到
    private func getSignCancelData() {
                
        var userCourseIds: [String] = []
        
        if let courseList = model?.courseList {
            for courseModel: LLCourseListModel in courseList{
                if let userCourseId = courseModel.userCourseId {
                    userCourseIds.append(userCourseId)
                }
            }
        }
        let paramsDic = ["userId": UserAccount.getUserAccountUserId(),
                         "type": viewType.rawValue,
                         "userCourseIds": userCourseIds
            ] as [String : Any]
        
        HnRNetWorkTool.getUserSignInWayData(parameters: paramsDic) { (result) in
            
            if result.status{
                self.getDataSuccessBack()
            }
        }
    }
    
    // 取消签出
    private func getSignOutCancelData() {
        
        guard let childId = courseModel?.childId, let startTime = courseModel?.startTime else {
            return
        }
        
        let paramsDic = ["userId": UserAccount.getUserAccountUserId(),
                         "type": viewType.rawValue,
                         "childId": childId,
                         "startTime": startTime
            ] as [String : Any]
        
        HnRNetWorkTool.getUserSignOutWayData(parameters: paramsDic) { (result) in
            
            if result.status{
                self.getDataSuccessBack()
            }
        }
    }

    /// 获取数据成功返回
    private func getDataSuccessBack() {
        
        self.cacelBtnClick()
        self.myDelegate?.inputAlertViewSucess(self, viewtype: viewType)
    }
    
    /// 初始化view
    private func setupView(){
        
        self.bounds = CGRect(x: 0, y: 0, width: 590, height: 280)
        self.center = maskViewTap.center
        maskViewTap.addSubview(self)
        
        //添加代理
        maskViewTap.myDelegate = self
        
        // 添加动画
        self.transform = CGAffineTransform(scaleX: CGFloat.leastNormalMagnitude, y: CGFloat.leastNormalMagnitude)
        
        UIView.animate(withDuration: 0.25, animations: { 
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }) { (result) in
            //自动调取键盘
            self.inputPassWordText.becomeFirstResponder()
        }
    }
    
    // MARK: - 公共方法
    
    // 键盘出现
    func keyboardWillShow(note: NSNotification) {
        let userInfo = note.userInfo!
        let  keyBoardBounds = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        let deltaY = getMainScreenHeight() - keyBoardBounds.size.height
        let transY = (deltaY - self.frame.maxY) > 0 ? 0 : (deltaY - self.frame.maxY)
        
        let animations:(() -> Void) = {
            //键盘的偏移量
            self.transform = CGAffineTransform(translationX: 0 , y: transY)
        }
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))
            
            UIView.animate(withDuration: duration, delay: 0, options:options, animations: animations, completion: nil)
            
        }else{
            animations()
        }
    }
    
    // 键盘隐藏
    func keyboardWillHidden(note: NSNotification) {
        
        let userInfo  = note.userInfo!
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        let animations:(() -> Void) = {
            //键盘的偏移量
            self.transform = CGAffineTransform.identity
        }
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))
            
            UIView.animate(withDuration: duration, delay: 0, options:options, animations: animations, completion: nil)
        }else{
            animations()
        }
    }
    
    // MARK: - 外部调用方法
    
    /// load view from xib 0.取消签到 3.取消签出 99.退出
    class func loadViewFfromNib(delegate: LLInputAlertViewDelegate? = nil, viewtype: viewType) -> LLInputAlertView {
        
        let nib = UINib(nibName: "LLInputAlertView", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil).first as! LLInputAlertView
        view.myDelegate = delegate
        view.viewType = viewtype
        return view
    }
}

// MARK: - UITextFieldDelegate代理
extension LLInputAlertView: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 确定按钮点击
        sureBtnClick()
        return true
    }
}

// MARK: - maskView代理
extension LLInputAlertView: LLMaskViewDelegate
{
    // 遮罩点击
    func maskViewClick(_ view: LLMaskView) {
        
       self.endEditing(true)
    }
}
