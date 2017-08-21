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
func LLPrint<T>(_ message: T, method: String = #function, line: Int = #line, file: String = #file)
{
    #if DEBUG
        
        //获取文件名
        let fileName = (file as NSString).lastPathComponent
        
        let logStr = "\(fileName)-\(method)[\(line)]: \(message)"
        
        print(logStr)
        
        logOutputInFile(logstr: logStr)
        
    #endif
}

/// log写入文件
func logOutputInFile(logstr: String) {
    
    // 创建一个日期格式器
    let dformatter = DateFormatter()
    // 为日期格式器设置格式字符串
    dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    // 使用日期格式器格式化当前日期、时间
    let datestr = dformatter.string(from: Date())

    dformatter.dateFormat = "yyyy-MM-dd"
    // 使用日期格式器格式化当前日期、时间
    let datelog = dformatter.string(from: Date())

    let logURLStr = "///Users/licheng/Desktop/HnRLog/\(datelog)-log.json"
    let logURL = URL(fileURLWithPath: logURLStr)
    
    appendText(fileURL: logURL, string: "\(datestr) \(logstr)")

}

//在文件末尾追加新内容
func appendText(fileURL: URL, string: String) {
    do {
        //如果文件不存在则新建一个
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            FileManager.default.createFile(atPath: fileURL.path, contents: nil)
        }
        
        let fileHandle = try FileHandle(forWritingTo: fileURL)
        let stringToWrite = "\n" + string
        
        //找到末尾位置并添加
        fileHandle.seekToEndOfFile()
        fileHandle.write(stringToWrite.data(using: String.Encoding.utf8)!)
        
    } catch let error as NSError {
        print("failed to append: \(error)")
    }
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
