//
//  LLSigninManageSuccessCell.swift
//  HnR
//
//  Created by licheng on 2017/8/17.
//  Copyright © 2017年 licheng. All rights reserved.
//

import UIKit

class LLSigninManageSuccessCell: UICollectionViewCell {

    /// 头像
    @IBOutlet weak var headImageView: UIImageView!
    /// 姓名
    @IBOutlet weak var nameLabel: UILabel!
    /// 课程名称
    @IBOutlet weak var courseNameLabel: UILabel!
    /// 上课时间
    @IBOutlet weak var timeLabel: UILabel!
    /// 上课区域
    @IBOutlet weak var areaLabel: UILabel!
    
    /// 数据源
    var model: LLCourseListModel? {
        
        didSet{
            
            if let headPortrait = model?.headPortrait {//头像有值
                let urlStr = URL(string: headPortrait)
                headImageView.sd_setImage(with: urlStr, completed: nil)
            }else{
                headImageView.image = nil
            }
            
            nameLabel.text = model?.childName
            
            courseNameLabel.text = "课程名称：" + "\(model?.courseTitle ?? "")"
            timeLabel.text = "上课时间：" + "\(model?.startTime ?? "")-\(model?.endTime ?? "")"
            areaLabel.text = "上课区域：" + "\(model?.courseArea ?? "")"
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
