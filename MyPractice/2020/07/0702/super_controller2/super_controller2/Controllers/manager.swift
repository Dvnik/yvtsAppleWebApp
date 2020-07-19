//
//  manager.swift
//  super_controller2
//
//  Created by Trixie Lulamoon on 2020/7/2.
//  Copyright © 2020 Trixie Lulamoon. All rights reserved.
//

import UIKit

class manager: UIViewController {

    @IBOutlet weak var order_list: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let bureau:NotificationCenter
        bureau = NotificationCenter.default
        bureau.addObserver(self, selector: #selector(processOrder(notification:)), name: NSNotification.Name("OREDER_COME"), object: nil)
        print("監聽通知中....")
        
    }
    
    @objc func processOrder(notification:NSNotification){
        print("收到訂單囉！")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
