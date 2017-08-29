//
//  HnRNetWorkTool.swift
//  HnR
//
//  Created by licheng on 2017/7/24.
//  Copyright © 2017年 licheng. All rights reserved.
//

import UIKit

class HnRNetWorkTool {
    
    /// 用户登录
    class func getUserLoginData(parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : LLUserLoginModel) -> ()) {
        
        let urlStr = "chain/user/login"
        
        ALFTool.postRequestData(hubtype: true, isloading: true, urlstring: urlStr, parameters: parameters) { (JsonModel) in
            
            if let result = LLUserLoginModel.deserialize(from: JSON(JsonModel.object as Any).rawString()){
                
                finishedCallback(result)
            }
        }
    }
    
    /// 获取登录验证码
    class func getUserLoginSmSCodeData(parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : LLUserLoginSmSModel) -> ()) {
        
        let urlStr = "user/sms"
        
        ALFTool.postRequestData(hubtype: true, isloading: true, urlstring: urlStr, parameters: parameters) { (JsonModel) in
            
            if let result = LLUserLoginSmSModel.deserialize(from: JSON(JsonModel.object as Any).rawString()){
                
                finishedCallback(result)
            }
        }
    }
    
    /// 获取首页列表数据
    class func getHomeListData(parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : LLHomeListModel) -> ()) {
        
        let urlStr = "chain/lattice/list"
        
        ALFTool.postRequestData(hubtype: true, isloading: true, urlstring: urlStr, parameters: parameters) { (JsonModel) in
            
            if let result = LLHomeListModel.deserialize(from: JSON(JsonModel.object as Any).rawString()){
                
                finishedCallback(result)
            }
        }
    }
    
    /// 获取签到列表数据
    class func getSignInListData(parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : LLSignListModel) -> ()) {
        
        let urlStr = "chain/sign/list"
        
        ALFTool.postRequestData(urlstring: urlStr, parameters: parameters) { (JsonModel) in
            
            if let result = LLSignListModel.deserialize(from: JSON(JsonModel.object as Any).rawString()){
                
                finishedCallback(result)
            }
            
        }
    }
    
    /// 签到、取消签到 接口
    class func getUserSignInWayData(parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : LLSignWayModel?) -> ()) {
        
        let urlStr = "chain/sign"
        
        ALFTool.postRequestData(hubtype: true, isloading: true, urlstring: urlStr, parameters: parameters) { (JsonModel) in
            
            if let result = LLSignWayModel.deserialize(from: JSON(JsonModel.object as Any).rawString()){
                
                finishedCallback(result)
            }
            finishedCallback(nil)
        }
    }
    
    /// 签出 、取消签出 接口
    class func getUserSignOutWayData(parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : LLSignWayModel?) -> ()) {
        
        let urlStr = "chain/sign/out"
        
        ALFTool.postRequestData(hubtype: true, isloading: true, urlstring: urlStr, parameters: parameters) { (JsonModel) in
            
            if let result = LLSignWayModel.deserialize(from: JSON(JsonModel.object as Any).rawString()){
                
                finishedCallback(result)
            }
            finishedCallback(nil)
        }
    }
    
    /// 验证密码输入接口
    class func getUserPassWordValidateData(parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : LLSignWayModel?) -> ()) {
        
        let urlStr = "chain/user/password/validate"
        
        ALFTool.postRequestData(hubtype: true, isloading: true, urlstring: urlStr, parameters: parameters) { (JsonModel) in
            
            if let result = LLSignWayModel.deserialize(from: JSON(JsonModel.object as Any).rawString()){
                
                finishedCallback(result)
            }
            finishedCallback(nil)
        }
    }
    
    /// 获取课程签到列表数据
    class func getCourseSignInListData(parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : LLCourseSigninListModel) -> ()) {
        
        let urlStr = "chain/sign/course/list"
        
        ALFTool.postRequestData(urlstring: urlStr, parameters: parameters) { (JsonModel) in
            
            if let result = LLCourseSigninListModel.deserialize(from: JSON(JsonModel.object as Any).rawString()){
                
                finishedCallback(result)
            }
        }
    }
    
    /// 获取课程签到宝宝数据
    class func getCourseSignChildListData(parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : LLCourseChildListModel) -> ()) {
        
        let urlStr = "chain/sign/child/list"
        
        ALFTool.postRequestData(urlstring: urlStr, parameters: parameters) { (JsonModel) in
            
            if let result = LLCourseChildListModel.deserialize(from: JSON(JsonModel.object as Any).rawString()){
                
                finishedCallback(result)
            }
        }
    }
    
    /// 获取老师评论学生类型列表
    class func getTeacherJudgeListData(parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : LLChildGrowthRecordListModel) -> ()) {
        
        let urlStr = "chain/lesson/growth/list"
        
        ALFTool.postRequestData(isloading: true, urlstring: urlStr, parameters: parameters) { (JsonModel) in
            
            if let result = LLChildGrowthRecordListModel.deserialize(from: JSON(JsonModel.object as Any).rawString()){
                
                finishedCallback(result)
            }
        }
    }
    
    /// 添加孩子课堂表现接口
    class func getAddChiledLessonJudgeData(parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : LLSignWayModel) -> ()) {
        
        let urlStr = "chain/lesson/growth/add"
        
        ALFTool.postRequestData(hubtype: true, isloading: true, urlstring: urlStr, parameters: parameters) { (JsonModel) in
            
            if let result = LLSignWayModel.deserialize(from: JSON(JsonModel.object as Any).rawString()){
                
                finishedCallback(result)
            }
        }
    }
}
