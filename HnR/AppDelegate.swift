//
//  AppDelegate.swift
//  HnR
//
//  Created by licheng on 2017/7/19.
//  Copyright © 2017年 licheng. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //注册监听
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.changeRootViewController), name: NSNotification.Name(rawValue: Switch_Root_VC), object: nil)
        
        //初始化Window
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        
        window?.rootViewController = defaultViewController()
        window?.makeKeyAndVisible()
        
        
        return true
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

extension AppDelegate {
    
    /// 切换根控制器
    func changeRootViewController()
    {
        window?.rootViewController = homeRootController()
        window?.makeKeyAndVisible()
    }
    /// 用于返回默认界面
    func defaultViewController() -> UIViewController
    {
        if UserAccount.isLogin() {
            return homeRootController()
        }
        return LLUserLoginViewController(nibName: "LLUserLoginViewController", bundle: nil)
    }
    
    /// 主界面
    private func homeRootController() -> UIViewController {
        return LLNavigationController(rootViewController: LLHomeViewController(nibName: "LLHomeViewController", bundle: nil))
    }
    
}

