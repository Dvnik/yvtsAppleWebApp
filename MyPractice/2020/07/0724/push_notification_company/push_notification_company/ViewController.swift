//
//  ViewController.swift
//  push_notification_company
//
//  Created by Trixie Lulamoon on 2020/7/10.
//  Copyright © 2020 Trixie. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController
{
    
    @IBOutlet weak var account_txt: UITextField!
    
    @IBOutlet weak var password_txt: UITextField!
    //連結資料庫root元素的Reference(此處用Firebase)
    var root:DatabaseReference!
    //監聽線程的編號，用於完成登入後取消
    var observer:UInt!
    //MARK:- Swift Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        root =  Database.database().reference()
        
    }
    //MARK: - user Function
    //清空帳號密碼格
    @IBAction func reset(_ sender: Any)
    {
        account_txt.text = ""
        password_txt.text = ""
    }
    //登入
    @IBAction func login(_ sender: Any)
    {
        let sales = root.child("sales_managers")
        var is_manager = false
        // observe會監聽資料的改變並呼叫裡面閉包的方法，而登入完畢之後不需要持續監聽
        // 因此會先記錄observe回傳的線程UInt，用於完成登入之後停止監聽
        observer = sales.observe(DataEventType.value)
        {
            (ss)
            in
//            print(ss.value!)
            
            let manager_array:[[String:String]] = ss.value! as! [[String:String]]
            
            for manager:[String:String] in manager_array
            {
                if manager["account"] == self.account_txt.text
                &&
                   manager["password"] == self.password_txt.text
                {
                    is_manager = true
                    break
                }
            }
            
            if is_manager {
                print("OK")
                sales.removeObserver(withHandle: self.observer)
                print("remove Observer and fire segue.")
                self.performSegue(withIdentifier: "go", sender: sender)
            }
            else
            {
                print("NO")
            }
//            sales.removeAllObservers()
        }
    }
}

