//
//  home.swift
//  super_controller2
//
//  Created by Trixie Lulamoon on 2020/7/2.
//  Copyright © 2020 Trixie Lulamoon. All rights reserved.
//

import UIKit
import WebKit

class home: UIViewController
{
    
    @IBOutlet weak var home_page: WKWebView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let difinite:URL = URL(string: "http://127.0.0.1/temp/error.html")!
        home_page.load(URLRequest(url: URL(string: "http://127.0.0.1/temp/gourmet/index.html") ?? difinite))
        
        
        print(NSHomeDirectory())
        if let order = UserDefaults().dictionary(forKey: "訂單") {
            print("\(order["便當名稱"]!) ===> \(order["價格"]!)")
        }
        else {
//            print("沒有訂單")
        }
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
