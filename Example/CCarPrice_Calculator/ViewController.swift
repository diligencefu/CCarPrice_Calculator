//
//  ViewController.swift
//  CCarPrice_Calculator
//
//  Created by Fu Yaohui on 11/15/2023.
//  Copyright (c) 2023 Fu Yaohui. All rights reserved.
//

import UIKit
import CCarPrice_Calculator

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        show(CCHelper(), sender: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

