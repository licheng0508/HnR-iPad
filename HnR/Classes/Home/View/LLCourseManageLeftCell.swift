//
//  LLCourseManageLeftCell.swift
//  HnR
//
//  Created by licheng on 2017/8/4.
//  Copyright © 2017年 licheng. All rights reserved.
//

import UIKit

class LLCourseManageLeftCell: UITableViewCell {
    
    /// 课程名
    @IBOutlet weak var courseNameLabel: UILabel!
    /// 开始时间
    @IBOutlet weak var startTimeLabel: UILabel!
    /// 人数
    @IBOutlet weak var countLabel: UILabel!
    
    /// 数据源
    var model: LLCourseSigninModel?{
    
        didSet{
        
            courseNameLabel.text = model?.courseTitle
            startTimeLabel.text = "\(model?.startTime ?? "")" + " - " + "\(model?.endTime ?? "")"
            countLabel.text = "\(model?.signCount ?? 0)" + "/" + "\(model?.reservationCount ?? 0)"
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // 设置选中背景颜色
        selectedBackgroundView = UIView(frame: frame)
        selectedBackgroundView?.backgroundColor = UIColorWithRed(115, green: 217, blue: 167)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
