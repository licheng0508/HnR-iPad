//
//  LLChildGrowthRecordListModel.swift
//  HnR
//
//  Created by licheng on 2017/8/28.
//  Copyright © 2017年 licheng. All rights reserved.
//

import UIKit

enum JudegeScore: Int, HandyJSONEnum {
    case judegeScoreZero = 0
    case judegeScoreOne = 1
    case judegeScoreMinusOne = -1
}

class LLChildGrowthRecordModel: HandyJSON {
    
    /// childGrowthRecordId
    var childGrowthRecordId: String?
    
    /// name
    var name: String?
    
    /// englishName
    var englishName: String?
    
    /// imageName
    var imageName: String?
    
    /// imageUrl
    var imageUrl: String?
    
    /// createDate
    var createDate: String?
    
    /// updateDate
    var updateDate: String?
    
    /// state
    var state: Int?
    
    /// status
    var status: Int?
    
    /// score
    var score: JudegeScore?
    
    /// 是否是选中的cell
    var isSelectedCell: Bool = false
    
    required init() {}
    
}

class LLChildGrowthRecordListModel: HandyJSON {
    
    /// 列表
    var childGrowthRecordList: [LLChildGrowthRecordModel]?
    
    required init() {}
    
}
