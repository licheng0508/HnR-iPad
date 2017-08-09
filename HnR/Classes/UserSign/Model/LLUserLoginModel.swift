//
//  LLUserLoginModel.swift
//  HnR
//
//  Created by licheng on 2017/7/27.
//  Copyright © 2017年 licheng. All rights reserved.
//

import UIKit

class LLUserLoginInfoModel: HandyJSON{
    
    /// userId
    var userId: String?
    
    /// username
    var username: String?
    
    /// createDate
    var createDate: String?
    
    /// 状态
    var state: Bool = false
    
    required init() {}
}

class LLUserLoginInstitutionModel: HandyJSON{
    
    /// institutionId
    var institutionId: String?
    
    /// 店名
    var chineseName: String?
    
    /// 更新时间
    var updateDate: String?
    
    /// 省
    var province: String?
    
    /// 市
    var city: String?
    
    /// 区
    var district: String?
    
    /// 详细地址
    var address: String?
    
    required init() {}
}

class LLUserLoginModel: HandyJSON{

    /// 用户信息
    var userInfo: LLUserLoginInfoModel?
    
    /// 店面信息
    var institution: LLUserLoginInstitutionModel?
    
    required init() {}
}
