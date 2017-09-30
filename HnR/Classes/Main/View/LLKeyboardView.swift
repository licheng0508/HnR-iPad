//
//  LLKeyboardView.swift
//  HnR
//
//  Created by licheng on 2017/8/17.
//  Copyright © 2017年 licheng. All rights reserved.
//

import UIKit

class LLKeyboardView: UIView {

    // MARK: - 重写方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        creatKetboardNotifacation()
    }
    
    // 通过xib创建
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        creatKetboardNotifacation()
    }
    
    // 界面消失
    deinit {
        // 移除通知
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - 私有方法
    
    /// 创建键盘通知
    private func creatKetboardNotifacation() {
        
        //监听键盘事件
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(note:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHidden(note:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    // MARK: - 公共方法

    // 键盘出现
    @objc func keyboardWillShow(note: NSNotification) {
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
    @objc func keyboardWillHidden(note: NSNotification) {
        
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

}
