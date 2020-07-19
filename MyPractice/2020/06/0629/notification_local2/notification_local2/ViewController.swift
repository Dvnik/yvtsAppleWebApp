

import UIKit

class ViewController: UIViewController
{
    
    
    @IBOutlet weak var account_txt: UITextField!
    
    @IBOutlet weak var pass_txt: UITextField!
    
    
    
    
    
    
    

    override func viewDidLoad()
    {
        super.viewDidLoad()

    }
    

    
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        super.performSegue(withIdentifier: identifier, sender: sender)
        print("I am performSegue")
        self.shouldPerformSegue(withIdentifier: "go_to_welcome", sender: sender)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        print("I am prepare.")
    }
    
    
    @IBAction func login(_ button: UIButton) {
        print("login is click.")
        self.performSegue(withIdentifier: "go_to_welcome", sender: button)

//        let session:URLSession = URLSession(configuration: .default)
//        
//        let task:URLSessionDataTask = session.dataTask(
//            with: URL(string: "http://127.0.0.1/temp/ok_login.php?account=\(String(describing: self.account_txt.text))&password=\(self.pass_txt.text)")!)
//            {
//                (data, response, err)
//                in
//                
//                if let error = err {
//                    
//                    let alert = UIAlertController(
//                        title: "警告",
//                        message: "連線出現問題！！\n\(error.localizedDescription)",
//                        preferredStyle: .alert
//                    )
//                    let button: UIAlertAction = UIAlertAction(
//                    title: "OK", style: .default) {
//                        (button)
//                        in
//                    }
//                    alert.addAction(button)
//                    self.present(alert, animated: true) {}
//                }
//                else {
//                    
//                    let server_message:String = String(data: data!, encoding: .utf8)!
//                    
//                    if server_message == "1" {
//                        
//                        let mo:Character = server_message[server_message.index(server_message.endIndex, offsetBy:-1)]
//                        print(mo)
//                        DispatchQueue.main.async {
//                            if mo == "m" {
//                                self.performSegue(withIdentifier: "go_to_vip", sender: button)
//                            }
//                            else
//                            {
//                                self.performSegue(withIdentifier: "go_to_welcome", sender: button)
//                            }
//                            
//                        }
//                    }
//                    else
//                    {
//                        
//                        DispatchQueue.main.async {
//                            let alert = UIAlertController(
//                                    title: "警告",
//                                    message: "帳號或密碼有誤",
//                                    preferredStyle: .alert
//                                )
//                                let button: UIAlertAction = UIAlertAction(
//                                title: "OK", style: .default) {
//                                    (button)
//                                    in
//                                }
//                                alert.addAction(button)
//                                self.present(alert, animated: true) {}
//                            }
//                        }
//                        
//                        
//                }
//            }
//        
//        
//        task.resume()
    }
    

}

