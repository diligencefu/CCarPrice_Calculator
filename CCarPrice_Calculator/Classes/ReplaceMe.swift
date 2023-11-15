//
//  LNFlutterViewController.swift
//  dealers
//
//  Created by 付耀辉 on 2023/1/10.
//  Copyright © 2023 Trusty Cars. All rights reserved.
//

import UIKit
import Flutter

open class CCHelper: UIViewController,FlutterStreamHandler {
//    let flutterEngine1 = FlutterEngine(name: <#T##String!#>, project: <#T##FlutterDartProject!#>)

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
    
    
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let button = UIButton.init(frame: CGRect(x: 100, y: 200, width: 200, height: 100))
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(CCHelper.test), for: .touchUpInside)
        
        self.view.addSubview(button)
//        var flutterEngine = FlutterEngine(name: "My Flutter Project")
//        flutterEngine.run()
//        flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
//        flutterViewController.modalPresentationStyle = .fullScreen
//        self.channel = FlutterEventChannel(name: "com.pages.flutter", binaryMessenger: flutterViewController.binaryMessenger)
//        self.msgChannel = FlutterBasicMessageChannel.init(name: "messageChannel", binaryMessenger: flutterViewController.binaryMessenger)
//
//        self.channel?.setStreamHandler(self)
//
//        self.msgChannel?.setMessageHandler({ msg, replay in
//            print("xxxxxxxx-----\(msg ?? "")")
//        })
//
        
//        flutterEngine1.run(withEntrypoint: nil)
        
        // Do any additional setup after loading the view.
    }
    
    
   @objc public func flutterTest() {
                
        //接受flutter 发来的消息
       let  method = FlutterMethodChannel(name: "one_page", binaryMessenger: flutterViewController.binaryMessenger)
        method.setMethodCallHandler { (callBack:FlutterMethodCall,  result:FlutterResult) -> Void in
            //获取flutter 返回的信息
            print(callBack.method,callBack.arguments ?? "")
            if callBack.method == "method_native_result_callback" {
                //被动发送消息回传给flutter
                result("flutter: hello")
            }else if callBack.method == "2" {
                self.flutterViewController.dismiss(animated: true)
            }
        }
        
       //swift 发送信息给flutter
       let dic:[String:String] = ["hello":"flutter"];
       self.eventSink?(dic)
       self.present(flutterViewController!, animated: true, completion: nil)
    }
    
    
    @objc public func test() {
//        self.present(flutterEngine1.viewController!, animated: true, completion: nil)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        dismiss(animated: true)
    }
}



