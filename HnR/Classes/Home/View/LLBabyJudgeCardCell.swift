//
//  LLBabyJudgeCardCell.swift
//  HnR
//
//  Created by licheng on 2017/8/24.
//  Copyright © 2017年 licheng. All rights reserved.
//

import UIKit

class LLBabyJudgeCardCell: UICollectionViewCell {
    
    
    /// 背景遮罩
    @IBOutlet weak var bgView: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgView.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.3)
    }

}
