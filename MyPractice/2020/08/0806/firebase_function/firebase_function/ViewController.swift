//
//  ViewController.swift
//  firebase_function
//
//  Created by Trixie Lulamoon on 2020/8/6.
//  Copyright © 2020 Trixie. All rights reserved.
//

import UIKit
import FirebaseFunctions

class ViewController: UIViewController
{
    lazy var functions = Functions.functions()
    @IBOutlet weak var firebase_function_answer: UITextField!
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func get_answer_from_firebase_functions(_ sender: Any)
    {
        var callable:HTTPSCallable
        callable = functions.httpsCallable("addMessage")
        callable.call(["str": "john"]) {
            (http_result, err)
            in
            if let e = err
            {
                print("呼叫失敗！！\(e)")
            }
            else
            {
                
                print("呼叫成功！！結果是：\(http_result!)")
                let xxx = http_result!.data as! String
                print("呼叫成功！！結果是：\(xxx)")
            }
        }
    }
    
}

