//
//  ViewController.swift
//  target_action2
//
//  Created by Trixie Lulamoon on 2020/6/4.
//  Copyright © 2020 Trixie Lulamoon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var animalChooser: UISegmentedControl!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func segmentChoose(_ sender: UISegmentedControl)
    {
//        print(sender)
        
//        print("Segment choose! you choose:\(self.animalChooser.selectedSegmentIndex)")
        print("Segment choose! you choose:\(sender.selectedSegmentIndex)")
        
//        switch self.animalChooser.selectedSegmentIndex {
        switch sender.selectedSegmentIndex {
        case 2:
            print("小豬！！")
        case 0:
            print("小狗！！")
        case 1:
            print("小貓！！")
        default:
            print("沒有動物")
        }
        
    }
    
    @IBAction func slideChange(_ sender: UISlider)
    {
        print("Now the slider value is : \(sender.value)")
        
    }
    
    
    @IBAction func switchChange(_ sender: UISwitch)
    {
        print("Now it's On? \(sender.isOn)")
    }
    
    
    @IBAction func stepChange(_ sender: UIStepper)
    {
        print()
        
        
    }
    
    
}

