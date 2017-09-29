//
//  LLBabyJudgeCardCell.swift
//  HnR
//
//  Created by licheng on 2017/8/24.
//  Copyright © 2017年 licheng. All rights reserved.
//

import UIKit

class LLBabyJudgeCardCell: UICollectionViewCell {
    
    // MARK: - 参数
    
    /// 图片
    @IBOutlet weak var iconImageView: UIImageView!
    /// 名字
    @IBOutlet weak var nameLabel: UILabel!
    /// 标志
    @IBOutlet weak var flagBtn: UIButton!
    /// 背景遮罩
    @IBOutlet weak var bgView: UIView!
    
    var userCourseId: String?
    
    /// 数据源
    var model: LLChildGrowthRecordModel?{
    
        didSet{
        
            if let imageName = model?.imageName {
               iconImageView.image = UIImage(named: "teacher_judge_" + imageName)
            }
            nameLabel.text = model?.name
            
            setupFlagType()
        }
    }
    
    // MARK: - 重写方法
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3)
    }
    
    // MARK: - 按钮点击
    
    /// flag按钮点击
    @IBAction func flagBtnClick() {
        
        addChildLessonJudge(score: .judegeScoreZero)
    }
    
    /// 加一按钮点击
    @IBAction func addOneBtnClick() {
        
        addChildLessonJudge(score: .judegeScoreOne)
    }
    
    /// 减一按钮点击
    @IBAction func minusOneBtnClick() {
        addChildLessonJudge(score: .judegeScoreMinusOne)
    }
    
    // MARK: - 私有方法
    
    /// 添加接口
    func addChildLessonJudge(score: JudegeScore) {
        
        guard let userCourseId = userCourseId, let childGrowthRecordId = model?.childGrowthRecordId else {
            return
        }
        
        let paramsDic = ["userId": UserAccount.getUserAccountUserId(),
                         "userCourseId": userCourseId,
                         "childGrowthRecordId": childGrowthRecordId,
                         "score": score.rawValue
        ] as [String : Any]
        
        HnRNetWorkTool.getAddChiledLessonJudgeData(parameters: paramsDic) { (result) in
            
            if result.status{
                
                self.model?.score = score
                self.model?.isSelectedCell = false
                self.setupFlagType()
            }
        }
    }
    
    /// 设置flag
    private func setupFlagType() {
        
        bgView.isHidden = !(model?.isSelectedCell)!
        
        if let score = model?.score {
            switch score {
            case .judegeScoreZero:
                flagBtn.isHidden = true
            case .judegeScoreOne:
                flagBtn.isHidden = false
                flagBtn.setTitle("+1", for: UIControlState.normal)
                flagBtn.backgroundColor = UIColorWithRed(116, green: 217, blue: 167)
            case .judegeScoreMinusOne:
                flagBtn.isHidden = false
                flagBtn.setTitle("-1", for: UIControlState.normal)
                flagBtn.backgroundColor = UIColorWithRed(255, green: 125, blue: 125)
            }
        }
    }
}
