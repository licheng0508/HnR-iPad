//
//  LLCourseSigninListModel.swift
//  HnR
//
//  Created by licheng on 2017/8/7.
//  Copyright © 2017年 licheng. All rights reserved.
//

import UIKit



class LLCourseSigninModel: HandyJSON {
    
    /// courseId
    var courseId: String?
    
    /// 课程名
    var courseTitle: String?
    
    /// 开始时间
    var startTime: String?
    
    /// 结束时间
    var endTime: String?
    
    /// reservationCount
    var reservationCount: Int = 0
    
    /// 签到人数
    var signCount: Int = 0
    
    required init() {}
}


class LLCourseSigninListModel: HandyJSON {

    /// 列表
    var signList: [LLCourseSigninModel]?
    
    required init() {}
}
