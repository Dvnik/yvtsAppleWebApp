//
//  ViewController.swift
//  notification_local2_simple
//
//  Created by Trixie Lulamoon on 2020/6/29.
//  Copyright © 2020 Trixie Lulamoon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var account_txt: UITextField!
    
    
    @IBOutlet weak var pass_txt: UITextField!
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        var wait = true
        var go_welcome = false
        
        let session:URLSession = URLSession(configuration: .default)
        
        let task:URLSessionDataTask = session.dataTask(
            with: URL(string: "http://127.0.0.1/temp/ok_login.php?account=\(String(describing: self.account_txt.text))&password=\(self.pass_txt.text)")!)
            {
                (data, response, err)
                in
                
                if let error = err {
                    
                    let alert = UIAlertController(
                        title: "警告",
                        message: "連線出現問題！！\n\(error.localizedDescription)",
                        preferredStyle: .alert
                    )
                    let button: UIAlertAction = UIAlertAction(
                    title: "OK", style: .default) {
                        (button)
                        in
                    }
                    alert.addAction(button)
                    self.present(alert, animated: true) {}
                }
                else {
                    
                    let server_message:String = String(data: data!, encoding: .utf8)!
                    
                    if server_message == "1" {
//                        DispatchQueue.main.async {
//                            self.performSegue(withIdentifier: "go_to_welcome", sender: nil)
//                        }
                        print("伺服器傳回來OK!!我要執行\"go_welcome\"了")
                        
                        go_welcome = true
                    }
                    else
                    {
                        go_welcome = false
                        DispatchQueue.main.async {
                        let alert = UIAlertController(
                                title: "警告",
                                message: "帳號或密碼有誤",
                                preferredStyle: .alert
                            )
                            let button: UIAlertAction = UIAlertAction(
                            title: "OK", style: .default) {
                                (button)
                                in
                            }
                            alert.addAction(button)
                            self.present(alert, animated: true) {}
                        }
                    }
                    wait = false
                        
                        
                }
            }
        
        
        task.resume()
        // make the following wait for thread coming back
        while(wait) {
            print("等待執行緒驗證完伺服器訊息...")
        }
        print("等完了！！！伺服器驗證結果\(go_welcome)")
        return go_welcome
    }
    
    
    
    
    
    
    
    
    
    
    
}

