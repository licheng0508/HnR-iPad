//
//  LLSignListModel.swift
//  HnR
//
//  Created by licheng on 2017/8/1.
//  Copyright © 2017年 licheng. All rights reserved.
//

import UIKit


class LLCourseListModel: HandyJSON {
    
    /// userCourseId
    var userCourseId: String?
    
    /// 课程名
    var courseTitle: String?
    
    /// 开始时间
    var startTime: String?
    
    /// 结束时间
    var endTime: String?
    
    /// 课程区域
    var courseArea: String?
    
    required init() {}
}

class LLSigninModel: HandyJSON {
    
    /// 是否签到
    var isSigned: Bool = false
    
    /// childId
    var childId: String?
    
    /// 头像
    var headPortrait: String?
    
    /// 姓名
    var childName: String?
    
    /// 列表
    var courseList: [LLCourseListModel]?
    
    required init() {}
}


class LLSignListModel: HandyJSON {
    
    /// 列表
    var signList: [LLSigninModel]?
    
    required init() {}
}
