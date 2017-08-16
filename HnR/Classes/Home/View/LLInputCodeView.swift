//
//  LLInputCodeView.swift
//  HnR
//
//  Created by licheng on 2017/8/15.
//  Copyright © 2017年 licheng. All rights reserved.
//

import UIKit
/// 代理
protocol LLInputCodeViewDelegate: NSObjectProtocol{
    
    func inputCodeSuccessView(_ view: LLInputCodeView, password: String)
}

class LLInputCodeView: UIView {

    // MARK: - 参数
    
    /// 输入框个数
    @IBInspectable var lenght:Int = 0 {
        didSet{
            setupViews()
        }
    }

    /// LLInputCodeViewDelegate
    weak var myDelegate: LLInputCodeViewDelegate?
    
    var password:   String = ""
    var squareArray = [UILabel]()
    var textField:  UITextField = UITextField()
    
    // MARK: - 重写方法
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        textField.becomeFirstResponder()
    }
    
    // MARK: - 公共方法
    
    /// 更改输入框数字
    func changeCodeString(codestring: String) {
        
        for (index, label) in squareArray.enumerated() {
            
            if index == password.characters.count {
                label.text = codestring
                break
            }
        }
    }
    
    /// 清空输入框数字
    func clearCodeString() {
        
        textField.text = ""
        password = ""
        squareArray.forEach { (label) in
            label.text = ""
        }
    }
    
    // MARK: - 私有方法

    /// 初始化控件
    private func setupViews(){
        
        // 设置边角
        layer.masksToBounds = true
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        
        let space: CGFloat = 1
        let height  = frame.height
        let width = (frame.width - space * CGFloat(lenght - 1)) / CGFloat(lenght)
        
        for index in 0..<lenght{
            
            let label = UILabel(frame: CGRect(x: (width + space) * CGFloat(index), y: 0, width: width, height: height))
            label.font = UIFont.systemFont(ofSize: 26)
            label.textColor = UIColor.black
            label.textAlignment = .center
            squareArray.append(label)
            addSubview(label)
            
            if index < lenght - 1 {
                let spaceView = UIView(frame: CGRect(x: (width + space) * CGFloat(index + 1), y: 0, width: 1, height: height))
                spaceView.backgroundColor = UIColor.lightGray
                addSubview(spaceView)
            }
        }
        
        textField.keyboardType = .numberPad
        textField.delegate = self
        addSubview(textField)
    }
}

// MARK: - UITextFieldDelegate代理
extension LLInputCodeView: UITextFieldDelegate
{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        clearCodeString()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        LLPrint("input string: \(range.location)")
        
        
        if !string.isNumber() {
            return false
        }
        
        // 处理撤销逻辑
        if range.length > 1 {
            clearCodeString()
            return false
        }
        
        // 处理删除逻辑
        if string == "" {
            if password == ""{// 密码已经为空
                return true
            }else if password.characters.count == 1{
                password = ""
            }else{
                password = password.substring(to: password.index(password.startIndex, offsetBy: password.characters.count - 1))
            }
            
            changeCodeString(codestring: string)
            
        }else{
            
            changeCodeString(codestring: string)
            password += string
        }
        
        // 完成输入
        if password.characters.count >= lenght {
            textField.resignFirstResponder
            textField.text = password
            self.myDelegate?.inputCodeSuccessView(self, password: password)
            self.endEditing(true)
            return false
        }
        
        return true
    }
}

