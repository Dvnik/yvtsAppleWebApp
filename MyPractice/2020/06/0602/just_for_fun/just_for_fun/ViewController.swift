//
//  ViewController.swift
//  just_for_fun
//
//  Created by Trixie Lulamoon on 2020/6/2.
//  Copyright © 2020 Trixie Lulamoon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var my_button:UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var katati:CGRect
        katati = CGRect(x: 100, y: 200, width: 300, height: 150)
        my_button = UIButton(frame: katati)
        my_button?.setTitle("按我", for: UIControl.State.normal)
        my_button?.setTitle("按我", for: UIControl.State.selected)
        my_button?.setTitleColor(UIColor.black, for: UIControl.State.normal)
        my_button?.backgroundColor = UIColor.red
        self.view.addSubview(my_button!)
    }


}

