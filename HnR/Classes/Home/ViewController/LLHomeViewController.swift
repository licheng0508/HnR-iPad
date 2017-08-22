//
//  LLHomeViewController.swift
//  HnR
//
//  Created by licheng on 2017/7/21.
//  Copyright © 2017年 licheng. All rights reserved.
//

import UIKit

class LLHomeViewController: UIViewController {
    
    // MARK: - 变量

    /// 店名
    @IBOutlet weak var shopNameLabel: UILabel!
    /// 头部图片
    @IBOutlet weak var headImageView: UIImageView!
    /// collectionView
    @IBOutlet weak var collectionView: UICollectionView!
    
    /// cellID
    let Home_List_Cell = "LLHomeListCell"
    
    
    /// 数据源
    var dataArray: [LLHomeLatticeModel]?{
        
        didSet{
            //刷新数据
            collectionView.reloadData()
        }
    }
    
    // MARK: - 类方法
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shopNameLabel.text = UserAccount.getUserAccountShopName()
        
        // 注册cell
        let cellNib = UINib(nibName: Home_List_Cell, bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: Home_List_Cell)
        
        // 获取数据
        getHomeData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - 私有方法
    
    /// 获取首页数据
    private func getHomeData(){
                
        let paramsDic = ["userId" : UserAccount.getUserAccountUserId()]
        
        HnRNetWorkTool.getHomeListData(parameters: paramsDic) { (result) in
            
            self.dataArray = result.latticeList
            
        }
    }
}

// MARK: - 代理、数据源方法
extension LLHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource
{

    /// item个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray?.count ?? 0
    }
    
    /// 返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Home_List_Cell, for: indexPath) as! LLHomeListCell
        
        cell.model = self.dataArray?[indexPath.item]
        
        return cell
    }
    
    /// 点击cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let model = self.dataArray?[indexPath.item] {
            
            if model.sequence == SequenceType.sequenceTypeSigninManage {//签到管理
               
                let signinManageVC = LLSigninManageViewController(nibName: "LLSigninManageViewController", bundle: nil)
                self.navigationController?.pushViewController(signinManageVC, animated: true)
                                
            }else if model.sequence == SequenceType.sequenceTypeCourseManage {//课程管理
                
                let courseManageVC = LLCourseManageViewController(nibName: "LLCourseManageViewController", bundle: nil)
                self.navigationController?.pushViewController(courseManageVC, animated: true)
            
            }
        }
    }
}
