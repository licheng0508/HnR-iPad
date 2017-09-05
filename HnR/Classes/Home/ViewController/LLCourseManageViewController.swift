//
//  LLCourseManageViewController.swift
//  HnR
//
//  Created by licheng on 2017/7/31.
//  Copyright © 2017年 licheng. All rights reserved.
//

import UIKit

class LLCourseManageViewController: UIViewController {

    // MARK: - 变量
    
    /// 头部刷选
    @IBOutlet weak var collectionView: UICollectionView!
    /// 左边tableview
    @IBOutlet weak var leftTableView: UITableView!
    /// 右边TableView
    @IBOutlet weak var rightTableView: UITableView!
    
    /// 左边列表数据源
    var leftDataArray: [LLCourseSigninModel]?{
        didSet{
            leftTableView.reloadData()
        }
    }
    /// 右边列表数据源
    var rightDataArray: [LLCourseChildModel]?{
        didSet{
            rightTableView.reloadData()
        }
    }
    
    /// cellID
    let Course_Manage_Head_Cell = "LLCourseManageHeadCell"
    let Course_Manage_Left_Cell = "LLCourseManageLeftCell"
    let Course_Manage_Right_Cell = "LLCourseManageRightCell"
    
    // MARK: - 懒加载
    
    /// headDataArray
    lazy var headDataArray: [LLCourseManegeHeadModel] = {
        
        return LLCourseManegeHeadModel.modeArray()
    }()
    
    /// 左边选中的cell位置
    lazy var leftSelectedIndexPath: IndexPath = {
        return IndexPath(row: 0, section: 0)
    }()
    
    /// 头部选中的cell位置
    lazy var headSelectedIndexPath: IndexPath = {
        return IndexPath(item: 0, section: 0)
    }()
    
    // MARK: - 类方法
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //注册cell
        setupCellNIb()
        
        // 获取数据
        getLeftListData()
        
        // 默认选中第一个
        collectionView.selectItem(at: headSelectedIndexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.left)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - 点击事件
    
    // 返回按钮点击
    @IBAction func backBtnClick() {
        _ = LLInputAlertView.loadViewFfromNib(delegate: self, viewtype: .viewTypeExitView)
    }
    
    // MARK: - 私有方法
    
    //注册cell
    private func setupCellNIb() {
        
        let cellNib = UINib(nibName: Course_Manage_Head_Cell, bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: Course_Manage_Head_Cell)
        
        let leftCellNib = UINib(nibName: Course_Manage_Left_Cell, bundle: nil)
        leftTableView.register(leftCellNib, forCellReuseIdentifier: Course_Manage_Left_Cell)
        
        let rightCellNib = UINib(nibName: Course_Manage_Right_Cell, bundle: nil)
        rightTableView.register(rightCellNib, forCellReuseIdentifier: Course_Manage_Right_Cell)
    }
    
    /// 获取左边列表数据
    private func getLeftListData() {
        
        let paramsDic = ["userId" : UserAccount.getUserAccountUserId()]
        
        HnRNetWorkTool.getCourseSignInListData(parameters: paramsDic) { (result) in
            
            self.leftDataArray = result.signList
            // 默认选中第一个
            self.leftTableView.selectRow(at: self.leftSelectedIndexPath, animated: true, scrollPosition: UITableViewScrollPosition.top)
            // 获取右边列表数据
            self.getRightListData()
        }
    }
    
    // MARK: - 公共方法
    
    /// 获取右边列表数据
    func getRightListData(_ message: String? = nil) {
        
        // 守护
        guard let leftDataArray = leftDataArray else {
            return
        }
        let model = leftDataArray[leftSelectedIndexPath.row]
        
        let currentModel = headDataArray[headSelectedIndexPath.item]
        
        guard let courseId = model.courseId, let startTime = model.startTime, let signType = currentModel.signType?.rawValue else {
            return
        }
        
        let paramsDic = ["userId" : UserAccount.getUserAccountUserId(),
                         "courseId": courseId,
                         "signType": signType,
                         "startTime": startTime
        ] as [String : Any]
        
        HnRNetWorkTool.getCourseSignChildListData(parameters: paramsDic) { (result) in
            
            self.rightDataArray = result.childList
            
            // 提示信息
            MBProgressHUDShowText(message)
        }
    }
}

// MARK: - collectionView代理、数据源方法
extension LLCourseManageViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    
    /// item个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return headDataArray.count
    }
    
    /// 返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Course_Manage_Head_Cell, for: indexPath) as! LLCourseManageHeadCell
    
        cell.model = headDataArray[indexPath.item]
        
        return cell
    }
    
    /// 点击cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath == headSelectedIndexPath {
            return
        }
        headSelectedIndexPath = indexPath
        // 获取数据
        getRightListData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        headSelectedIndexPath = indexPath
    }
}

// MARK: - tableView代理、数据源方法
extension LLCourseManageViewController: UITableViewDelegate, UITableViewDataSource
{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == leftTableView {
            return leftDataArray?.count ?? 0
        }else{
            return rightDataArray?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == leftTableView{// 左边
        
            let cell = tableView.dequeueReusableCell(withIdentifier: Course_Manage_Left_Cell, for: indexPath) as! LLCourseManageLeftCell
            
            cell.model = leftDataArray?[indexPath.row]
            
            return cell
            
        }else{
        
            let cell = tableView.dequeueReusableCell(withIdentifier: Course_Manage_Right_Cell, for: indexPath) as! LLCourseManageRightCell
            
            cell.backgroundColor = (indexPath.item%2 == 1) ? UIColor.white : UIColorWithRed(247, green: 247, blue: 247)
            
            cell.model = rightDataArray?[indexPath.row]
            cell.myDelegate = self
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == leftTableView {
            
            if leftSelectedIndexPath == indexPath {
                return
            }
            leftSelectedIndexPath = indexPath
            
            // 获取数据
            getRightListData()
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        if tableView == leftTableView {
            leftSelectedIndexPath = indexPath
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        
        return !tableView.isTracking
    }
}

// MARK: - LLCourseManageRightCellDelegate
extension LLCourseManageViewController: LLCourseManageRightCellDelegate
{

    func courseManageRightCellClickSucess(_ view: LLCourseManageRightCell, message: String) {
        // 获取数据
        getRightListData(message)
        
    }
}

// MARK: - LLInputAlertViewDelegate
extension LLCourseManageViewController: LLInputAlertViewDelegate
{
    
    func inputAlertViewSucess(_ view: LLInputAlertView, viewtype: viewType) {
        
        switch viewtype {
        case .viewTypeExitView:
            // 退出界面
            self.navigationController?.popViewController(animated: true)
        default: break
        }
    }
}



