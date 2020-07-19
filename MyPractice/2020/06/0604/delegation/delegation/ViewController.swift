//
//  ViewController.swift
//  delegation
//
//  Created by Trixie Lulamoon on 2020/6/4.
//  Copyright © 2020 Trixie Lulamoon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bottomDistance: NSLayoutConstraint!
    
    @IBOutlet var squreSide: [NSLayoutConstraint]!
    
    @IBOutlet weak var textFieldAccount: UITextField!
    
    var myDelegator:myTextFiledDelegator?
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let app:UIApplication = UIApplication.shared
        let delegate:AppDelegate = app.delegate as! AppDelegate
        let width = delegate.screenWidth
//        let height = delegate.screenHeight
        
        if width == 414
        {
            print("in iphone 11")
            self.bottomDistance.constant = 60
            
        }
        else if width == 375
        {
            print("in iPhone SE2")
            for side in squreSide
            {
                side.constant = side.constant * 0.8
            }
        }
        
        myDelegator = myTextFiledDelegator()
        self.textFieldAccount.delegate = myDelegator
    }


}

