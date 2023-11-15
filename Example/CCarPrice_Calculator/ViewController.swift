//
//  ViewController.swift
//  CCarPrice_Calculator
//
//  Created by Fu Yaohui on 11/15/2023.
//  Copyright (c) 2023 Fu Yaohui. All rights reserved.
//

import UIKit
import CCarPrice_Calculator
import Flutter

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        let enginName = "My Flutter Project"
        let channelName = "com.pages.flutte"
        let MessageChannelName = "messageChannel"
        let helper = CCHelper(engineName: enginName, channelName: channelName, messageChannelName: MessageChannelName)
        
        helper.jumpToFlutterPage(currentVc: self, methodChannelName: "com.xxxx.nnn") { callBack, result in
            //获取flutter 返回的信息
            print(callBack.method,callBack.arguments ?? "")
            if callBack.method == "method_native_result_callback" {
                //被动发送消息回传给flutter
                result("flutter: hello")
            }else if callBack.method == "2" {
                helper.dismiss()
            }
        }
        
        helper.sendMessageToFluter(dic: ["a":"111"])
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

