//
//  LLSigninManageSuccessView.swift
//  HnR
//
//  Created by licheng on 2017/8/16.
//  Copyright © 2017年 licheng. All rights reserved.
//

import UIKit

class LLSigninManageSuccessView: UIView {

    // MARK: - 参数
    
    /// 背景view
    @IBOutlet weak var bgView: UIView!
    /// collectionView
    @IBOutlet weak var collectionView: UICollectionView!
    /// page
    @IBOutlet weak var pageControlView: UIPageControl!
    
    /// 数据源
    var model: LLSigninModel?
    {
        
        didSet{
            
            pageControlView.numberOfPages = model?.courseList?.count ?? 0
           
            //刷新列表
            collectionView.reloadData()
            
        }
    }
   
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
        
        //添加阴影
        bgView.layer.shadowOpacity = 0.8
        bgView.layer.shadowColor = UIColor.lightGray.cgColor
        bgView.layer.shadowOffset = CGSize(width: 1, height: 1)
        bgView.layer.shadowRadius = 5
        bgView.layer.cornerRadius = 10
        
        bounds = CGRect(x: 0, y: 0, width: 705, height: 545)
        center = maskViewTap.center
        maskViewTap.addSubview(self)
        
        //添加代理
        maskViewTap.myDelegate = self
        
        //注册cell
        let cellNib = UINib(nibName: "LLSigninManageSuccessCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "LLSigninManageSuccessCell")
        
        // 添加动画
        transform = CGAffineTransform(scaleX: CGFloat.leastNormalMagnitude, y: CGFloat.leastNormalMagnitude)
        UIView.animate(withDuration: 0.25) {
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            
            //添加一个5秒延迟操作
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
                // 你想做啥
                self.closeBtnClick()
            }
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

// MARK: - 代理、数据源方法
extension LLSigninManageSuccessView: UICollectionViewDelegate, UICollectionViewDataSource
{
    
    /// item个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return model?.courseList?.count ?? 0
    }
    
    /// 返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LLSigninManageSuccessCell", for: indexPath) as! LLSigninManageSuccessCell
        
        cell.model = model?.courseList?[indexPath.item]
        
        return cell
    }
    
    /// 滚动
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let width = collectionView.bounds.size.width
        let scrollX = scrollView.contentOffset.x
        
        let page = Int(scrollX/width + 0.5)
        
        pageControlView.currentPage = page
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
