//
//  LLCourseManageHeadCell.swift
//  HnR
//
//  Created by licheng on 2017/8/4.
//  Copyright © 2017年 licheng. All rights reserved.
//

import UIKit

class LLCourseManageHeadCell: UICollectionViewCell {
    
    /// titleLabel
    @IBOutlet weak var titleLabel: UILabel!
    
    /// model
    var model: LLCourseManegeHeadModel? {
    
        didSet{

            titleLabel.text = model?.title
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // 设置选中背景颜色
        selectedBackgroundView = UIView(frame: frame)
//        selectedBackgroundView?.backgroundColor = UIColorWithRed(171, green: 232, blue: 202)
        selectedBackgroundView?.backgroundColor = UIColorWithRed(115, green: 217, blue: 167)

    }

}
