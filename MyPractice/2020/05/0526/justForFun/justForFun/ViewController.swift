//
//  ViewController.swift
//  justForFun
//
//  Created by Trixie Lulamoon on 2020/5/26.
//  Copyright © 2020 Trixie Lulamoon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var first: UITextField!
    
    
    @IBOutlet weak var second: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func clear(_ sender: Any) {
        self.first.text = ""
        self.second.text = ""
    }
    @IBAction func caclulate(_ sender: Any) {
        
        let answerb = Int(self.first.text!)! + Int(self.second.text!)!
        
        print(answerb)
    }
    
}

