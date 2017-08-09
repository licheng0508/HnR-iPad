//
//  String+Extension.swift
//  HnR
//
//  Created by licheng on 2017/7/31.
//  Copyright © 2017年 licheng. All rights reserved.
//

import Foundation

extension String
{

    /// 当前字符串是否是手机号
    func isPhoneNum() -> Bool {
        
        if self.hasPrefix("1") && self.characters.count == 11 {
            return true
        }
        return false
    }
}
