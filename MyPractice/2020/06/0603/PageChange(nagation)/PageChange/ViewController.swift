//
//  ViewController.swift
//  PageChange
//
//  Created by Trixie Lulamoon on 2020/6/3.
//  Copyright © 2020 Trixie Lulamoon. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    @IBOutlet weak var labelMessage: UILabel!
    
    @IBAction func buttonClick(_ sender: UIButton)
    {
        print("按鈕被按")
        sender.setTitle("喔喔！", for: UIControl.State.normal)
        labelMessage.text = "Hello World!"
    }
    
    override func viewDidLoad()
    {
        // 先執行父類別相同函式（已取得跟父類別相同的功能）
        super.viewDidLoad()
        // 才執行自己覆寫的功能
        print("view1載入完成")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("view1即將出現")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("view1已經出現")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        print("view1已經完成介面佈置")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 注意：進入背景畫面即將消失時，不會呼叫此事件!(除非是頁面轉換時)
        print("view1即將消失")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // 注意：進入背景畫面，並不會呼叫此事件！
        print("view1已經消失")
    }
    
    deinit
    {
        print("view1即將被釋放")
    }
}

