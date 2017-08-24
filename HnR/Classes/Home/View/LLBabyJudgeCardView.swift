//
//  LLBabyJudgeCardView.swift
//  HnR
//
//  Created by licheng on 2017/8/24.
//  Copyright © 2017年 licheng. All rights reserved.
//

import UIKit

class LLBabyJudgeCardView: UIView {
    
    // MARK: - 变量
    
    /// collectionView
    @IBOutlet weak var collectionView: UICollectionView!
    
    /// cellID
    let Baby_Judge_Card_Cell = "LLBabyJudgeCardCell"
    
    
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

    /// 初始化view
    private func setupView(){
        
        bounds = CGRect(x: 0, y: 0, width: 803, height: 602)
        center = maskViewTap.center
        maskViewTap.addSubview(self)
        
        //添加代理
        maskViewTap.myDelegate = self
        
        //注册cell
        let cellNib = UINib(nibName: Baby_Judge_Card_Cell, bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: Baby_Judge_Card_Cell)
        
        // 添加动画
        transform = CGAffineTransform(scaleX: CGFloat.leastNormalMagnitude, y: CGFloat.leastNormalMagnitude)
        UIView.animate(withDuration: 0.25) {
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
    
    // MARK: - 外部调用方法
    
    /// load view from xib
    class func loadViewFfromNib() -> LLBabyJudgeCardView {
        
        let nib = UINib(nibName: "LLBabyJudgeCardView", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil).first as! LLBabyJudgeCardView
        return view
    }

}

// MARK: - 代理、数据源方法
extension LLBabyJudgeCardView: UICollectionViewDelegate, UICollectionViewDataSource
{
    
    /// item个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 12
    }
    
    /// 返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Baby_Judge_Card_Cell, for: indexPath) as! LLBabyJudgeCardCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        LLPrint(indexPath)
    }
    
}

// MARK: - maskView代理
extension LLBabyJudgeCardView: LLMaskViewDelegate
{
    // 遮罩点击
    func maskViewClick(_ view: LLMaskView) {
        
        view.removeFromSuperview()
        self.removeFromSuperview()
    }
}

