//
//  LLCourseManageRightCell.swift
//  HnR
//
//  Created by licheng on 2017/8/4.
//  Copyright © 2017年 licheng. All rights reserved.
//

import UIKit

/// 代理
protocol LLCourseManageRightCellDelegate: NSObjectProtocol{
    
    func courseManageRightCellClickSucess(_ view: LLCourseManageRightCell, message: String)
}

class LLCourseManageRightCell: UITableViewCell {
    
    // MARK: - 变量
    
    /// LLCourseManageRightCellDelegate
    weak var myDelegate: LLCourseManageRightCellDelegate?
    
    /// 头像
    @IBOutlet weak var headImageView: UIImageView!
    /// flag标识符
    @IBOutlet weak var flagImageView: UIImageView!
    /// 姓名
    @IBOutlet weak var nameLabel: UILabel!
    /// 联系方式
    @IBOutlet weak var phoneLabel: UILabel!
    /// 点击按钮
    @IBOutlet weak var signBtn: UIButton!
    /// 评价按钮
    @IBOutlet weak var judgeBtn: UIButton!
    
    /// 数据源
    var model: LLCourseChildModel?{
    
        didSet{
        
            if let imageURL = model?.headPortrait {
                
                let urlStr = URL(string: imageURL)
                headImageView.sd_setImage(with: urlStr, completed: nil)
            }else{
                headImageView.image = nil
            }
            
            nameLabel.text = model?.childName
            phoneLabel.text = "联系方式：" + "\(model?.username ?? "")"
            
            flagImageView.isHidden = true
            
            changeJudgeBtnTitle()
            
            if let signType = model?.signType {
                
                switch signType {
                case .signTypeNoSignin:
                    signBtn.setTitle("未报到", for: UIControlState.selected)
                    signBtn.backgroundColor = UIColorWithRed(212, green: 212, blue: 212)
                    signBtn.isSelected = true
                case .signTypeSignin:
                    signBtn.setTitle("签出", for: UIControlState.normal)
                    signBtn.backgroundColor = UIColorWithRed(115, green: 217, blue: 167)
                    signBtn.isSelected = false
                    flagImageView.isHidden = !(model?.isWaited)!
                case .signTypeSignOut:
                    signBtn.setTitle("已签出", for: UIControlState.selected)
                    signBtn.backgroundColor = UIColorWithRed(212, green: 212, blue: 212)
                    signBtn.isSelected = true
                default: break
                }
            }
            // 长按按钮显示当前title
            signBtn.setTitle(signBtn.currentTitle, for: UIControlState.normal)
        }
    }
    
    // MARK: - 重写方法
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        judgeBtn.backgroundColor = UIColorWithRed(115, green: 217, blue: 167)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - 点击事件
    
    /// 评价按钮点击
    @IBAction func judgeBtnClick() {
        
        if let signType = model?.signType {
            
            switch signType {
            case .signTypeNoSignin:
                // 未签到
                MBProgressHUDShowText("这位小朋友还没有到店哦\n暂时不能进行课堂表现评价")
            case .signTypeSignin, .signTypeSignOut:
                // 评价
                getTeacherJudgeChildData()
            default: break
            }
        }
    }
    
    /// 按钮点击
    @IBAction func signBtnClick() {
        
        if let signType = model?.signType {
            
            switch signType {
            case .signTypeSignin:
                
                // 签出
                getSignOutData()
                
            case .signTypeSignOut:
                
                LLInputAlertView.loadViewFfromNib(delegate: self, viewtype: .viewTypeCancelSignout).courseModel = model
               
            default: break
            }
        }
    }
    
    // MARK: - 公共方法
    
    /// 更改评价按钮title
    func changeJudgeBtnTitle() {
        let judgeTitle = (model?.isCommented)! ? "已评价" : "评价"
        judgeBtn.setTitle(judgeTitle, for: UIControlState.normal)
    }
    
    // MARK: - 私有方法
    private func getTeacherJudgeChildData() {
        
        guard let userCourseId = model?.userCourseId else {
            return
        }
        
        let paramsDic = ["userId": UserAccount.getUserAccountUserId(),
                         "userCourseId": userCourseId
        ]
        
        HnRNetWorkTool.getTeacherJudgeListData(parameters: paramsDic) { (result) in
            
            LLBabyJudgeCardView.loadViewFfromNib(delegate: self, coursechildmodel: self.model).model = result
        }
    }
    
    /// 签出
    private func getSignOutData() {
                
        guard let childId = model?.childId, let startTime = model?.startTime else {
            return
        }
        
        LLPrint(childId)
        
        let paramsDic = ["userId": UserAccount.getUserAccountUserId(),
                         "type": "2",
                         "childId": childId,
                         "startTime": startTime
            ]
        HnRNetWorkTool.getUserSignOutWayData(parameters: paramsDic) { (result) in
            
            guard  result != nil else {
                LLPrint("签出失败")
                return
            }
            
            if (result?.status)!{
                self.myDelegate?.courseManageRightCellClickSucess(self, message: "签出成功")
            }
        }
    }
}

// MARK: - LLBabyJudgeCardViewDelegate
extension LLCourseManageRightCell: LLBabyJudgeCardViewDelegate
{
    func babyJudgeCardViewChangeStatus(_ view: LLBabyJudgeCardView) {
        
        changeJudgeBtnTitle()
    }
}

// MARK: - LLInputAlertViewDelegate
extension LLCourseManageRightCell: LLInputAlertViewDelegate
{
    func inputAlertViewSucess(_ view: LLInputAlertView, viewtype: viewType) {
        
        if viewtype == .viewTypeCancelSignout {
            
            myDelegate?.courseManageRightCellClickSucess(self, message: "取消签出成功")
        }
    }
}

