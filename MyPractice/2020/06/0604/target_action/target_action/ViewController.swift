//
//  ViewController.swift
//  target_action
//
//  Created by Trixie Lulamoon on 2020/6/4.
//  Copyright © 2020 Trixie Lulamoon. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    var sampleButton: UIButton?
//    var buttonTarget: CustomTarget?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var realX, realY, btnW, btnH:Int
        btnW = 100
        btnH = 60
        realX = Int(self.view.frame.width) / 2 - btnW / 2
        realY = Int(self.view.frame.height) / 2 - btnH / 2
        
        sampleButton = UIButton(type: .roundedRect)
        sampleButton!.frame = CGRect(x:realX, y:realY, width:btnW, height:btnH)

        sampleButton!.setTitle("Sample \n UI Button", for: .normal)
        sampleButton!.titleLabel?.lineBreakMode = .byWordWrapping
        sampleButton!.titleLabel?.textAlignment = .center
        sampleButton!.setTitleColor(UIColor.white, for: .normal)
        sampleButton!.layer.cornerRadius = 6
        sampleButton!.backgroundColor = UIColor.red.withAlphaComponent(0.6)
        sampleButton!.tintColor =  UIColor.brown
        
        sampleButton!.titleEdgeInsets = UIEdgeInsets(top: -10,left: -10,bottom: -10,right: -10)
        sampleButton!.contentEdgeInsets = UIEdgeInsets(top: 5,left: 5,bottom: 5,right: 5)
        
        self.view.addSubview(sampleButton!)
        
//        buttonTarget = CustomTarget()
//        sampleButton!.addTarget(buttonTarget, action: Selector("buttonAction:"), for: .touchUpInside)

        sampleButton!.addTarget(self, action: #selector(self.buttonAction(_:)), for: .touchUpInside)
      


    }
    
    @objc func buttonAction(_ sender:UIButton)
    {
        print("viewController自己扮演Target")
    }
    

}
