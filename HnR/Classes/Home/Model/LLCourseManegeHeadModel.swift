//
//  LLCourseManegeHeadModel.swift
//  HnR
//
//  Created by licheng on 2017/8/4.
//  Copyright © 2017年 licheng. All rights reserved.
//

import UIKit

class LLCourseManegeHeadModel: NSObject {

    /// cell的状态
    var signType: SignType?
    
    /// title
    var title: String?
    
    override init() {
        super.init()
    }
    
    /// 初始化
    class func modelWith(title: String, signtype: SignType? = .signTypeAll) -> LLCourseManegeHeadModel {
        
        let model: LLCourseManegeHeadModel = LLCourseManegeHeadModel()
        model.title = title
        model.signType = signtype
        return model
    }
    
    /// 返回模型数组
    class func modeArray() -> [LLCourseManegeHeadModel] {
        
        var arrary: [LLCourseManegeHeadModel] = []
        
        arrary.append(modelWith(title: "全部"))
        arrary.append(modelWith(title: "已报到", signtype: SignType.signTypeSignin))
        arrary.append(modelWith(title: "未报到", signtype: SignType.signTypeNoSignin))
        arrary.append(modelWith(title: "已签出", signtype: SignType.signTypeSignOut))
        return arrary
    }
    
}
