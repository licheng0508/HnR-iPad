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
        
        if self.hasPrefix("1") && self.count == 11 {
            return self.isNumber()
        }
        return false
    }
    
    /// 当前字符串是否是数字
    func isNumber() -> Bool {

        let number = "^[0-9]*$"
        let regexNumber = NSPredicate(format: "SELF MATCHES %@",number)
        
        return regexNumber.evaluate(with: self)
    }
}
