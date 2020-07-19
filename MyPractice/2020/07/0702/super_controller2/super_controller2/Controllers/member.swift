//
//  member.swift
//  super_controller2
//
//  Created by Trixie Lulamoon on 2020/7/2.
//  Copyright © 2020 Trixie Lulamoon. All rights reserved.
//

import UIKit

class member: UIViewController
{
    
    @IBOutlet weak var account_txt: UITextField!
    
    @IBOutlet weak var pass_txt: UITextField!
    
    
    
    
    
    

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ button: Any)
    {
        
        let session:URLSession = URLSession(configuration: URLSessionConfiguration.default)
        let task:URLSessionDataTask = session.dataTask(
        with: URL(string: "http://127.0.0.1/temp/ok_login.php?account=\(self.account_txt.text!)&password=\(self.pass_txt.text!)")!){
            (data,reponse,err)
            in
            if let error = err{
                
                let alert = UIAlertController(
                    title: "警告",
                    message: "連線出現問題！\n\(error.localizedDescription)",
                    preferredStyle: .alert
                )
                let button:UIAlertAction = UIAlertAction(
                    title: "OK",
                    style: UIAlertAction.Style.default) {
                        (button)
                        in
                        
                }
                alert.addAction(button)
                self.present(alert, animated: true, completion: {})
            }else{
                
                let server_message = String(data: data!, encoding: .utf8)!
                print("server_message=\(server_message)")
                if server_message == "1m"  || server_message == "1o"{
                    //print("伺服器傳來OK!!我要執行\"go_to_welcom\" SEGUE 了")
                    
                    let mo:Character = server_message[server_message.index(server_message.endIndex, offsetBy: -1)]
                    //print(mo)
                    
                    DispatchQueue.main.async {
                        if mo == "m"{
                            self.performSegue(withIdentifier: "go_to_vip", sender: button)
                        }else{
                            self.performSegue(withIdentifier: "go_to_welcom", sender: button)
                        }
                        
                    }
                    
                }else{
                    
                    DispatchQueue.main.async {
                       let alert = UIAlertController(
                           title: "警告",
                           message: "帳號或密碼有誤",
                           preferredStyle: .alert
                       )
                       let button:UIAlertAction = UIAlertAction(
                           title: "OK",
                           style: UIAlertAction.Style.default) {
                               (button)
                               in
                               
                       }
                       alert.addAction(button)
                       self.present(alert, animated: true, completion: {})
                    }
                    
                }
                
            }
        }
        task.resume()
        
        
        
    }


}
