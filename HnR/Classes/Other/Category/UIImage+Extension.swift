//
//  UIImage+Extension.swift
//  HnR
//
//  Created by licheng on 2017/8/4.
//  Copyright © 2017年 licheng. All rights reserved.
//

import Foundation

extension UIImage
{
    class func imageWithColor(colorLiteralRed: Float, green: Float, blue: Float) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        // 在这个范围开启一个上下文
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        // 在这段上下文中获取到颜色
        context?.setFillColor(red: CGFloat(colorLiteralRed/255.0), green: CGFloat(green/255.0), blue: CGFloat(blue/255.0), alpha: 1)
        // 填充这个颜色
        context?.fill(rect)
        let myImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return myImage!
    }
}
