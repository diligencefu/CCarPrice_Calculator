//
//  LNFlutterViewController.swift
//  dealers
//
//  Created by 付耀辉 on 2023/1/10.
//  Copyright © 2023 Trusty Cars. All rights reserved.
//

import UIKit
import Flutter

open class CCHelper: NSObject, FlutterStreamHandler {
    
    //初始化的方法
    var channel:FlutterEventChannel?
    var eventSink:FlutterEventSink?
    var flutterViewController:FlutterViewController!
    var msgChannel : FlutterBasicMessageChannel?
    
    //ios 主动给flutter 发送消息回调方法
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        return nil
    }
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        return nil
    }
    
    
    public init(engineName: String, channelName: String, messageChannelName: String) {
        super.init()
        
        var flutterEngine = FlutterEngine(name: engineName)
        flutterEngine.run()
        flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        flutterViewController.modalPresentationStyle = .fullScreen
        self.channel = FlutterEventChannel(name: channelName, binaryMessenger: flutterViewController.binaryMessenger)
        self.msgChannel = FlutterBasicMessageChannel.init(name: messageChannelName, binaryMessenger: flutterViewController.binaryMessenger)
        self.channel?.setStreamHandler(self)
        self.msgChannel?.setMessageHandler({ msg, replay in
            print("xxxxxxxx-----\(msg ?? "")")
        })
    }
    
    public func dismiss(animated: Bool=true) {
        flutterViewController.dismiss(animated: animated)
    }
    
    
    public func jumpToFlutterPage(currentVc:UIViewController?=nil, methodChannelName: String, handler: @escaping FlutterMethodCallHandler) {
        
        guard let flutterViewController = flutterViewController else {
            return
        }
        
        //接受flutter 发来的消息
        let  method = FlutterMethodChannel(name: methodChannelName, binaryMessenger: flutterViewController.binaryMessenger)
        method.setMethodCallHandler(handler)
        
        if let nav = currentVc as? UINavigationController {
            nav.pushViewController(flutterViewController, animated: true)
        }else{
            (currentVc ?? UIApplication.shared.windows.first?.rootViewController)?.present(flutterViewController, animated: true)
        }
    }
    
    //swift 发送信息给flutter
    public func sendMessageToFluter(dic: [String:String]) {
        self.eventSink?(dic)
    }
    
}



