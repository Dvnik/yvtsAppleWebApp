//
//  ViewController.swift
//  push_notification_client
//
//  Created by Trixie Lulamoon on 2020/7/10.
//  Copyright © 2020 Trixie. All rights reserved.
//

import UIKit




class ViewController: UIViewController {
    
   

    
    @IBOutlet weak var pic: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
         let ppp = UIImage(named: "apple.png")!
        self.pic.image = ppp
       
        }
        
    


}

