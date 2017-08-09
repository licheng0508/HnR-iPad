//
//  HnRBaseModel.swift
//  HnR
//
//  Created by licheng on 2017/7/26.
//  Copyright © 2017年 licheng. All rights reserved.
//

import UIKit


enum Code: Int, HandyJSONEnum {
    case codeSucess = 0
    case codeMessage = 1
}

class HnRBaseModel: HandyJSON {

    /// code值
    var code: Code?
    /// 数据
    var object: Any?
    /// 状态
    var status: String?
    /// 时间
    var timestamp: String?
    /// 提示信息
    var message: String?
    
    required init() {}
    
}
