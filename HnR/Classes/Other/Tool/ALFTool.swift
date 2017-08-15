//
//  ALFTool.swift
//  HnR
//
//  Created by licheng on 2017/7/24.
//  Copyright © 2017年 licheng. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class ALFTool {
    
    /// 请求数据方法
    class func requestData(_ type : MethodType, hubtype : Bool? = false, isloading : Bool? = false, urlstring : String, parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : HnRBaseModel) -> ()) {
        
        //0.拼接接口
        let urlStr = Base_URL + urlstring
        
        // 1.获取类型
        let method = type == .get ? Alamofire.HTTPMethod.get : Alamofire.HTTPMethod.post
        
        //2.处理参数
        var parameDic : [String : Any]? = nil

        if parameters != nil {
            parameDic = ["object" : parameters!]
        }
        if isloading! {//显示加载网络框
            LLNetWorkLoadingTool.sharedInstance.loadingStarAnimation()
        }
        //3.发送网络请求
        Alamofire.request(urlStr, method: method, parameters: parameDic, encoding: JSONEncoding.default).responseJSON { (response) in
            
            //4.获取结果
            guard let result = response.result.value else {
                
                //隐藏网络请求弹框
                LLNetWorkLoadingTool.sharedInstance.loadingStopAnimation()
                
                finishedCallback(HnRBaseModel())
                LLPrint("获取服务器接口失败")
                return
            }
            
//            LLPrint("resultJSON == \(JSON(result))")
            
            //隐藏网络请求弹框
            LLNetWorkLoadingTool.sharedInstance.loadingStopAnimation()
            
            //5.将结果回调出去
            if let JsonModel = HnRBaseModel.deserialize(from: JSON(result).rawString()){
                
                if JsonModel.code == .codeSucess{//成功
                
                    finishedCallback(JsonModel)
                    
                }else{//获取数据失败
                
                    LLPrint("\(JsonModel.message ?? "获取数据失败")")
                    
                    //弹框提醒
                    if hubtype! && JsonModel.message?.hashValue != nil {
                        
                        MBProgressHUDShowText(JsonModel.message)
                    }
                    
                    finishedCallback(HnRBaseModel())
                }
            }
        }
    }
    
    /// post方法
    class func postRequestData(hubtype : Bool? = false, isloading : Bool? = false, urlstring : String, parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : HnRBaseModel) -> ()) {
        
        self.requestData(.post, hubtype: hubtype, isloading: isloading, urlstring: urlstring, parameters: parameters) { (response) in
            finishedCallback(response)
        }
    }
    
}

