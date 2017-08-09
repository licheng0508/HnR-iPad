//
//  LLSigninManageListCell.swift
//  HnR
//
//  Created by licheng on 2017/8/1.
//  Copyright © 2017年 licheng. All rights reserved.
//

import UIKit

class LLSigninManageListCell: UICollectionViewCell {

    // MARK: - 变量
    
    /// 是否签到
    @IBOutlet weak var checkIcon: UIImageView!
    /// 头像
    @IBOutlet weak var headImageView: UIImageView!
    /// 名字
    @IBOutlet weak var nameLabel: UILabel!
    
    
    /// 数据源
    var model: LLSigninModel? {
    
        didSet{
        
            checkIcon.isHidden = !(model?.isSigned)!
            
            if let headPortrait = model?.headPortrait {//头像有值
                let urlStr = URL(string: headPortrait)
                headImageView.sd_setImage(with: urlStr, completed: nil)
            }else{
                headImageView.image = nil
            }
            nameLabel.text = model?.childName
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
