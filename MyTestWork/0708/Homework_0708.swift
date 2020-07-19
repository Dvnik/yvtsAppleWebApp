//
//  ViewController.swift
//  push_notification
//
//  Created by Trixie Lulamoon on 2020/7/8.
//  Copyright © 2020 Trixie. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController
{
    @IBOutlet weak var score: UITextField!
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func read(_ sender: Any)
    {
        var root: DatabaseReference
        // 讀取Database
        let db:Database = Database.database()
        // 將reference讀出來
        root = db.reference()
        // 檢視所有的資料用snapshot把資料傳遞出來
        root.observe(.value)
        {
            (datasnapshot)
            in
            let json_data = datasnapshot.value! as! [String:Any]
            let array_data:[Any] = json_data["三年1班"] as! [Any]
            print("student 0 :\(array_data[0])")
            // 作業：取出數學成績-程式碼用純文字文件儲存
            // 取出第一位學生成績
            let johnData:[String:Any] = array_data[0] as! [String:Any]
            // 取出分數資料
            let scoreData:[String:Int] = johnData["score"]! as! [String:Int]
            print("score:\(scoreData)")
            // 取出數學成績印出到UITextField
            self.score.text = String(scoreData["math"]!)
        }
        
    }
    
    
    @IBAction func write(_ sender: Any)
    {
        
    }
    
}

