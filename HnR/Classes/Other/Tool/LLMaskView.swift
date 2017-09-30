//
//  LLMaskView.swift
//  HnR
//
//  Created by licheng on 2017/8/1.
//  Copyright © 2017年 licheng. All rights reserved.
//

import UIKit

/// 代理
protocol LLMaskViewDelegate: NSObjectProtocol{

    func maskViewClick(_ view: LLMaskView)
}

class LLMaskView: UIView {
    
    /// LLMaskViewDelegate
    weak var myDelegate: LLMaskViewDelegate?
    
    // MARK: - 重写方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 背景颜色
        self.backgroundColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.3)
        
        // 添加点击事件
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapClick))
        tap.delegate = self
        self.addGestureRecognizer(tap)
        
        //添加
        let view = UIApplication.shared.keyWindow
        if  let view = view{
            self.frame = view.bounds
            view.addSubview(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 页面点击
    /// 点击view
    @objc func tapClick(){
        
       myDelegate?.maskViewClick(self)
    
    }
}

// MARK: - UIGestureRecognizerDelegate
extension LLMaskView: UIGestureRecognizerDelegate
{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        return (touch.view?.isEqual(self))!
    }
    
}
