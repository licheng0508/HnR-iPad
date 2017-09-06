//
//  MJRefreshHeaderTool.swift
//  HnR
//
//  Created by licheng on 2017/9/6.
//  Copyright © 2017年 licheng. All rights reserved.
//

import UIKit

class MJRefreshHeaderTool: MJRefreshNormalHeader {
    
    /// 创建header
    class func headerWithRefreshingTarget(target: Any, action: Selector) -> MJRefreshNormalHeader? {
        
        let header = MJRefreshNormalHeader(refreshingTarget: target, refreshingAction: action)
        
        header?.lastUpdatedTimeLabel.isHidden = true
        
        return header
    }

}
