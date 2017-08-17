//
//  LLSigninManageViewController.swift
//  HnR
//
//  Created by licheng on 2017/7/31.
//  Copyright © 2017年 licheng. All rights reserved.
//

import UIKit

class LLSigninManageViewController: UIViewController {
    
    // MARK: - 变量
    
    /// collectionView
    @IBOutlet weak var collectionView: UICollectionView!
    
    /// cellId
    let Signin_Manage_List_Cell = "LLSigninManageListCell"
    

    /// 数据源
    var dataArray: [LLSigninModel]?{
    
        didSet{
            //刷新数据
            collectionView.reloadData()
        }
    }
    
    // MARK: - 类方法
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //注册cell
        let cellNib = UINib(nibName: Signin_Manage_List_Cell, bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: Signin_Manage_List_Cell)
        
        // 获取数据
        getSignListData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - 点击事件
    
    /// 刷新界面
    @IBAction func refreshBtnClick(_ sender: UIButton) {
        
        //获取数据
        getSignListData("刷新成功")
    }
    
    
    /// 退出界面
    @IBAction func backBtnClick(_ sender: UIButton) {
        
        _ = LLInputAlertView.loadViewFfromNib(delegate: self, viewtype: .viewTypeExitView)
        
    }
    
    // MARK: - 公共方法

    /// 获取数据
    func getSignListData(_ message: String? = nil) {
        
        let paramsDic = ["userId" : UserAccount.getUserAccountUserId()]
        
        HnRNetWorkTool.getSignInListData(parameters: paramsDic) { (result) in
            
            self.dataArray = result.signList
            
            if result.signList?.count == 0 {

                MBProgressHUDShowText("当前没有预约的宝宝")
            }else{
            
                MBProgressHUDShowText(message)
            }
        }
    }
}

// MARK: - 代理、数据源方法
extension LLSigninManageViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    
    /// item个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.dataArray?.count ?? 0
    }
    
    /// 返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Signin_Manage_List_Cell, for: indexPath) as! LLSigninManageListCell
        
        cell.model = self.dataArray?[indexPath.item]
        
        return cell
    }
    
    /// 点击cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let model = self.dataArray?[indexPath.item]{
            
            if model.isSigned {// 取消签到
                LLInputAlertView.loadViewFfromNib(delegate: self, viewtype: .viewTypeCancelSignin).model = model
            }else{// 签到
                LLInputCodeAlertView.loadViewFfromNib(delegate: self).model = model
            }
        }
    }
}

// MARK: - LLInputAlertViewDelegate
extension LLSigninManageViewController: LLInputAlertViewDelegate
{

    func inputAlertViewSucess(_ view: LLInputAlertView, viewtype: viewType) {
        
        switch viewtype {
        case .viewTypeCancelSignin:
            // 刷新数据
            getSignListData("取消签到成功")
        case .viewTypeExitView:
            // 退出界面
            self.navigationController?.popViewController(animated: true)
        default: break
        }
    }
}

// MARK: - LLInputCodeViewDelegate
extension LLSigninManageViewController: LLInputCodeAlertViewDelegate
{
    
    func inputCodeAlertViewSucess(_ view: LLInputCodeAlertView) {
        // 刷新数据
        getSignListData()
        
        LLSigninManageSuccessView.loadViewFfromNib().model = view.model
    }
}



