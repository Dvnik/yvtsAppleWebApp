//
//  ViewController.swift
//  delegation2
//
//  Created by Trixie Lulamoon on 2020/6/9.
//  Copyright © 2020 Trixie Lulamoon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, URLSessionDownloadDelegate //URLSessionDataDelegate
{

    
    //MARK: - 變數群
    @IBOutlet weak var accountTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var head: UIImageView!
    
    
    @IBOutlet weak var busy: UIActivityIndicatorView!
    
    @IBOutlet weak var progress: UIProgressView!
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.accountTextField.delegate = self
    }

    /*
    // 以下是URLSessionDataDelegate的反應函數群
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
//        var member_data:String
//        member_data = String(data: data, encoding: .utf8)!
//        print(member_data)
        
        let head:UIImage
        head = UIImage(data: data)!
        self.head.image = head
    }
    */
    //MARK: - 以下是URLSessionDownloadDelegate的反應函數群
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL)
    {
        print("下載完成！！下載的位置在：\(location)")
        print("下載完成！！")
        let home = NSHomeDirectory()// every app got its own home directory
        print(home)
        let documents:String = "\(home)/Documents/Iambad.jpg" // under home directory there is a subdirectory "Documents"
        // where you can use to store your data(file)
//        print(documents)
        
        let manager:FileManager // FileManager
        manager = FileManager.default // get fileManager objects
        // use filemanager to copy
        do
        {
            if manager.fileExists(atPath: documents)
            {
                print("已經下載！不用再拷貝！！")
            }
            else
            {
                try manager.copyItem(at: location, to: URL(fileURLWithPath: documents))
                
            }
            
            let head:UIImage = UIImage(contentsOfFile: documents)!
            self.head.image = head
            
            
            self.busy.isHidden = true
            
        }catch {
            print("拷貝到沙箱出錯！！錯誤是:\(error)")
        }
        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        print("====本次下載====\(bytesWritten) bytes  累積下載:\(totalBytesWritten) bytes  預計要下載:\(totalBytesExpectedToWrite)")
        
        print("下載進度:\(Float(totalBytesWritten) / 14280.0)")
        self.progress.progress = Float(totalBytesWritten) / 14280.0
    }
    
    
    //MARK: - 以下是UITexxtFileDelegate的反應函數群
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        print("XXXX====>\(string)")
        for c in string
        {
            if (c.isSymbol || c.isPunctuation || c.isCurrencySymbol || c.isMathSymbol)
            {
                print("你輸入有不合規定的字元")
                // alert Controller
                let alert:UIAlertController = UIAlertController(
                    title: "警告",
                    message: "你輸入有不合規定的字元\(c)",
                    preferredStyle: .alert)
                
                // alert Action(button Click)
                let button:UIAlertAction = UIAlertAction(
                    title: "OK",
                    style: .default) {
                        (button)
                        in
                        
                }
                // Set Show event
                alert.addAction(button)
                self.present(alert, animated: true) {}
                break
            }
        }
        return true
    }
    //MARK: -  以下這些是Target-acrion 函數
    @IBAction func reset(_ sender: UIButton)
    {
        self.accountTextField.text = ""
        self.passwordTextField.text = ""
    }
    
    
    @IBAction func login(_ sender: UIButton)
    {
        print("start Login====================")
        
        self.busy.isHidden = false
        
        let myUrl:URL = URL(string: "https://myfirstbase-c1e0c.web.app/Imbad.jpg")!
        var request:URLRequest = URLRequest(
            url: myUrl,
            cachePolicy: .reloadIgnoringCacheData,
            timeoutInterval: 60
        )
        // 允許接收totalBytesExpectedToWrite的值
        request.addValue("", forHTTPHeaderField: "Accept-Encoding")
        
        var session: URLSession
        session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate: self,
            delegateQueue: OperationQueue.current)
        
//        let task:URLSessionDataTask = session.dataTask(with: request)
        let task:URLSessionDownloadTask = session.downloadTask(with: request)
        task.resume()
        
        print("Login End==================")
    }
}

