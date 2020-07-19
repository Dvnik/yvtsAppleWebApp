//
//  ThirdViewController.swift
//  PageChange
//
//  Created by Trixie Lulamoon on 2020/6/5.
//  Copyright © 2020 Trixie Lulamoon. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController
{
    
    // 儲存第二頁的執行實體
    weak var secondVC:SecondViewController?
    // 儲存第一頁的執行實體
    weak var firstVC:FirstViewController?
    
    // 回上一頁
    @IBAction func buttonBack(_ sender: UIButton!)
    {
        self.secondVC?.labelMessage2.text = "我剛剛到過第三頁！！"
        // 退除自己的畫面
        self.navigationController?.popViewController(animated: true)
    }
    // 向右滑動回到上一頁
    @IBAction func swipeBack(_ sender: UISwipeGestureRecognizer)
    {
        // 按一下「回上一頁」按鈕
        self.buttonBack(nil)
    }
    
    
    
    // 回主頁
    @IBAction func buttonHome(_ sender: UIButton)
    {
        // 回寫第一頁的訊息
        self.firstVC?.labelMessage.text = "我剛剛到過第三頁"
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func buttonInfo(_ sender: UIButton)
    {
        // 從Storyboard上取得ID為InfoViewController類別，並且初始化！
       let infoVC = self.storyboard!.instantiateViewController(identifier: "InfoViewController") as! InfoViewController
       // 傳遞資訊
       infoVC.stringMessageInfo = "我是第三頁"
       // 顯示資訊頁
       self.show(infoVC, sender: nil)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("view3載入完成")
    }
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         
         print("view3即將出現")
     }
     
     override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
         
         print("view3已經出現")
     }

     override func viewDidLayoutSubviews() {
         super.viewDidLayoutSubviews()
         
         print("view3已經完成介面佈置")
     }
     
     override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
         // 注意：進入背景畫面即將消失時，不會呼叫此事件!(除非是頁面轉換時)
         print("view3即將消失")
     }
     
     override func viewDidDisappear(_ animated: Bool) {
         super.viewDidDisappear(animated)
         // 注意：進入背景畫面，並不會呼叫此事件！
         print("view3已經消失")
     }
    
     deinit
     {
         print("view3即將被釋放")
     }
}
