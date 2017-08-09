//
//  CALayer+Additions.swift
//  HnR
//
//  Created by licheng on 2017/8/3.
//  Copyright © 2017年 licheng. All rights reserved.
//

import UIKit

/// xib中设置view边框颜色
extension CALayer {
    var borderColorFromUIColor: UIColor {
        get {
            return UIColor(cgColor: self.borderColor!)
        }
        
        set (color) {
            self.borderColor = color.cgColor
        }
    }
}
