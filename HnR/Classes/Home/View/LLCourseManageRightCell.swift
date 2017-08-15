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
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - 点击事件
    
    /// 按钮点击
    @IBAction func signBtnClick() {
        
        if let signType = model?.signType {
            
            switch signType {
            case .signTypeSignin:
                
                // 签出
                getSignOutData()
                
            case .signTypeSignOut:
                
               let view = LLInputAlertView.loadViewFfromNib(delegate: self, viewtype: .viewTypeCancelSignout)
                view.courseModel = model
                
            default: break
            }
        }
    }
    
    // MARK: - 公共方法
    
    // MARK: - 私有方法
    /// 签出
    private func getSignOutData() {
                
        guard let childId = model?.childId, let startTime = model?.startTime else {
            return
        }
        
        let paramsDic = ["userId": UserAccount.getUserAccountUserId(),
                         "type": "2",
                         "childId": childId,
                         "startTime": startTime
            ]
        HnRNetWorkTool.getUserSignOutWayData(parameters: paramsDic) { (result) in
            
            if result.status{
                
                self.myDelegate?.courseManageRightCellClickSucess(self, message: "签出成功")
            }
        }
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

