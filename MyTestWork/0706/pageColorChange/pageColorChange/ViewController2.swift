//
//  ViewController2.swift
//  pageColorChange
//
//  Created by Trixie Lulamoon on 2020/7/6.
//  Copyright © 2020 yihsuan hong. All rights reserved.
//

import UIKit

class ViewController2: UIViewController
{
    //MARK: - Values
    var showBgColor: UIColor?
    
    @IBOutlet weak var backpageBtn: UIButton!
    
    //MARK: - Target Actions
    // 返回上一頁
    @IBAction func buttonBack(_ sender: Any)
    {
        self.dismiss(animated: true) { }
    }
    //MARK:-MyFunctions
    // 反轉按鈕上的文字讓按鈕顏色看得比較清楚
    func invertColor(color: UIColor) -> UIColor {
        var r:CGFloat = 0, g:CGFloat = 0, b:CGFloat = 0
        color.getRed(&r, green: &g, blue: &b, alpha: nil)
        return UIColor(red:1.0-r, green: 1.0-g, blue: 1.0-b, alpha: 1)
    }
    //MARK: - Life Cycle
    // view2載入完成
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //畫面初始為白色
        self.view.backgroundColor = UIColor.white
    }
    // view2即將出現
    override func viewWillAppear(_ animated: Bool)
    {
        // 假如顏色有設定到，就執行動畫
        if let bgColor = showBgColor
        {
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1, delay: 3.5, options: .curveEaseIn, animations: {
                   self.view.backgroundColor = bgColor
                   
               }, completion: nil)
            
            self.backpageBtn.setTitleColor(self.invertColor(color: bgColor), for: .normal)
        }
    }
}
