//
//  ViewController.swift
//  justforfun
//
//  Created by yihsuan on 2020/5/15.
//  Copyright © 2020 yihsuan. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

        
    @IBOutlet weak var first_number: NSTextField!
    
    @IBOutlet weak var second_number: NSTextField!
    
    @IBOutlet weak var sum: NSTextField!
    
    @IBOutlet weak var difference: NSTextField!
    
    @IBOutlet weak var product: NSTextField!
    
    @IBOutlet weak var division: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    

    @IBAction func caculate(_ sender: Any) {
//        print("click.")
        let first:Int = Int(first_number.intValue)
        let second:Int = Int(second_number.intValue)
        
        print("Insert first number is \(first), second is \(second)")
        
        sum.stringValue = "和：\(first + second)"
        difference.stringValue = "差：\(first - second)"
        product.stringValue = "積：\(first * second)"
        division.stringValue = "商：\(Float(first) / Float(second))"
    }
    

}

