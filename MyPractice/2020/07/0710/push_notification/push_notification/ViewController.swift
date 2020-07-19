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
    
    @IBOutlet weak var busy: UIActivityIndicatorView!
    
    var root: DatabaseReference!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.busy.isHidden = true
        // Get reference
        // 讀取Database
        let db:Database = Database.database()
        // 將reference讀出來
        root = db.reference()
    }

    @IBAction func read(_ sender: Any)
    {
        self.busy.isHidden = false
        /*
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
        */
        // 直接循路徑節點抓取結果
        var math:DatabaseReference
        // 找出數學節點並儲存在math變數
        math = root.child("三年1班/2/score/math")
        // 取出數值
        math.observe(.value) { (datasnapshot) in
            print(datasnapshot.value!)
            // 在執行緒中呼叫主緒
            DispatchQueue.main.async {
                self.score.text = "\(datasnapshot.value!)"
                self.busy.isHidden = true
            }
        }
    }
    
    
    @IBAction func write(_ sender: Any)
    {
        let real_score:Int = Int(self.score.text!)!
        var math:DatabaseReference
        math = root.child("三年1班/2/score/math")
        math.setValue(real_score)
        
    }
    
}

