//
//  LLHomeListCell.swift
//  HnR
//
//  Created by licheng on 2017/7/31.
//  Copyright © 2017年 licheng. All rights reserved.
//

import UIKit

class LLHomeListCell: UICollectionViewCell {

    // MARK: - 变量
    
    /// 图标
    @IBOutlet weak var iconImageView: UIImageView!
    /// 名称
    @IBOutlet weak var nameLabel: UILabel!
    
    /// 数据源
    var model: LLHomeLatticeModel? {
        
        didSet{
                        
            iconImageView.image = UIImage(named: "home_index_list_icon_\(model?.sequence?.rawValue ?? 1)")
            
            nameLabel.text = model?.chineseName
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
