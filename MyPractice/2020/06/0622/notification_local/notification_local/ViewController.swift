
import UIKit

class ViewController: UIViewController
{
    
    
    @IBOutlet weak var accountText: UITextField!
    
    @IBOutlet weak var passText: UITextField!
    
    @IBOutlet weak var busy: UIActivityIndicatorView!
    
    
    
    //MARK: - ViewController LifeCycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    //MARK: - button Function
    
    
    @IBAction func reset(_ sender: Any)
    {
        self.accountText.text = ""
        self.passText.text = ""
    }
    
    
    
    @IBAction func login(_ sender: Any)
    {
        let session:URLSession
        session = URLSession(configuration: URLSessionConfiguration.default)
        
//        let downtask:URLSessionDownloadTask = session.downloadTask(with: URL(string: "http://127.0.0.1/temp/member.txt")!)

        let downtask:URLSessionDownloadTask = session.downloadTask(  with: URL(string: "http://127.0.0.1/temp/login.php?account=\(accountText.text!)&password=\(passText.text!)")!) {
            (url, respond, err)
            in
            if let error = err
            {
                print("出錯!!錯誤是:\(error)")

            }
            else
            {
                print("======沒有錯誤=====")
//                print("======確認一下位置=====\n\(url!)")
//                print("======回傳內容=====\n\(respond!)")
                
                do
                {
                    let server_message = try String(contentsOf: url!, encoding: .utf8)
                    
                    print(server_message)
                    if server_message == "1"
                    {
                        // is member
                        // ask number
                        
                        DispatchQueue.main.async {
                            var super_controller:UINavigationController
                            super_controller = self.navigationController!
                            
                            let bundle:Bundle = Bundle.main
                            let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: bundle)
                            let page_controller2:UIViewController = storyboard.instantiateViewController(withIdentifier: "page2") as! ViewController2
                            super_controller.pushViewController(page_controller2, animated: true)
                        }
                    }
                    else
                    {
                        // not member
                        let alert = UIAlertController(
                            title: "警告",
                            message: "你的帳密有誤！！",
                            preferredStyle: .alert
                        )
                        let button:UIAlertAction = UIAlertAction(
                            title: "OK",
                            style: UIAlertAction.Style.default) {
                                (button)
                                in
                                
                        }
                        alert.addAction(button)
                        // 在執行緒中呼叫主緒
                        DispatchQueue.main.async {
                            self.present(alert, animated: true, completion: {})
                        }
                        
                    }
                    
                }
                catch {
                    print("轉換下載文字出錯！！錯誤是:\(error)")
                }
                
                
                /*
                let home = NSHomeDirectory()   // every app got its own home directory
                //print(home)
                let documents:String = "\(home)/Documents/xxx.html" // under home directory there is a subdirectory "Documents"
                                                                    // where you can use to store your data(files)
                print(documents)
                let manager:FileManager       // FileManager
                manager = FileManager.default // get FileManager object
                // use Filemanager to copy
                do{
                    if manager.fileExists(atPath: documents){
                        print("已經下載！！不用複製！！")
                    }else{
                        try manager.copyItem(at: url!, to: URL(fileURLWithPath: documents))
                        
                    }
//                    let head:UIImage = UIImage(contentsOfFile: documents)!
//                    self.head.image = head
//                    self.busy.isHidden = true
                }catch{
                    print("拷貝到沙箱出錯！！錯誤是:\(error)")
                }
                */
                

            }
        }
        downtask.resume()
    }
    
    
    
    
    
    
    
    
    
    

}

