//
//  LLSigninManageView.swift
//  HnR
//
//  Created by licheng on 2017/8/1.
//  Copyright © 2017年 licheng. All rights reserved.
//

import UIKit

/// 代理
protocol LLSigninManageViewDelegate: NSObjectProtocol{
    
    func signinManageSucess(_ view: LLSigninManageView)
}

class LLSigninManageView: UIView {
    
    // MARK: - 参数
    
    /// LLSigninManageViewDelegate
    weak var myDelegate: LLSigninManageViewDelegate?
    
    /// 头像
    @IBOutlet weak var headImageView: UIImageView!
    /// 姓名
    @IBOutlet weak var nameLabel: UILabel!
    
    /// collectionView
    @IBOutlet weak var collectionView: UICollectionView!
    /// 页码
    @IBOutlet weak var pageControlView: UIPageControl!
    
    @IBOutlet weak var pageLayoutConstraintHeight: NSLayoutConstraint!
    
    
    /// 数据源
    var model: LLSigninModel?
        {
        
        didSet{
            
            if let headPortrait = model?.headPortrait {//头像有值
                let urlStr = URL(string: headPortrait)
                headImageView.sd_setImage(with: urlStr, completed: nil)
            }else{
                headImageView.image = nil
            }
            
            nameLabel.text = model?.childName
            
            pageControlView.numberOfPages = model?.courseList?.count ?? 0
            pageLayoutConstraintHeight.constant = pageControlView.isHidden ? 0 : 22
            
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
    
    /// 签到按钮点击
    @IBAction func signinBtnClick(_ sender: UIButton) {
        
        // 签到
        getSigninData()
    }
    
    // MARK: - 私有方法
    
    /// 签到
    private func getSigninData() {
        
        var userCourseIds: [String] = []
        if let courseList = model?.courseList {
            for courseModel: LLCourseListModel in courseList{
                if let userCourseId = courseModel.userCourseId {
                    userCourseIds.append(userCourseId)
                }
            }
        }
        let paramsDic = ["userId": UserAccount.getUserAccountUserId(),
                         "type": "1",
                         "userCourseIds": userCourseIds
            ] as [String : Any]
        
        HnRNetWorkTool.getUserSignInWayData(parameters: paramsDic) { (result) in
            
            if result.status{
                
                self.removeMaskViews()
                self.myDelegate?.signinManageSucess(self)
            }
        }
    }
    
    /// 移除遮罩
    private func removeMaskViews() {
        
        self.removeFromSuperview()
        maskViewTap.removeFromSuperview()
    }
    
    /// 初始化view
    private func setupView(){
        
        self.bounds = CGRect(x: 0, y: 0, width: 705, height: 545)
        self.center = maskViewTap.center
        maskViewTap.addSubview(self)
    
        //添加代理
        maskViewTap.myDelegate = self
        
        //注册cell
        let cellNib = UINib(nibName: "LLSigninManageCourseCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "LLSigninManageCourseCell")
        
        // 添加动画
        self.transform = CGAffineTransform(scaleX: CGFloat.leastNormalMagnitude, y: CGFloat.leastNormalMagnitude)
        UIView.animate(withDuration: 0.25) {
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
    
    // MARK: - 外部调用方法
    
    // load view from xib
    class func loadViewFfromNib(delegate: LLSigninManageViewDelegate? = nil) -> LLSigninManageView {
        
        let nib = UINib(nibName: "LLSigninManageView", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil).first as! LLSigninManageView
        view.myDelegate = delegate
        return view
    }

}

// MARK: - 代理、数据源方法
extension LLSigninManageView: UICollectionViewDelegate, UICollectionViewDataSource
{
    
    /// item个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return model?.courseList?.count ?? 0
    }
    
    /// 返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LLSigninManageCourseCell", for: indexPath) as! LLSigninManageCourseCell
        
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
extension LLSigninManageView: LLMaskViewDelegate
{
    // 遮罩点击
    func maskViewClick(_ view: LLMaskView) {
        
        self.removeFromSuperview()
        view.removeFromSuperview()
    }
}
