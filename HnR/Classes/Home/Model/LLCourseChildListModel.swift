//
//  LLCourseChildListModel.swift
//  HnR
//
//  Created by licheng on 2017/8/7.
//  Copyright © 2017年 licheng. All rights reserved.
//

import UIKit

enum SignType: Int, HandyJSONEnum {
    case signTypeNoSignin = 0
    case signTypeSignin = 1
    case signTypeSignOut = 2
    case signTypeAll = 99
}

class LLCourseChildModel: HandyJSON {
    
    /// userCourseId
    var userCourseId: String?
    
    /// childId
    var childId: String?
    
    /// 姓名
    var childName: String?
    
    /// 用户名
    var username: String?
    
    /// 头像
    var headPortrait: String?

    /// 开始时间
    var startTime: String?
    
    /// 是否显示标志
    var isWaited: Bool = false
    
    /// 签到类型 0、未签到 1、已签到 2、已签出 99、全部
    var signType: SignType?
    
    required init() {}
}


class LLCourseChildListModel: HandyJSON {
    
    /// 列表
    var childList: [LLCourseChildModel]?
    
    required init() {}
}
