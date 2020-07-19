//
//  food.swift
//  super_controller2
//
//  Created by Trixie Lulamoon on 2020/7/2.
//  Copyright © 2020 Trixie Lulamoon. All rights reserved.
//

import UIKit

class food: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    enum TABLES:Int {
        case SHOPS = 111
        case FOODS = 222
    }
  
    
    @IBOutlet weak var shop_table: UITableView!
    
    @IBOutlet weak var food_table: UITableView!
    
    
    @IBOutlet weak var busy: UIActivityIndicatorView!
    
    var shop_names:[String] = []  // placeholder
    var 便當菜色:[String] = []  // placeholder
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let session:URLSession = URLSession(configuration: URLSessionConfiguration.default)
        let task:URLSessionDataTask = session.dataTask(
        with: URL(string: "http://127.0.0.1/temp/get_shop_name.php")!){
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
                let shop_array_from_server = server_message.components(separatedBy: ",")
                self.shop_names = shop_array_from_server
                
                // 在執行緒中呼叫主緒
                DispatchQueue.main.async {
                    self.shop_table.dataSource = self
                    self.shop_table.reloadData()
                    self.shop_table.delegate = self
                    
                    
                    self.busy.isHidden = true
                }
                
            }
        }
        task.resume()
        
        self.food_table.dataSource = self
        self.food_table.delegate = self
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK:- UITableViewDataSource函數群
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var value = 0
        if tableView.tag == TABLES.SHOPS.rawValue{
            value = self.shop_names.count
        }else{
            value = self.便當菜色.count
        }
        return value
    }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell()
        
        
        
        if tableView.tag == TABLES.SHOPS.rawValue{
            cell.textLabel?.text = self.shop_names[indexPath.row]
        }else{
            cell.textLabel?.text = self.便當菜色[indexPath.row]
        }
        
        
        
        
        return cell
    }
    
    //MARK:- UITableViewDelegate函數群
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        if tableView.tag == TABLES.SHOPS.rawValue{
            print("你選擇了\(self.shop_names[indexPath.row])")
            self.便當菜色.removeAll()
            //print("http://127.0.0.1/temp/get_food_list.php?shop_name=\(self.shop_names[indexPath.row])")
            
            
            let session:URLSession = URLSession(configuration: URLSessionConfiguration.default)
            let url_encode = self.shop_names[indexPath.row].addingPercentEncoding(
                withAllowedCharacters: NSCharacterSet.urlQueryAllowed
                 
            )!
            print("http://127.0.0.1/temp/get_food_list.php?shop_name=\(url_encode)")
            let task:URLSessionTask =  session.dataTask(with: URL(string: "http://127.0.0.1/temp/get_food_list.php?shop_name=\(url_encode)")!){
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
                    //print("server_message=\(server_message)")
                    let lines:[String] = server_message.components(separatedBy: "\n")

                    for index in 0 ..< lines.count{
                        
                        let key_value = lines[index].components(separatedBy: "==")
                        print(key_value)
                        self.便當菜色.append("便當名稱:\(key_value[0]) 價格:\(key_value[1])")
                    }
                    
                    
                    DispatchQueue.main.async {
                        self.food_table.reloadData()
                    }
                }
            }
            task.resume()
            
            
            
        }else if tableView.tag == TABLES.FOODS.rawValue{
            
            let bureau:NotificationCenter = NotificationCenter.default
            bureau.post(name: NSNotification.Name("OREDER_COME"), object: nil)
            print("發訂單囉！")
        }
        
        
        
    }

}
