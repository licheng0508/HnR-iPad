//
//  LLBabySigninManageViewController.swift
//  HnR
//
//  Created by licheng on 2017/8/17.
//  Copyright © 2017年 licheng. All rights reserved.
//

import UIKit
import AVFoundation

class LLBabySigninManageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        playBtnClick()
    }
    
    /// 朗读
    func playBtnClick() {
        
        let avSound = AVSpeechSynthesizer()
        
        let utterance = AVSpeechUtterance(string: "锦瑟无端五十弦， 一弦一柱思华年。")
        utterance.rate = 0.5
        utterance.voice = AVSpeechSynthesisVoice(language: "zh-CN")
        
        avSound.speak(utterance)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
