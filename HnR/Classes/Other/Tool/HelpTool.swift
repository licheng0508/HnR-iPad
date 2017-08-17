//
//  HelpTool.swift
//  HnR
//
//  Created by licheng on 2017/7/27.
//  Copyright © 2017年 licheng. All rights reserved.
//

import Foundation

/*
 自定义LOG的目的:
 在开发阶段自动显示LOG
 在发布阶段自动屏蔽LOG
 
 print(__FUNCTION__)  // 打印所在的方法
 print(__LINE__)     // 打印所在的行
 print(__FILE__)     // 打印所在文件的路径
 
 方法名称[行数]: 输出内容
 */
func LLPrint<T>(_ message: T, method: String = #function, line: Int = #line)
{
    #if DEBUG
        print("\(method)[\(line)]: \(message)")
    #endif
}

/// 获取屏幕宽度
func getMainScreenWidth() -> CGFloat {
    return UIScreen.main.bounds.width
}
/// 获取屏幕高度
func getMainScreenHeight() -> CGFloat {
    return UIScreen.main.bounds.height
}

/// 返回颜色
func UIColorWithRed(_ red: Float, green: Float, blue: Float, alpha: Float? = 1.0) -> UIColor {

    return UIColor.init(colorLiteralRed: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha!)
}

//typealias Task = (_ cancel : Bool) -> Void
//
//func delay(time: TimeInterval, task: ()->()) ->  Task? {
//    
//    func dispatch_later(block:()->()) {
//        dispatch_after(
//            
//            dispatch_time(
//                DISPATCH_TIME_NOW,
//                Int64(time * Double(NSEC_PER_SEC))),
//            dispatch_get_main_queue(),
//            block)
//    }
//    
//    var closure: dispatch_block_t? = task
//    var result: Task?
//    
//    let delayedClosure: Task = {
//        cancel in
//        if let internalClosure = closure {
//            if (cancel == false) {
//                DispatchQueue.main.async(execute: internalClosure);
//            }
//        }
//        closure = nil
//        result = nil
//    }
//    
//    result = delayedClosure
//    
//    dispatch_later {
//        if let delayedClosure = result {
//            delayedClosure(false)
//        }
//    }
//    
//    return result;
//}
//
//func cancel(task:Task?) {
//    task?(true)
//}
