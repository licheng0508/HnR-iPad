//
//  LLSigninManageSuccessView.swift
//  HnR
//
//  Created by licheng on 2017/8/16.
//  Copyright © 2017年 licheng. All rights reserved.
//

import UIKit

class LLSigninManageSuccessView: UIView {

   
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
    
    /// 关闭按钮点击
    @IBAction func closeBtnClick() {
        
        maskViewTap.removeFromSuperview()
        self.removeFromSuperview()
    }
    
    /// 初始化view
    private func setupView(){
        
        bounds = CGRect(x: 0, y: 0, width: 705, height: 545)
        center = maskViewTap.center
        maskViewTap.addSubview(self)
        
        //添加代理
        maskViewTap.myDelegate = self
        
        //注册cell
//        let cellNib = UINib(nibName: "LLSigninManageCourseCell", bundle: nil)
//        collectionView.register(cellNib, forCellWithReuseIdentifier: "LLSigninManageCourseCell")
        
        // 添加动画
        self.transform = CGAffineTransform(scaleX: CGFloat.leastNormalMagnitude, y: CGFloat.leastNormalMagnitude)
        UIView.animate(withDuration: 0.25) {
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
    
    // MARK: - 外部调用方法
    
    /// load view from xib
    class func loadViewFfromNib() -> LLSigninManageSuccessView {
        
        let nib = UINib(nibName: "LLSigninManageSuccessView", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil).first as! LLSigninManageSuccessView
        return view
    }

}

// MARK: - maskView代理
extension LLSigninManageSuccessView: LLMaskViewDelegate
{
    // 遮罩点击
    func maskViewClick(_ view: LLMaskView) {
        
        view.removeFromSuperview()
        self.removeFromSuperview()
    }
}
