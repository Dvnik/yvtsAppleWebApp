//
//  ViewController.swift
//  userDefault
//
//  Created by Trixie Lulamoon on 2020/7/8.
//  Copyright © 2020 Trixie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("\(NSHomeDirectory())")
        let little_data_center:UserDefaults
        little_data_center = UserDefaults.init()
        little_data_center.set(45, forKey: "age")
        little_data_center.set("john", forKey: "name")
        
        print("ok la!")
        little_data_center.set(88, forKey: "age")
        little_data_center.set("mary", forKey: "name")
    }

    @IBAction func getData(_ sender: Any)
    {
        let little_data_center:UserDefaults
        little_data_center = UserDefaults.init()
        
        let age = little_data_center.integer(forKey: "age")
        let name = little_data_center.string(forKey: "name")!
        
        print("\(age) \(name)")
    }
    
}

