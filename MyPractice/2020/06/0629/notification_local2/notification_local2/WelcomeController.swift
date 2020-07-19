//
//  WelcomeController.swift
//  notification_local2
//
//  Created by Trixie Lulamoon on 2020/6/29.
//  Copyright © 2020 Trixie Lulamoon. All rights reserved.
//

import UIKit

class WelcomeController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    
    
    @IBOutlet weak var shop_table: UITableView!
    
    var shop_names:[String]!
//    var shop_names:[String] = []
    
    @IBOutlet weak var busy: UIActivityIndicatorView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true
        
        
        let session:URLSession = URLSession(configuration: .default)
        
        let task:URLSessionDataTask = session.dataTask(
            with: URL(string: "http://127.0.0.1/temp/get_shop_name.php")!)
//            with: URL(string: "http://127.0.0.1/temp/get_shop_name2.php")!)
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
                print("server_message=\(server_message)")
                self.shop_names = server_message.components(separatedBy: ",")
//
                
                // Swift 處理JSON方法
                
//                do {
//                    let xxyy:Dictionary<String, Any> = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! Dictionary<String, Any>
//                    print(xxyy["Date"]!)
//                }
//                catch {
//                    print("伺服器json資料送來出錯！！錯誤是：\(error)")
//                }
                
                
                
                

                // 在執行緒中呼叫主緒
                DispatchQueue.main.async {
                    self.shop_table.dataSource = self
                    self.shop_table.reloadData()
                    self.busy.isHidden = true
                }
                
            }
        }
        
        
        task.resume()
        
        
        
        
    }
    
//MARK: - UITableViewDataSource的處理函數群
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        var rows_of_section:Int=0
//        switch section {
//        case 0:
//            rows_of_section = 3
//        case 1:
//            rows_of_section = 5
//        case 2:
//            rows_of_section = 2
//        default:
//            print("NOT HERE")
//        }
//
//
//        return rows_of_section
        
        return shop_names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell()
        
//        switch indexPath.section {
//        case 0:
//            cell.backgroundColor = UIColor.red
//        case 1:
//            cell.backgroundColor = UIColor.green
//        case 2:
//            cell.backgroundColor = UIColor.blue
//        default:
//            print("NOT HERE")
//        }
        
        cell.textLabel?.text = shop_names[indexPath.row]
        

        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        var header_of_section:String = ""
//        switch section {
//        case 0:
//            header_of_section = "城北便當"
//        case 1:
//            header_of_section = "城南便當"
//        case 2:
//            header_of_section = "好吃便當"
//        default:
//            print("NOT HERE")
//        }
//
//        return header_of_section
//    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        print(self.shop_names[indexPath.row])
    }
}
