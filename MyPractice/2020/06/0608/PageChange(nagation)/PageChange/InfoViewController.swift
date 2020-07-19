//
//  InfoViewController.swift
//  PageChange
//
//  Created by Trixie Lulamoon on 2020/6/5.
//  Copyright © 2020 Trixie Lulamoon. All rights reserved.
//

import UIKit
// 主要不用換頁線跳至此VC
class InfoViewController: UIViewController
{
    
    // 接收由其他頁傳來訊息
    var stringMessageInfo:String?

    @IBOutlet weak var labelMessageInfo: UILabel!
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        if let str = stringMessageInfo
        {
            labelMessageInfo.text = str
            
        }
        else
        {
            labelMessageInfo.text = "沒有資訊傳遞過來！"
            
        }
    }


}
