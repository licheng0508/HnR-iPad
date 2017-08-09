//
//  UserAccount.swift
//  HnR
//
//  Created by licheng on 2017/7/28.
//  Copyright © 2017年 licheng. All rights reserved.
//

import UIKit

class UserAccount: NSObject {

    /// 判断用户是否登录
    class func isLogin() -> Bool {
        return UserDefaults.standard.bool(forKey: User_Account_Status)
    }
    
    /// 保存用户登录状态
    class func saveUserAccount(status: Bool) {
    
        UserDefaults.standard.set(status, forKey: User_Account_Status)
    }
    
    /// 保存用户Id
    class func saveUserAccountUserId(_ userid: String) {
        
        UserDefaults.standard.set(userid, forKey: User_Account_User_Id)
    }
    
    /// 取出用户Id
    class func getUserAccountUserId() -> String{
        
        return getUserAccountString(User_Account_User_Id)
    }
    
    /// 保存店名
    class func saveUserAccountShopName(_ shopname: String) {
        
        UserDefaults.standard.set(shopname, forKey: User_Account_Shop_Name)
    }
    
    /// 取出店名
    class func getUserAccountShopName() -> String{
        
        return getUserAccountString(User_Account_Shop_Name)
    }
    
    /// 取出用户保存信息
    class func getUserAccountString(_ key: String) -> String{
        
        return UserDefaults.standard.string(forKey: key) ?? ""
    }
}
