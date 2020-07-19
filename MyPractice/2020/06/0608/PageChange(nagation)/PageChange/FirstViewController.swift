//
//  ViewController.swift
//  PageChange
//
//  Created by Trixie Lulamoon on 2020/6/3.
//  Copyright © 2020 Trixie Lulamoon. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController
{
    //預設一個儲存傳遞資料的屬性（由第一頁存入）
    @IBOutlet weak var labelMessage: UILabel!
    
    
    // 請按我一下按鈕
    @IBAction func buttonClick(_ sender: UIButton)
    {
        print("按鈕被按")
        sender.setTitle("喔喔！", for: UIControl.State.normal)
        labelMessage.text = "Hello World!"
    }
    // 資訊頁(自行載入)按鈕
    @IBAction func buttonInfo(_ sender: UIButton)
    {
        // 從Storyboard上取得ID為InfoViewController類別，並且初始化！
        let infoVC = self.storyboard!.instantiateViewController(identifier: "InfoViewController") as! InfoViewController
        // 傳遞資訊
        infoVC.stringMessageInfo = "我是第一頁"
        // 顯示資訊頁
        self.show(infoVC, sender: nil)
    }
    // 向左滑動翻頁
    @IBAction func swipeToNext(_ sender: UISwipeGestureRecognizer)
    {
        // 執行換頁線
        self.performSegue(withIdentifier: "ToVC2", sender: nil)
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
    // 即將由連接線換頁
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        // 確認由特定的連接線執行換頁
        if segue.identifier == "ToVC2"
        {
            // 由連接線的轉換端取得下一頁的執行實體（注意：必須完成精確轉型！）
            let vc2 = segue.destination as! SecondViewController
            // 直接對下一頁的執行實體，進行屬性傳遞(值型別的傳遞)
            vc2.stringMessage = "Hello!!!"
            // 直接對下一頁的執行實體，進行屬性傳遞(引用別的傳遞)
            vc2.firstVC = self
            //以下錯誤，因為第二頁實體才剛完成初始化，@IBoutlet目前暫時還沒相關的實體存入！
//            vc2.labelMessage2.text = "Hello!!!"
        }
        
    }
    
    deinit
    {
        print("view1即將被釋放")
    }
}

