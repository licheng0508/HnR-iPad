//
//  LLHomeListModel.swift
//  HnR
//
//  Created by licheng on 2017/8/3.
//  Copyright © 2017年 licheng. All rights reserved.
//

import UIKit

enum SequenceType: Int, HandyJSONEnum {
    
    /// 签到管理
    case sequenceTypeSigninManage = 1
    /// 课程管理
    case sequenceTypeCourseManage = 2
}

class LLHomeLatticeModel: HandyJSON {
    
    /// 状态
    var status: Bool = false
    
    /// 类型
    var state: Int = 0
    
    /// institutionLatticeId
    var institutionLatticeId: String?
    
    /// chineseName
    var chineseName: String?
    
    /// englishName
    var englishName: String?
    
    /// imageList
    var imageList: String?
    
    /// imageBackdrop
    var imageBackdrop: String?
    
    /// createDate
    var createDate: String?
    
    /// updateDate
    var updateDate: String?
    
    /// 场景模块
    var sequence: SequenceType?
    
    required init() {}
    
}

class LLHomeListModel: HandyJSON {

    /// 列表
    var latticeList: [LLHomeLatticeModel]?
    
    required init() {}
    
}
