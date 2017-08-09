//
//  LLSigninManageCourseCell.swift
//  HnR
//
//  Created by licheng on 2017/8/2.
//  Copyright © 2017年 licheng. All rights reserved.
//

import UIKit

class LLSigninManageCourseCell: UICollectionViewCell {

    // MARK: - 变量
    
    /// 课程名称
    @IBOutlet weak var courseNameLabel: UILabel!
    /// 上课时间
    @IBOutlet weak var timeLabel: UILabel!
    /// 上课区域
    @IBOutlet weak var areaLabel: UILabel!
    
    /// 数据源
    var model: LLCourseListModel? {
        
        didSet{
            
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
