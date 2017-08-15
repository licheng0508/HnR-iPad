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

class LLInputCodeAlertView: UIView {

    // MARK: - 参数
    
    /// LLInputCodeAlertViewDelegate
    weak var myDelegate: LLInputCodeAlertViewDelegate?
    
    /// 输入框
    @IBOutlet weak var inputCodeView: LLInputCodeView!
    

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
    
    // 键盘出现
    func keyboardWillShow(note: NSNotification) {
        let userInfo = note.userInfo!
        let  keyBoardBounds = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        let deltaY = getMainScreenHeight() - keyBoardBounds.size.height
        let transY = (deltaY - self.frame.maxY) > 0 ? 0 : (deltaY - self.frame.maxY - 15)
        
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
        
        LLPrint(password)
        
    }
}




