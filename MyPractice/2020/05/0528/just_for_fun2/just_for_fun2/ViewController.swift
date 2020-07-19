//
//  ViewController.swift
//  just_for_fun2
//
//  Created by Trixie Lulamoon on 2020/5/28.
//  Copyright © 2020 Trixie Lulamoon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var account: UITextField!
    
    
    @IBOutlet weak var password: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func clear(_ sender: Any) {
        
        account.text = ""
        password.text = ""
    }
    
    
    @IBAction func login(_ sender: Any) {
        
        
        if let name = account.text
        {
            if name == "john"
            {
                if let pass = password.text
                {
                    if pass == "1234"
                    {
                        // yes !! go to second page
                        print("WELCOME")
                        var pop_up:UIAlertController
                        pop_up = UIAlertController(title: "WELCOME", message: "帳號密碼正確！歡迎光臨", preferredStyle: .alert)
                        
                        let ok:UIAlertAction
                        ok = UIAlertAction(
                            title: "OK",
                            style: .default,
                            handler:
                            {
                                button
                                in
                                
                                let main_storyboard: UIStoryboard
                                // 抓取Storyboard由UIStoryboard抓取，需要帶入名稱與Bundle(另外宣告一個Build.man的主Bundle)
                                let my_bundle:Bundle
                                my_bundle = Bundle.main
                                main_storyboard = UIStoryboard(name: "Main", bundle: my_bundle)
                                var page2_controller:ViewController2
                                page2_controller = main_storyboard.instantiateViewController(identifier: "page2")
                                // 用正在顯示的ViewController"呈現"present
//                                self.present(page2_controller, animated: true) {}
                                // 用view的階層關係
//                                self.view.window?.addSubview(page2_controller.view)
//                                self.removeFromParent()
                                
                                // 以"整個程式"
                                UIApplication.shared.keyWindow?.rootViewController = page2_controller
                            })
                        pop_up.addAction(ok)
                        self.present(pop_up, animated: true) {}
                    }
                }
                
            }
            else
            {
                var pop_up:UIAlertController
                pop_up = UIAlertController(title: "Test", message: "HAHAHA", preferredStyle: .alert)
                self.present(pop_up, animated: true) {}
            }
        }
        else
        {
            
        }
        
        
    }
    
    
    
    
}

